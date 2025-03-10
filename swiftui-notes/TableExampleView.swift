import SwiftUI

// 定义数据模型
struct Person: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let email: String
    let role: String
    let status: Status
    let joinDate: Date
    
    enum Status: String {
        case active = "Active"
        case inactive = "Inactive"
        case pending = "Pending"
        
        var color: Color {
            switch self {
            case .active: return .green
            case .inactive: return .red
            case .pending: return .orange
            }
        }
    }
}

struct TableExampleView: View {
    // 示例数据
    @State private var people: [Person] = [
        Person(name: "John Doe", age: 30, email: "john@example.com", role: "Developer", status: .active, joinDate: Date().addingTimeInterval(-60*60*24*365)),
        Person(name: "Jane Smith", age: 28, email: "jane@example.com", role: "Designer", status: .active, joinDate: Date().addingTimeInterval(-60*60*24*180)),
        Person(name: "Bob Johnson", age: 35, email: "bob@example.com", role: "Manager", status: .inactive, joinDate: Date().addingTimeInterval(-60*60*24*90)),
        Person(name: "Alice Brown", age: 25, email: "alice@example.com", role: "Developer", status: .pending, joinDate: Date().addingTimeInterval(-60*60*24*30)),
        Person(name: "Charlie Wilson", age: 32, email: "charlie@example.com", role: "Designer", status: .active, joinDate: Date().addingTimeInterval(-60*60*24*15))
    ]
    
    @State private var sortOrder = [KeyPathComparator(\Person.name)]
    @State private var selection: Set<Person.ID> = []
    @State private var searchText = ""
    @State private var showingDetail: Person?
    
    var body: some View {
        NavigationStack {
            Group {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // iPad 显示表格
                    tableView
                } else {
                    // iPhone 显示列表
                    listView
                }
            }
            .navigationTitle("Team Members")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        // 添加新成员
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("Export Selected") {
                            // 导出选中项
                        }
                        .disabled(selection.isEmpty)
                        
                        Button("Export All") {
                            // 导出全部
                        }
                        
                        Divider()
                        
                        Menu("Filter") {
                            Button("All Members") {}
                            Button("Active Members") {}
                            Button("Inactive Members") {}
                            Button("Pending Members") {}
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
    
    // 表格视图 (iPad)
    private var tableView: some View {
        Table(people, selection: $selection, sortOrder: $sortOrder) {
            // 名字列（可排序）
            TableColumn("Name", value: \.name) { person in
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundStyle(.blue)
                    Text(person.name)
                        .bold()
                }
            }
            
            // 年龄列（可排序）
            TableColumn("Age", value: \.age) { person in
                Text("\(person.age)")
                    .monospacedDigit()
            }
            
            // 邮箱列
            TableColumn("Email", value: \.email)
            
            // 角色列（可排序）
            TableColumn("Role", value: \.role) { person in
                Text(person.role)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.blue.opacity(0.1))
                    .cornerRadius(6)
            }
            
            // 状态列
            TableColumn("Status", value: \.status.rawValue) { person in
                HStack {
                    Circle()
                        .fill(person.status.color)
                        .frame(width: 8, height: 8)
                    Text(person.status.rawValue)
                }
            }
            
            // 加入日期列（可排序）
            TableColumn("Join Date", value: \.joinDate) { person in
                Text(person.joinDate, style: .date)
            }
        }
    }
    
    // 列表视图 (iPhone)
    private var listView: some View {
        List(people) { person in
            NavigationLink {
                PersonDetailView(person: person)
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .foregroundStyle(.blue)
                        Text(person.name)
                            .font(.headline)
                        Spacer()
                        StatusView(status: person.status)
                    }
                    
                    Text(person.role)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Text(person.email)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
        }
    }
}

// 状态视图组件
struct StatusView: View {
    let status: Person.Status
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(status.color)
                .frame(width: 8, height: 8)
            Text(status.rawValue)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// 详情视图
struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        List {
            Section {
                LabeledContent("Name", value: person.name)
                LabeledContent("Age", value: "\(person.age)")
                LabeledContent("Email", value: person.email)
                LabeledContent("Role", value: person.role)
                LabeledContent("Status") {
                    StatusView(status: person.status)
                }
                LabeledContent("Join Date") {
                    Text(person.joinDate, style: .date)
                }
            }
        }
        .navigationTitle(person.name)
    }
}

#Preview {
    TableExampleView()
} 