import SwiftUI

struct IconTabView: View {
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
             
        
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .frame(width: 40, height: 40)
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
                VStack {
                    Spacer().frame(height: 10)  // 添加顶部空间
                    Image(systemName: selectedTab == 1 ? "star.fill" : "star")
                }
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
                VStack {
                    Spacer().frame(height: 10)  // 添加顶部空间
                    Image(systemName: selectedTab == 2 ? "gear.circle.fill" : "gear.circle")
                }
            }
            .tag(2)
        }
        .tint(.blue) // 设置选中时的颜色
        .toolbarBackground(.visible, for: .tabBar)  // 确保标签栏背景可见
        .toolbarBackground(Color.white, for: .tabBar)  // 设置标签栏背景颜色
    }
}

#Preview {
    IconTabView()
} 