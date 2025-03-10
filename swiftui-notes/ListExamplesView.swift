import SwiftUI

// MARK: - Basic List Item
struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

// MARK: - Main View
struct ListExamplesView: View {
    @State private var selectedItems = Set<UUID>()
    @State private var editMode: EditMode = .inactive
    @State private var searchText = ""
    @State private var items = [
        ListItem(title: "First Item", subtitle: "Description 1"),
        ListItem(title: "Second Item", subtitle: "Description 2"),
        ListItem(title: "Third Item", subtitle: "Description 3"),
        ListItem(title: "Fourth Item", subtitle: "Description 4")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                // MARK: - Basic Lists
                Section("Basic Style") {
                    // 简单文本列表
                    Text("Simple Text Row")
                    
                    // 带图标的行
                    Label("With Icon", systemImage: "star.fill")
                    
                    // 自定义内容行
                    HStack {
                        Image(systemName: "person.circle")
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text("Custom Row")
                                .font(.headline)
                            Text("With subtitle")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                // MARK: - Selection Style
                Section("Selection Styles") {
                    // 单选样式
                    ForEach(items) { item in
                        NavigationLink(destination: Text(item.title)) {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                Text(item.subtitle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                
                // MARK: - Multiple Selection
                Section("Multiple Selection") {
                    ForEach(items) { item in
                        MultipleSelectionRow(title: item.title,
                                          isSelected: selectedItems.contains(item.id)) {
                            if selectedItems.contains(item.id) {
                                selectedItems.remove(item.id)
                            } else {
                                selectedItems.insert(item.id)
                            }
                        }
                    }
                }
                
                // MARK: - Swipe Actions
                Section("Swipe Actions") {
                    ForEach(items) { item in
                        Text(item.title)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    if let index = items.firstIndex(where: { $0.id == item.id }) {
                                        items.remove(at: index)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    // 收藏操作
                                } label: {
                                    Label("Favorite", systemImage: "star")
                                }
                                .tint(.yellow)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    // 归档操作
                                } label: {
                                    Label("Archive", systemImage: "archivebox")
                                }
                                .tint(.blue)
                            }
                    }
                }
                
                // MARK: - List Styling
                Section("Custom Styling") {
                    Text("Rounded Style")
                        .listRowBackground(Color.blue.opacity(0.1))
                    
                    Text("Custom Background")
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.green.opacity(0.1))
                                .padding(2)
                        )
                    
                    Text("With Separator")
                        .listRowSeparator(.visible)
                    
                    Text("No Separator")
                        .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("List Examples")
            .searchable(text: $searchText, prompt: "Search items")
            .refreshable {
                // 下拉刷新操作
                await refreshItems()
            }
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func refreshItems() async {
        // 模拟刷新操作
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
}

// MARK: - Multiple Selection Row
struct MultipleSelectionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ListExamplesView()
} 