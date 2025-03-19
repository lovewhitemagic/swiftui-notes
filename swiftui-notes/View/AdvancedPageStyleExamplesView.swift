import SwiftUI

// MARK: - Fixed Title Page Style
struct FixedTitlePageStyleLayout: View {
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(1...5, id: \.self) { index in
                    VStack {
                        Text("Page \(index)")
                            .font(.largeTitle)
                            .padding()
                        
                        Spacer()
                    }
                    .background(Color.blue.opacity(0.2))
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .navigationTitle("Fixed Title")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Scrollable Title Page Style,vstack里面使用rectangle+tabview，忽略底部
struct ScrollableTitlePageStyleLayout: View {
    var body: some View {
        VStack{
            // 固定标题背景
            Rectangle()
                .fill(.ultraThinMaterial)  // 直接使用材质作为填充
                .frame(height: 200)
                .overlay {
                    Text("Fixed Title")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

            TabView {
                ForEach(1...5, id: \.self) { index in
                    ScrollView {
                        VStack {
                            Text("Page \(index)")
                                .font(.largeTitle)
                                .padding()
                            
                            ForEach(0..<20) { _ in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.2))
                                    .frame(height: 100)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                            }
                        }
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
         
        }
        .ignoresSafeArea()
        

    }
}

// MARK: - Full Screen Page Style
struct FullScreenPageStyleLayout: View {
    var body: some View {
   
            GeometryReader { geometry in
                TabView {
                    ForEach(1...5, id: \.self) { index in
                        ScrollView {
                            VStack(spacing: 0) {
                                // 标题区域
                                ZStack {
                                    // 背景
                                    LinearGradient(
                                        colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                    
                                    // 标题内容
                                    VStack(spacing: 10) {
                                        Text("Page \(index)")
                                            .font(.largeTitle)
                                            .bold()
                                        
                                        Text("Scrollable Header")
                                            .font(.title3)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.top, geometry.safeAreaInsets.top + 20)
                                    .padding(.bottom, 20)
                                }
                                .frame(height: 200)
                                
                                // 内容区域
                                LazyVStack(spacing: 15) {
                                    ForEach(0..<20) { item in
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text("Item \(item + 1)")
                                                    .font(.headline)
                                                Text("Description for item \(item + 1)")
                                                    .font(.subheadline)
                                                    .foregroundStyle(.secondary)
                                            }
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.gray)
                                        }
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                                .padding()
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
      
    }
}

// MARK: - Main View
struct AdvancedPageStyleExamplesView: View {
    var body: some View {
        TabView {
            FixedTitlePageStyleLayout()
                .tabItem {
                    Label("Fixed", systemImage: "1.circle")
                }
            
            ScrollableTitlePageStyleLayout()
                .tabItem {
                    Label("Scrollable", systemImage: "2.circle")
                }
            
            FullScreenPageStyleLayout()
                .tabItem {
                    Label("Full Screen", systemImage: "3.circle")
                }
        }
    }
}

// MARK: - Previews
#Preview("Advanced Page Styles") {
    AdvancedPageStyleExamplesView()
}

#Preview("Fixed Title") {
    FixedTitlePageStyleLayout()
}

#Preview("Scrollable Title") {
    ScrollableTitlePageStyleLayout()
}

#Preview("Full Screen") {
    FullScreenPageStyleLayout()
} 
