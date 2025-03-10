import SwiftUI

struct PageTabViewExample: View {
    @State private var selectedPage = 0
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedPage) {
                FirstPageContent()
                    .tag(0)
                
                SecondPageContent()
                    .tag(1)
                
                ThirdPageContent()
                    .tag(2)
            }
            .ignoresSafeArea(edges:[.bottom])
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Home")
                        .font(.headline)
                }
                
                ToolbarItem(placement: .principal) {
                    // 自定义分段控制器
                    HStack(spacing: 4) {
                        PageButton(title: "First", isSelected: selectedPage == 0, namespace: namespace)
                        PageButton(title: "Second", isSelected: selectedPage == 1, namespace: namespace)
                        PageButton(title: "Third", isSelected: selectedPage == 2, namespace: namespace)
                    }
                    //.frame(width: 200) // 控制分段控制器的宽度
                }
            }
        }
    }
}

// MARK: - 自定义分段按钮
struct PageButton: View {
    let title: String
    let isSelected: Bool
    let namespace: Namespace.ID
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
            .foregroundStyle(isSelected ? .blue : .gray)
            .overlay(alignment: .bottom) {
                if isSelected {
                    Rectangle()
                        .fill(.blue)
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline", in: namespace)
                }
            }
    }
}

// MARK: - 页面内容
struct FirstPageContent: View {
    var body: some View {
        List {
            ForEach(1...20, id: \.self) { index in
                Text("First Page Item \(index)")
            }
        }
    }
}

struct SecondPageContent: View {
    var body: some View {
        List {
            ForEach(1...20, id: \.self) { index in
                Text("Second Page Item \(index)")
            }
        }
    }
}

struct ThirdPageContent: View {
    var body: some View {
        List {
            ForEach(1...20, id: \.self) { index in
                Text("Third Page Item \(index)")
            }
        }
    }
}

#Preview {
    PageTabViewExample()
} 
