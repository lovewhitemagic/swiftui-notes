import SwiftUI

struct CustomInterfaceView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 第一个标签页
            MainContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首页")
                }
                .tag(0)
            
            // 第二个标签页
            MainContentView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("我的")
                }
                .tag(1)
        }
    }
}

// 主内容视图
struct MainContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            // 顶部固定蓝色背景
            TopSection()
                .frame(height: 200)
            
            // 可滚动内容区域
            ZStack {
                // 背景圆角
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                
                ScrollView {
                    // 为了避免第一个项目顶到圆角，添加顶部padding
                    VStack(spacing: 16) {
                        ForEach(0..<20) { index in
                            ListItemView()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 25) // 对应圆角大小
                }
                .clipShape(RoundedRectangle(cornerRadius: 25)) // 裁剪滚动内容
            }
        }
        .ignoresSafeArea()
        .background(.blue)
    }
}

// 顶部区域
struct TopSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("标题")
                .font(.system(size: 36, weight: .bold))
            Text("这是一个异形界面演示")
                .font(.system(size: 16))
                .opacity(0.8)
            Spacer()
        }
        .padding(.top, 60) // 状态栏空间
        .padding(.horizontal)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.blue)
    }
}

// 列表项
struct ListItemView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(uiColor: .systemGray6))
            .frame(height: 80)
            .overlay(
                Text("列表项")
                    .foregroundStyle(.gray)
            )
    }
}

#Preview {
    CustomInterfaceView()
} 