import SwiftUI

struct ScrollPinTabView: View {
    @State private var selectedTab = 0
    @State private var scrollOffset: CGFloat = 0
    @State private var contentOffset: CGFloat = 0
    
    // 卡片高度
    private let cardHeight: CGFloat = 200
    // 标签栏高度
    private let tabBarHeight: CGFloat = 44
    private let navigationBarHeight: CGFloat = 44 // 导航栏高度
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // 使用GeometryReader检测滚动位置
                GeometryReader { geometry in
                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                                        value: geometry.frame(in: .named("scroll")).minY)
                }
                .frame(height: 0)
                
                VStack(spacing: 0) {
                    // 卡片和标签栏容器
                    VStack(spacing: 0) {
                        // 卡片视图
                        CardView()
                            .frame(height: cardHeight)
                            .padding(.horizontal)
                        
                        // 标签栏
                        TabBarView(selectedTab: $selectedTab)
                            .frame(height: tabBarHeight)
                            .background(Color.white)
                    }
                    .background(Color.white)
                    // 控制上部分固定
                    .offset(y: min(0, max(-scrollOffset, -(cardHeight + tabBarHeight - navigationBarHeight))))
                    .zIndex(1)
                    
                    // 内容视图
                    TabView(selection: $selectedTab) {
                        ScrollView {
                            List1()
                                .offset(y: max(0, -scrollOffset - cardHeight))
                        }
                        .disabled(scrollOffset < cardHeight - navigationBarHeight)
                        .tag(0)
                        
                        ScrollView {
                            List2()
                                .offset(y: max(0, -scrollOffset - cardHeight))
                        }
                        .disabled(scrollOffset < cardHeight - navigationBarHeight)
                        .tag(1)
                        
                        ScrollView {
                            List3()
                                .offset(y: max(0, -scrollOffset - cardHeight))
                        }
                        .disabled(scrollOffset < cardHeight - navigationBarHeight)
                        .tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                scrollOffset = -value
            }
            .navigationTitle("Scroll Pin")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - 卡片视图
struct CardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.blue.opacity(0.1))
            .overlay {
                Text("Card Content")
            }
    }
}

// MARK: - 标签栏视图
struct TabBarView: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack(spacing: 30) {
            TabButton(title: "First", isSelected: selectedTab == 0) {
                withAnimation {
                    selectedTab = 0
                }
            }
            
            TabButton(title: "Second", isSelected: selectedTab == 1) {
                withAnimation {
                    selectedTab = 1
                }
            }
            
            TabButton(title: "Third", isSelected: selectedTab == 2) {
                withAnimation {
                    selectedTab = 2
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// MARK: - 标签按钮
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(isSelected ? .bold : .regular)
                .foregroundStyle(isSelected ? .blue : .gray)
        }
    }
}

// MARK: - 列表内容
struct List1: View {
    var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(1...20, id: \.self) { index in
                HStack {
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Text("\(index)")
                                .foregroundStyle(.blue)
                        }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("First List Item \(index)")
                            .font(.headline)
                        Text("This is a description for item \(index)")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
            }
        }
    }
}

struct List2: View {
    var body: some View {
        LazyVStack(spacing: 1) {
            ForEach(1...20, id: \.self) { index in
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.green.opacity(0.1))
                        .frame(width: 60, height: 60)
                        .overlay {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.green)
                        }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Second List Item \(index)")
                            .font(.headline)
                        Text("Subtitle")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding()
                .background(Color.white)
                Divider()
            }
        }
        .background(Color.gray.opacity(0.05))
    }
}

struct List3: View {
    var body: some View {
        LazyVStack(spacing: 16) {
            ForEach(1...20, id: \.self) { index in
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Circle()
                            .fill(Color.orange.opacity(0.1))
                            .frame(width: 32, height: 32)
                            .overlay {
                                Text("\(index)")
                                    .font(.caption)
                                    .foregroundStyle(.orange)
                            }
                        
                        Text("Third List Item \(index)")
                            .font(.headline)
                        Spacer()
                        
                        Text("12:00")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    Text("This is a longer description that provides more details about the item. It can span multiple lines and contain more information.")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    HStack {
                        ForEach(0..<3) { i in
                            Text("Tag \(i + 1)")
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.orange.opacity(0.1))
                                .cornerRadius(4)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - 滚动偏移量 PreferenceKey
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    ScrollPinTabView()
} 