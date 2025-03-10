import SwiftUI

struct ColorPickerSheetView: View {
    @State private var showSheet = false
    @State private var selectedColor: Color = .blue
    
    var body: some View {
        NavigationStack {
            VStack {
                // 显示选中的颜色
                RoundedRectangle(cornerRadius: 20)
                    .fill(selectedColor)
                    .frame(height: 200)
                    .padding()
                    //.shadow(radius: 5)
                Spacer()
                Button("选择颜色") {
                    showSheet = true
                }
                .buttonStyle(.borderedProminent)
                Spacer(minLength: 400)
            }
            .navigationTitle("自定义sheet+scollview")
        }
        .sheet(isPresented: $showSheet) {
            ColorPickerSheet(selectedColor: $selectedColor)
                .presentationBackground(.clear)
                .presentationDetents([.height(200)])
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
        }
    }
}

struct ColorPickerSheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedColor: Color
    
    // 预定义的颜色数组
    private let colors: [Color] = [
        .red, .orange, .yellow, .green,
        .blue, .indigo, .purple, .pink
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部栏
            HStack {
                Text("选择颜色")
                    .font(.headline)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                        .font(.title2)
                }
            }
            .padding()
            
            // 颜色选择器
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        ColorButton(color: color, isSelected: color == selectedColor) {
                            selectedColor = color
                            //dismiss()
                        }
                    }
                }
                .padding()
            }
            .frame(maxHeight: 100)
            
            // 预览区域
            /*RoundedRectangle(cornerRadius: 15)
                .fill(selectedColor)
                .frame(height: 150)
                .padding()
                .shadow(radius: 3)*/
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct ColorButton: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(width: 60, height: 60)
        }
    }
}

#Preview {
    ColorPickerSheetView()
} 