import SwiftUI

// MARK: - Basic Sheet Examples
struct BasicSheetLayout: View {
    @State private var showBasicSheet = false
    @State private var showCustomSheet = false
    @State private var showFullScreenSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            // 基本 Sheet
            Button("Show Basic Sheet") {
                showBasicSheet.toggle()
            }
            .sheet(isPresented: $showBasicSheet) {
                BasicSheetContent()
            }
            
            // 自定义样式 Sheet
            Button("Show Styled Sheet") {
                showCustomSheet.toggle()
            }
            .sheet(isPresented: $showCustomSheet) {
                StyledSheetContent()
                    .presentationBackground(.ultraThinMaterial)
                    .presentationCornerRadius(25)
            }
            
            // 全屏 Sheet
            Button("Show Fullscreen Sheet") {
                showFullScreenSheet.toggle()
            }
            .fullScreenCover(isPresented: $showFullScreenSheet) {
                FullscreenSheetContent(isPresented: $showFullScreenSheet)
            }
        }
    }
}

// MARK: - Sheet Contents
struct BasicSheetContent: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Basic Sheet")
                    .font(.title)
                Button("Dismiss") {
                    dismiss()
                }
            }
            .padding()
            .navigationTitle("Basic Sheet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct StyledSheetContent: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 40, height: 5)
                .foregroundStyle(.gray)
            
            Text("Styled Sheet")
                .font(.title)
            
            Button("Close", role: .cancel) {
                dismiss()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct FullscreenSheetContent: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(1...5, id: \.self) { item in
                    Text("Item \(item)")
                }
            }
            .navigationTitle("Fullscreen Sheet")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

// MARK: - Interactive Sheet Examples
struct InteractiveSheetLayout: View {
    @State private var showSheet = false
    @State private var selectedDetent: PresentationDetent = .medium
    @State private var isDragDisabled = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Interactive Sheet") {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet) {
                NavigationStack {
                    List {
                        Section("Sheet Height") {
                            Button("Small") {
                                selectedDetent = .height(200)
                            }
                            Button("Medium") {
                                selectedDetent = .medium
                            }
                            Button("Large") {
                                selectedDetent = .large
                            }
                        }
                        
                        Section("Interaction") {
                            Toggle("Disable Drag", isOn: $isDragDisabled)
                        }
                    }
                    .navigationTitle("Interactive Sheet")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                showSheet = false
                            }
                        }
                    }
                }
                .presentationDetents([.height(200), .medium, .large],
                                   selection: $selectedDetent)
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled(isDragDisabled)
            }
        }
    }
}

// MARK: - Form Sheet Example
struct FormSheetLayout: View {
    @State private var showSheet = false
    @State private var name = ""
    @State private var email = ""
    @State private var age = 18
    @State private var notifications = false
    
    var body: some View {
        Button("Show Form Sheet") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            NavigationStack {
                Form {
                    Section("Personal Info") {
                        TextField("Name", text: $name)
                        TextField("Email", text: $email)
                        Stepper("Age: \(age)", value: $age, in: 1...100)
                    }
                    
                    Section("Preferences") {
                        Toggle("Enable Notifications", isOn: $notifications)
                    }
                    
                    Section {
                        Button("Submit") {
                            // Handle form submission
                            showSheet = false
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                    }
                }
                .navigationTitle("Profile Form")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Cancel") {
                            showSheet = false
                        }
                    }
                }
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Media Sheet Example
struct MediaSheetLayout: View {
    @State private var showSheet = false
    @State private var isPlaying = false
    @State private var progress: Double = 0
    
    var body: some View {
        Button("Show Media Sheet") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 20) {
                // Media Content
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.2))
                    .frame(height: 200)
                    .overlay {
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 50))
                            .opacity(isPlaying ? 0 : 1)
                    }
                
                // Controls
                VStack(spacing: 10) {
                    Text("Media Title")
                        .font(.title2)
                    Text("Subtitle")
                        .foregroundStyle(.secondary)
                    
                    // Progress Bar
                    ProgressView(value: progress, total: 100)
                        .padding(.horizontal)
                    
                    // Control Buttons
                    HStack(spacing: 40) {
                        Button(action: {}) {
                            Image(systemName: "backward.fill")
                                .font(.title2)
                        }
                        
                        Button {
                            isPlaying.toggle()
                        } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.title)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "forward.fill")
                                .font(.title2)
                        }
                    }
                }
                .padding()
            }
            .presentationDetents([.height(400)])
            .presentationBackground(.ultraThinMaterial)
            .presentationCornerRadius(30)
        }
    }
}

// MARK: - Sheet with Item
struct DetailItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct ItemSheetLayout: View {
    @State private var selectedItem: DetailItem?
    
    let items = [
        DetailItem(title: "Item 1", description: "Description 1"),
        DetailItem(title: "Item 2", description: "Description 2")
    ]
    
    var body: some View {
        List(items, id: \.id) { item in
            Button(item.title) {
                selectedItem = item
            }
        }
        .sheet(item: $selectedItem) { item in
            // 基于 item 的 sheet 内容
            NavigationStack {
                VStack {
                    Text(item.title)
                        .font(.title)
                    Text(item.description)
                }
                .padding()
                .navigationTitle(item.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            selectedItem = nil
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Sheet with Multiple Views
struct MultiViewSheetLayout: View {
    @State private var showSheet = false
    @State private var currentTab = 0
    
    var body: some View {
        Button("Show Multi-View Sheet") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            NavigationStack {
                TabView(selection: $currentTab) {
                    Text("View 1")
                        .tabItem {
                            Label("Tab 1", systemImage: "1.circle")
                        }
                        .tag(0)
                    
                    Text("View 2")
                        .tabItem {
                            Label("Tab 2", systemImage: "2.circle")
                        }
                        .tag(1)
                }
                .navigationTitle("Multi-View Sheet")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            showSheet = false
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Main View
struct SheetExamplesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Basic Sheets") {
                    BasicSheetLayout()
                }
                
                Section("Interactive Sheet") {
                    InteractiveSheetLayout()
                }
                
                Section("Form Sheet") {
                    FormSheetLayout()
                }
                
                Section("Media Sheet") {
                    MediaSheetLayout()
                }
                
                Section("Item Sheet") {
                    ItemSheetLayout()
                }
                
                Section("Multi-View Sheet") {
                    MultiViewSheetLayout()
                }
            }
            .navigationTitle("Sheet Examples")
        }
    }
}

// MARK: - Previews
#Preview("All Sheets") {
    SheetExamplesView()
}

#Preview("Basic Sheets") {
    BasicSheetLayout()
}

#Preview("Interactive Sheet") {
    InteractiveSheetLayout()
}

#Preview("Form Sheet") {
    FormSheetLayout()
}

#Preview("Media Sheet") {
    MediaSheetLayout()
} 