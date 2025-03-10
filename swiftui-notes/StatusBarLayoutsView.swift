import SwiftUI

// MARK: - Basic Status Layout
struct BasicStatusLayout: View {
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Basic Status")
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text("Ready")
                        .foregroundStyle(.green)
                }
            }
            .toolbarBackground(.visible, for: .bottomBar)
        }
    }
}

// MARK: - Progress Status Layout
struct ProgressStatusLayout: View {
    @State private var progress = 0.0
    
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Progress Status")
            .toolbar {
                ToolbarItem(placement: .status) {
                    HStack {
                        ProgressView(value: progress, total: 100)
                            .progressViewStyle(.linear)
                            .frame(width: 100)
                        Text("\(Int(progress))%")
                    }
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Decrease") {
                        withAnimation {
                            progress = max(0, progress - 20)
                        }
                    }
                    
                    Spacer()
                    
                    Button("Increase") {
                        withAnimation {
                            progress = min(100, progress + 20)
                        }
                    }
                }
            }
            .toolbarBackground(.visible, for: .bottomBar)
        }
    }
}

// MARK: - Loading Status Layout
struct LoadingStatusLayout: View {
    @State private var isLoading = false
    @State private var status = "Ready"
    
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Loading Status")
            .toolbar {
                ToolbarItem(placement: .status) {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .scaleEffect(0.7)
                        }
                        Text(status)
                            .foregroundStyle(status == "Ready" ? .green : .blue)
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button(isLoading ? "Stop Loading" : "Start Loading") {
                        isLoading.toggle()
                        status = isLoading ? "Loading..." : "Ready"
                    }
                    .buttonStyle(.bordered)
                }
            }
            .toolbarBackground(.visible, for: .bottomBar)
        }
    }
}

// MARK: - Complex Status Layout
struct ComplexStatusLayout: View {
    @State private var isLoading = false
    @State private var progress = 0.0
    @State private var status = "Ready"
    
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Complex Status")
            .toolbar {
                // 状态文本
                ToolbarItem(placement: .status) {
                    Text(status)
                        .foregroundStyle(status == "Ready" ? .green : .blue)
                }
                
                // 进度指示器
                ToolbarItem(placement: .status) {
                    HStack(spacing: 8) {
                        if isLoading {
                            ProgressView()
                                .scaleEffect(0.7)
                        }
                        ProgressView(value: progress, total: 100)
                            .progressViewStyle(.linear)
                            .frame(width: 100)
                        Text("\(Int(progress))%")
                    }
                }
                
                // 控制按钮
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(isLoading ? "Stop" : "Start") {
                        isLoading.toggle()
                        status = isLoading ? "Processing..." : "Ready"
                    }
                    
                    Spacer()
                    
                    Button("Reset") {
                        progress = 0
                        isLoading = false
                        status = "Ready"
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button("-20%") {
                            withAnimation {
                                progress = max(0, progress - 20)
                            }
                        }
                        Button("+20%") {
                            withAnimation {
                                progress = min(100, progress + 20)
                            }
                        }
                    }
                }
            }
            .toolbarBackground(.visible, for: .bottomBar)
        }
    }
}

// MARK: - Previews
#Preview("Basic Status") {
    BasicStatusLayout()
}

#Preview("Progress Status") {
    ProgressStatusLayout()
}

#Preview("Loading Status") {
    LoadingStatusLayout()
}

#Preview("Complex Status") {
    ComplexStatusLayout()
} 
