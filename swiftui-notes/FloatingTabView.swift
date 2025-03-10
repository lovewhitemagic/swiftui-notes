import SwiftUI

struct FloatingTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
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
                .tag(0)
                .toolbar(.hidden, for: .tabBar)
                
                // 收藏页
                NavigationStack {
                    List {
                        ForEach(1...20, id: \.self) { index in
                            Text("Favorite Item \(index)")
                        }
                    }
                    .navigationTitle("Favorites")
                }
                .tag(1)
                .toolbar(.hidden, for: .tabBar)
                
                // 设置页
                NavigationStack {
                    List {
                        ForEach(1...20, id: \.self) { index in
                            Text("Setting Item \(index)")
                        }
                    }
                    .navigationTitle("Settings")
                }
                .toolbar(.hidden, for: .tabBar)
                .tag(2)
            }
            .toolbar(.hidden, for: .tabBar)  // 隐藏原生标签栏
            
            // 自定义浮动标签栏
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // 自定义标签按钮
                    FloatingTabButton(imageName: "house", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    
                    Spacer()
                    FloatingTabButton(imageName: "star", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    
                    Spacer()
                    FloatingTabButton(imageName: "gearshape", isSelected: selectedTab == 2) {
                        selectedTab = 2
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)  // 磨砂背景
                .cornerRadius(22)
                .padding(.horizontal, 110)
                
            }
        }
    }
}

// MARK: - 自定义标签按钮
struct FloatingTabButton: View {
    let imageName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .font(.title2)
                .symbolVariant(isSelected ? .fill : .none)  // 根据选中状态切换填充样式
                .frame(width: 35, height: 35)
                .foregroundStyle(isSelected ? .black : .gray)
        }
    }
}

#Preview {
    FloatingTabView()
} 
