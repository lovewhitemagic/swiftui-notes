import SwiftUI

// 定义导航项数据模型
struct MenuItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    var items: [MenuItem]? // 子项
}

struct SidebarExampleView: View {
    // 示例数据
    let menuItems: [MenuItem] = [
        MenuItem(title: "Dashboard", icon: "gauge", items: nil),
        MenuItem(title: "Files", icon: "folder", items: [
            MenuItem(title: "Documents", icon: "doc", items: nil),
            MenuItem(title: "Pictures", icon: "photo", items: nil),
            MenuItem(title: "Downloads", icon: "arrow.down.circle", items: nil)
        ]),
        MenuItem(title: "Messages", icon: "message", items: [
            MenuItem(title: "Inbox", icon: "tray", items: nil),
            MenuItem(title: "Sent", icon: "paperplane", items: nil),
            MenuItem(title: "Trash", icon: "trash", items: nil)
        ]),
        MenuItem(title: "Settings", icon: "gear", items: nil)
    ]
    
    @State private var selectedItem: MenuItem?
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            // 侧边栏
            List(menuItems, selection: $selectedItem) { item in
                if let subitems = item.items {
                    Section(item.title) {
                        ForEach(subitems) { subitem in
                            NavigationLink(value: subitem) {
                                Label(subitem.title, systemImage: subitem.icon)
                            }
                        }
                    }
                } else {
                    NavigationLink(value: item) {
                        Label(item.title, systemImage: item.icon)
                    }
                }
            }
            .navigationTitle("Sidebar")
            .listStyle(.sidebar) // 使用侧边栏样式
            
        } detail: {
            // 详情视图
            if let selectedItem {
                DetailView(item: selectedItem)
            } else {
                ContentUnavailableView(
                    "No Selection",
                    systemImage: "sidebar.left",
                    description: Text("Select an item from the sidebar")
                )
            }
        }
        .navigationSplitViewStyle(.balanced) // 平衡列宽
    }
}

// 详情视图
struct DetailView: View {
    let item: MenuItem
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    LabeledContent("Title") {
                        Text(item.title)
                    }
                    LabeledContent("Icon") {
                        Image(systemName: item.icon)
                    }
                }
                
                // 示例内容
                Section("Content") {
                    ForEach(1...20, id: \.self) { index in
                        Label(
                            "Item \(index)",
                            systemImage: "doc"
                        )
                    }
                }
            }
            .navigationTitle(item.title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // 添加操作
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("Sort by Name") {}
                        Button("Sort by Date") {}
                        Divider()
                        Button("Show Hidden Files") {}
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    SidebarExampleView()
} 