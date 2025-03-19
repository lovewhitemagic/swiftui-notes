import SwiftUI

struct TabWithSegmentView: View {
    @State private var selectedTab = 0
    @State private var selectedSegment = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 第一个标签：带分段控制器的视图
            NavigationStack {
                VStack {
                    if selectedSegment == 0 {
                        FirstPageView()
                    } else {
                        SecondPageView()
                    }
                }
                //.navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Home")
                            .font(.headline)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Picker("View Mode", selection: $selectedSegment) {
                            Text("First Page").tag(0)
                            Text("Second Page").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 200) // 控制分段控制器的宽度
                    }
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            
            // 第二个标签
            NavigationStack {
                Text("Favorites")
                    .navigationTitle("Favorites")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }
            .tag(1)
            
            // 第三个标签
            NavigationStack {
                Text("Settings")
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(2)
        }
    }
}

// MARK: - 分段控制器的两个页面
struct FirstPageView: View {
    var body: some View {
        List {
            ForEach(1...5, id: \.self) { index in
                Text("First Page Item \(index)")
            }
        }
    }
}

struct SecondPageView: View {
    var body: some View {
        List {
            ForEach(1...5, id: \.self) { index in
                Text("Second Page Item \(index)")
            }
        }
    }
}

#Preview {
    TabWithSegmentView()
} 
