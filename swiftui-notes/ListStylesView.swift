import SwiftUI

struct ListStylesView: View {
    var body: some View {
        TabView {
            // 默认样式
            DefaultListView()
                .tabItem {
                    Label("Default", systemImage: "list.bullet")
                }
            
            // 分组样式
            GroupedListView()
                .tabItem {
                    Label("Grouped", systemImage: "list.bullet.indent")
                }
            
            // 侧边栏样式
            SidebarListView()
                .tabItem {
                    Label("Sidebar", systemImage: "sidebar.left")
                }
            
            // 插入样式
            InsetListView()
                .tabItem {
                    Label("Inset", systemImage: "list.dash")
                }
            
            // 带计数的样式
            InsetGroupedListView()
                .tabItem {
                    Label("InsetGrouped", systemImage: "list.number")
                }
        }
    }
}

// MARK: - 默认样式
struct DefaultListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Default Style") {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
            }
            .navigationTitle("Default")
            .listStyle(.plain)
        }
    }
}

// MARK: - 分组样式
struct GroupedListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Group 1") {
                    Text("Item 1")
                    Text("Item 2")
                }
                
                Section("Group 2") {
                    Text("Item 3")
                    Text("Item 4")
                }
            }
            .navigationTitle("Grouped")
            .listStyle(.grouped)
        }
    }
}

// MARK: - 侧边栏样式
struct SidebarListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Favorites") {
                    Label("Home", systemImage: "house")
                    Label("Settings", systemImage: "gear")
                }
                
                Section("Recent") {
                    Label("Documents", systemImage: "doc")
                    Label("Downloads", systemImage: "arrow.down.circle")
                }
            }
            .navigationTitle("Sidebar")
            .listStyle(.sidebar)
        }
    }
}

// MARK: - 插入样式
struct InsetListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Inset Style") {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
            }
            .navigationTitle("Inset")
            .listStyle(.inset)
        }
    }
}

// MARK: - 插入分组样式
struct InsetGroupedListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Group A") {
                    Text("Item 1")
                    Text("Item 2")
                }
                
                Section("Group B") {
                    Text("Item 3")
                    Text("Item 4")
                }
            }
            .navigationTitle("Inset Grouped")
            .listStyle(.insetGrouped)
        }
    }
}

// MARK: - 基础分组样式
struct BasicGroupedListView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Item 1")
                }
                
                Section {
                    Text("Item 2")
                }
                
                Section {
                    Text("Item 3")
                }
                
                Section {
                    Text("Item 4")
                }
            }
            .navigationTitle("Basic Grouped")
            .listStyle(.insetGrouped)
        }
    }
}

#Preview("All Styles") {
    ListStylesView()
}

// 单独预览每种样式
#Preview("Default") {
    DefaultListView()
}

#Preview("Grouped") {
    GroupedListView()
}

#Preview("Sidebar") {
    SidebarListView()
}

#Preview("Inset") {
    InsetListView()
}

#Preview("InsetGrouped") {
    InsetGroupedListView()
}

#Preview("Basic Grouped") {
    BasicGroupedListView()
} 