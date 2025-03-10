import SwiftUI

struct FeedbackTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 首页
            NavigationStack {
                List {
                    ForEach(1...20, id: \.self) { index in
                        Text("Home Item \(index)")
                    }
                }
                .navigationTitle("Home")
            }
            .tabItem {
                CustomTabItem(
                    imageName: "house",
                    title: "Home",
                    isSelected: selectedTab == 0,
                    action: { selectedTab = 0 }
                )
            }
            .tag(0)
            
            // 收藏页
            NavigationStack {
                List {
                    ForEach(1...20, id: \.self) { index in
                        Text("Favorite Item \(index)")
                    }
                }
                .navigationTitle("Favorites")
            }
            .tabItem {
                CustomTabItem(
                    imageName: "star",
                    title: "Favorites",
                    isSelected: selectedTab == 1,
                    action: { selectedTab = 1 }
                )
            }
            .tag(1)
            
            // 设置页
            NavigationStack {
                List {
                    ForEach(1...20, id: \.self) { index in
                        Text("Setting Item \(index)")
                    }
                }
                .navigationTitle("Settings")
            }
            .tabItem {
                CustomTabItem(
                    imageName: "gearshape",
                    title: "Settings",
                    isSelected: selectedTab == 2,
                    action: { selectedTab = 2 }
                )
            }
            .tag(2)
        }
        .tint(.blue)  // 设置选中颜色
    }
}

// MARK: - 自定义标签项
struct CustomTabItem: View {
    let imageName: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: imageName)
                    .symbolVariant(isSelected ? .fill : .none)
                    .font(.system(size: 24))
                
                Text(title)
                    .font(.caption)
            }
        }
        .sensoryFeedback(.impact(weight: .light), trigger: isSelected) // 使用轻微冲击反馈
        .opacity(isSelected ? 1 : 0.7)  // 未选中时降低透明度
    }
}

#Preview {
    FeedbackTabView()
} 