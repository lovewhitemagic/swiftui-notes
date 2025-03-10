import SwiftUI

// MARK: - Basic Layout
struct BasicToolbarLayout: View {
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Basic Layout")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") { }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sort", systemImage: "arrow.up.arrow.down") { }
                }
            }
        }
    }
}

// MARK: - Group Layout
struct GroupToolbarLayout: View {
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Group Layout")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") { }
                    Button("Sort", systemImage: "arrow.up.arrow.down") { }
                    Button("Filter", systemImage: "line.3.horizontal.decrease.circle") { }
                }
            }
        }
    }
}

// MARK: - Mixed Layout
struct MixedToolbarLayout: View {
    @State private var sortOption = SortOption.name
    
    enum SortOption {
        case name, date, priority
    }
    
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Mixed Layout")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") { }
                    
                    Menu {
                        Picker("Sort", selection: $sortOption) {
                            Text("Name").tag(SortOption.name)
                            Text("Date").tag(SortOption.date)
                            Text("Priority").tag(SortOption.priority)
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        }
    }
}

// MARK: - Bottom Layout
struct BottomToolbarLayout: View {
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Bottom Layout")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share")
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "heart")
                            Text("Favorite")
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Mixed Bottom Layout
struct MixedBottomToolbarLayout: View {
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Mixed Bottom Layout")
            .toolbar {
                // 顶部工具栏
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", systemImage: "plus") { }
                }
                
                // 底部工具栏
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {}) {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "heart")
                        }
                        Button(action: {}) {
                            Image(systemName: "star")
                        }
                    }
                    
                    Spacer()
                    
                    Menu {
                        Button("Option 1", action: {})
                        Button("Option 2", action: {})
                        Button("Option 3", action: {})
                    } label: {
                        Label("More", systemImage: "ellipsis.circle")
                    }
                }
            }
            .toolbarBackground(.visible, for: .bottomBar)
        }
    }
}

// MARK: - Status Bar Layout
struct StatusBarToolbarLayout: View {
    @State private var progress = 0.0
    
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Status Bar Layout")
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
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.green, for: .navigationBar)
        }
    }
}

// MARK: - Inline Title Layout
struct InlineTitleToolbarLayout: View {
    var body: some View {
        NavigationStack {
            List(1...5, id: \.self) { item in
                Text("Item \(item)")
            }
            .navigationTitle("Inline Title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Inline Title")
                            .font(.headline)
                        Spacer()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Search", systemImage: "magnifyingglass") { }
                    Button("More", systemImage: "ellipsis.circle") { }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.blue.opacity(0.2), for: .navigationBar)
        }
    }
}

// MARK: - Previews
#Preview("Basic Layout") {
    BasicToolbarLayout()
}

#Preview("Group Layout") {
    GroupToolbarLayout()
}

#Preview("Mixed Layout") {
    MixedToolbarLayout()
}

#Preview("Bottom Layout") {
    BottomToolbarLayout()
}

#Preview("Mixed Bottom Layout") {
    MixedBottomToolbarLayout()
}

#Preview("Status Bar Layout") {
    StatusBarToolbarLayout()
}

#Preview("Inline Title Layout") {
    InlineTitleToolbarLayout()
}