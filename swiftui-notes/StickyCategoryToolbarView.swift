import SwiftUI

/// 滚动偏移的偏好键，用于在滚动时监听当前位置
private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct StickyCategoryToolbarView: View {
    /// 模拟的分类标签
    private let categories = [
        "全部", "设计", "开发", "产品", "营销", "运营", "管理", "财务", "人力", "客服"
    ]

    /// 当前滚动偏移量
    @State private var scrollOffset: CGFloat = 0
    /// 当前选中的分类
    @State private var selectedCategory: String = "全部"

    /// 根据滚动偏移量计算标题是否需要隐藏
    private var isTitleHidden: Bool {
        scrollOffset < -40
    }

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16, pinnedViews: [.sectionHeaders]) {
                    // 使用透明视图记录滚动偏移
                    Color.clear
                        .frame(height: 0)
                        .background(offsetReader)

                    // 标题区域会在向上滚动时渐隐
                    titleView
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                        .opacity(isTitleHidden ? 0 : 1)
                        .animation(.easeInOut(duration: 0.25), value: isTitleHidden)

                    Section(header: categoryHeader) {
                        ForEach(0..<30) { index in
                            VStack(alignment: .leading, spacing: 8) {
                                Text("示例内容 #\(index + 1)")
                                    .font(.headline)
                                Text("这里是详细描述内容，演示向上滚动时标题隐藏，分类标签固定在顶部。")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                }
                .padding(.bottom, 40)
            }
            .coordinateSpace(name: "scroll")
            .background(Color(uiColor: .systemGroupedBackground))
        }
    }

    /// 计算滚动偏移量的阅读器
    private var offsetReader: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: ScrollOffsetPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            scrollOffset = value
        }
    }

    /// 顶部标题视图
    private var titleView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("我的收藏")
                .font(.largeTitle.bold())
            Text("查看不同分类下的精彩内容")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
    }

    /// 水平滚动的分类标签栏
    private var categoryHeader: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            Capsule().fill(selectedCategory == category ? Color.accentColor.opacity(0.2) : Color.clear)
                        )
                        .overlay(
                            Capsule().stroke(
                                selectedCategory == category ? Color.accentColor : Color.secondary.opacity(0.3),
                                lineWidth: 1
                            )
                        )
                        .contentShape(Capsule())
                        .onTapGesture {
                            // 点击切换选中的分类
                            withAnimation(.easeInOut) {
                                selectedCategory = category
                            }
                        }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .background(.regularMaterial)
    }
}

#Preview {
    StickyCategoryToolbarView()
}
