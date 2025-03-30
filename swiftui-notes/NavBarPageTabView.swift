import SwiftUI

struct NavBarPageTabView: View {
    @State private var selectedPage = 0
    @State private var searchText = ""
    @Namespace private var namespace
    
    // 页面标题和内容
    let pages = [
        (title: "All", color: Color.blue.opacity(0.2)),
        (title: "Social Media", color: Color.green.opacity(0.2)),
        (title: "New Media", color: Color.orange.opacity(0.2)),
        (title: "News", color: Color.purple.opacity(0.2)),
        (title: "BBS", color: Color.pink.opacity(0.2))
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 自定义搜索栏
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $searchText)
                            .font(.system(size: 16))
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    
                    Button(action: {
                        // 添加按钮操作
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.orange)
                            .font(.system(size: 18))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
                
                // 水平滚动的标签栏
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Text(pages[index].title)
                                .font(.subheadline)
                                .foregroundColor(selectedPage == index ? .orange : .gray)
                                .padding(.vertical, 8)
                                .onTapGesture {
                                    withAnimation {
                                        selectedPage = index
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // 页面内容
                TabView(selection: $selectedPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        PageContent(title: pages[index].title, color: pages[index].color, index: index, searchText: searchText)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: selectedPage) { newValue in
                    // 当页面改变时，可以在这里添加额外的逻辑
                }
            }
            .navigationBarTitleDisplayMode(.inline)
           // .toolbarBackground(.visible, for: .navigationBar) // 显示导航栏背景
            .toolbarBackground(Color.white, for: .navigationBar) // 设置导航栏背景颜色

        }
    }
}

// MARK: - 页面内容
struct PageContent: View {
    let title: String
    let color: Color
    let index: Int
    let searchText: String
    
    var filteredItems: [Int] {
        if searchText.isEmpty {
            return Array(1...15)
        } else {
            return Array(1...15).filter { item in
                "\(title) 项目 \(item)".localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // 页面标题
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                
                // 示例内容
                ForEach(filteredItems, id: \.self) { item in
                    HStack {
                        Text("\(title) 项目 \(item)")
                            .font(.body)
                        
                        Spacer()
                        
                        Text("详情 >")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                    )
                }
            }
            .padding()
        }
    }
}

#Preview {
    NavBarPageTabView()
}