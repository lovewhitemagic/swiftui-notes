import SwiftUI

struct ScrollVsTabView: View {
    @State private var selectedTab = 0
    
    // 用于ScrollView的滑动位置
    @State private var scrollPosition: Int?
    
    private let items = (1...5).map { "Item \($0)" }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ScrollView vs TabView")
                .font(.title)
                .padding(.top)
            
            // 使用ScrollView的水平滚动
            VStack(alignment: .leading) {
                Text("ScrollView Horizontal")
                    .font(.headline)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(items.indices, id: \.self) { index in
                            ComparisonCardView(title: items[index], index: index)
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.5)
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrollPosition)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // 使用TabView的页面切换
            VStack(alignment: .leading) {
                Text("TabView Paging")
                    .font(.headline)
                    .padding(.horizontal)
                
                TabView(selection: $selectedTab) {
                    ForEach(items.indices, id: \.self) { index in
                        ComparisonCardView(title: items[index], index: index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 200)
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // 区别说明
            VStack(alignment: .leading, spacing: 10) {
                Text("主要区别：")
                    .font(.headline)
                
                Text("• ScrollView 支持连续滚动，可以停在任意位置")
                Text("• TabView.page 只能整页切换，有分页效果")
                Text("• ScrollView 可以自定义过渡动画")
                Text("• TabView.page 自带页面指示器")
                Text("• ScrollView 性能更好，适合大量内容")
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

// 卡片视图组件
private struct ComparisonCardView: View {
    let title: String
    let index: Int
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(0.2))
                .overlay {
                    VStack {
                        Text(title)
                            .font(.title2)
                        Text("Page \(index + 1)")
                            .foregroundStyle(.gray)
                    }
                }
        }
        .frame(width: 300, height: 200)
        .padding(.horizontal, 8)
    }
}

#Preview {
    ScrollVsTabView()
} 