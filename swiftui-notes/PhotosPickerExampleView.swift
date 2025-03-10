import SwiftUI
import PhotosUI

struct PhotosPickerExampleView: View {
    // 单张图片选择
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    // 多张图片选择
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [Image] = []
    
    // 视频选择
    @State private var selectedVideo: PhotosPickerItem?
    @State private var videoURL: URL?
    
    // 选择限制
    @State private var limitedItems: [PhotosPickerItem] = []
    
    // 筛选类型
    @State private var filteredItems: [PhotosPickerItem] = []
    
    var body: some View {
        NavigationStack {
            List {
                // 单张图片选择
                Section("Single Image Selection") {
                    VStack {
                        if let selectedImage {
                            selectedImage
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        }
                        
                        PhotosPicker(selection: $selectedItem,
                                   matching: .images) {
                            Label("Select Photo", systemImage: "photo.fill")
                        }
                    }
                }
                
                // 多张图片选择
                Section("Multiple Images Selection") {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(selectedImages.indices, id: \.self) { index in
                                selectedImages[index]
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                    .frame(height: selectedImages.isEmpty ? 0 : 120)
                    
                    PhotosPicker(selection: $selectedItems,
                               maxSelectionCount: 5,
                               matching: .images) {
                        Label("Select Multiple Photos (Max 5)", systemImage: "photo.stack.fill")
                    }
                }
                
                // 视频选择
                Section("Video Selection") {
                    if let videoURL {
                        Text("Selected video: \(videoURL.lastPathComponent)")
                    }
                    
                    PhotosPicker(selection: $selectedVideo,
                               matching: .videos) {
                        Label("Select Video", systemImage: "video.fill")
                    }
                }
                
                // 带筛选的选择器
                Section("Filtered Selection") {
                    PhotosPicker(selection: $filteredItems,
                               matching: .images,
                               preferredItemEncoding: .automatic) {
                        Label("Select Live Photos", systemImage: "livephoto")
                    }
                    .onChange(of: filteredItems) {
                        // 处理选择的 Live Photos
                    }
                }
                
                // 自定义样式的选择器
                Section("Custom Styled Picker") {
                    PhotosPicker(selection: $selectedItem) {
                        VStack {
                            Image(systemName: "photo.circle.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(.blue)
                            Text("Tap to select")
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .navigationTitle("PhotosPicker")
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            selectedImage = Image(uiImage: uiImage)
                            return
                        }
                    }
                }
            }
            .onChange(of: selectedItems) {
                Task {
                    selectedImages.removeAll()
                    for item in selectedItems {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                selectedImages.append(Image(uiImage: uiImage))
                            }
                        }
                    }
                }
            }
            .onChange(of: selectedVideo) {
                Task {
                    if let video = try? await selectedVideo?.loadTransferable(type: Movie.self) {
                        videoURL = video.url
                    }
                }
            }
        }
    }
}

// 用于视频加载的辅助结构体
struct Movie: Transferable {
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            let copy = URL.documentsDirectory.appending(path: "movie.mov")
            
            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }
            
            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(url: copy)
        }
    }
}

#Preview {
    PhotosPickerExampleView()
} 