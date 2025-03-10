import SwiftUI

struct ListSectionSpacingView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Section 1") {
                    Text("Item 1")
                    Text("Item 2")
                    Text("Item 3")
                }
                
                Section("Section 2") {
                    Text("Item 4")
                    Text("Item 5")
                    Text("Item 6")
                }
                .listSectionSpacing(.compact) // 紧凑样式
            }
            .navigationTitle("Section Spacing")
        }
    }
}

// 添加新的预览，展示 footer 和无 section 的样式
struct ListWithFooterView: View {
    var body: some View {
        NavigationStack {
            List {
                // 带有 header 和 footer 的 section
                Section(header: Text("With Footer"),
                        footer: Text("This is a footer explanation")) {
                    Text("Item 1")
                    Text("Item 2")
                }
                
                // 直接使用列表项，不包含在 section 中
                Text("No Section Item 1")
                Text("No Section Item 2")
                Text("No Section Item 3")
            }
            .navigationTitle("Footer Example")
        }
    }
}

#Preview("Default") {
    ListSectionSpacingView()
}

#Preview("With Footer") {
    ListWithFooterView()
}

