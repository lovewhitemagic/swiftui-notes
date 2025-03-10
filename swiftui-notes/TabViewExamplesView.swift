import SwiftUI

// MARK: - Basic Tab View
struct BasicTabLayout: View {
    var body: some View {
        TabView {
            Text("First Tab")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("First")
                }
            
            Text("Second Tab")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }
            
            Text("Third Tab")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Third")
                }
        }
    }
}

// MARK: - Custom Content Tab View
struct CustomTabLayout: View {
    var body: some View {
        TabView {
            // 首页标签
            NavigationStack {
                List(1...10, id: \.self) { item in
                    NavigationLink("Item \(item)") {
                        Text("Detail of item \(item)")
                    }
                }
                .navigationTitle("Home")
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            // 收藏标签
            NavigationStack {
                GridView()
                    .navigationTitle("Favorites")
            }
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
            
            // 设置标签
            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

// MARK: - Page Style Tab View
struct PageStyleTabLayout: View {
    var body: some View {
        TabView {
            ForEach(1...5, id: \.self) { index in
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue.opacity(0.2))
                    .overlay {
                        Text("Page \(index)")
                            .font(.largeTitle)
                    }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

// MARK: - State Management Tab View
struct StateTabLayout: View {
    @State private var selectedTab = 0
    @State private var showAlert = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 第一个标签
            Button("Show Alert") {
                showAlert = true
            }
            .alert("Tab 1 Alert", isPresented: $showAlert) {
                Button("OK") { }
            }
            .tabItem {
                Label("First", systemImage: "1.circle")
            }
            .tag(0)
            
            // 第二个标签
            VStack {
                Text("Current Tab: \(selectedTab)")
                Button("Go to Tab 3") {
                    selectedTab = 2
                }
            }
            .tabItem {
                Label("Second", systemImage: "2.circle")
            }
            .tag(1)
            
            // 第三个标签
            Text("Third Tab")
                .tabItem {
                    Label("Third", systemImage: "3.circle")
                }
                .tag(2)
                .badge("New")
        }
    }
}

// MARK: - Custom Tab Style
struct CustomStyleTabLayout: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                Color.red.opacity(0.2)
                    .tag(0)
                Color.green.opacity(0.2)
                    .tag(1)
                Color.blue.opacity(0.2)
                    .tag(2)
            }
            
            // 自定义标签栏
            HStack {
                ForEach(0..<3) { index in
                    Button {
                        selectedTab = index
                    } label: {
                        VStack {
                            Image(systemName: "\(index + 1).circle")
                                .font(.title2)
                            Text("Tab \(index + 1)")
                                .font(.caption)
                        }
                        .foregroundStyle(selectedTab == index ? .blue : .gray)
                    }
                    if index != 2 {
                        Spacer()
                    }
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .padding()
        }
    }
}

// MARK: - Settings View Helper
struct SettingsView: View {
    @State private var enableNotifications = false
    @State private var username = ""
    
    var body: some View {
        Form {
            Section("User") {
                TextField("Username", text: $username)
            }
            
            Section("Preferences") {
                Toggle("Enable Notifications", isOn: $enableNotifications)
            }
        }
    }
}

// MARK: - Main View
struct TabViewExamplesView: View {
    var body: some View {
        TabView {
            // 基础标签视图
            NavigationStack {
                BasicTabLayout()
                    .navigationTitle("Basic")
            }
            .tabItem {
                Label("Basic", systemImage: "1.circle")
            }
            
            // 自定义内容标签视图
            CustomTabLayout()
                .tabItem {
                    Label("Custom", systemImage: "2.circle")
                }
            
            // 页面样式标签视图
            NavigationStack {
                PageStyleTabLayout()
                    .navigationTitle("Page Style")
            }
            .tabItem {
                Label("Page", systemImage: "3.circle")
            }
            
            // 状态管理标签视图
            NavigationStack {
                StateTabLayout()
                    .navigationTitle("State")
            }
            .tabItem {
                Label("State", systemImage: "4.circle")
            }
            
            // 自定义样式标签视图
            NavigationStack {
                CustomStyleTabLayout()
                    .navigationTitle("Style")
            }
            .tabItem {
                Label("Style", systemImage: "5.circle")
            }
        }
    }
}

// MARK: - Previews
#Preview("Main View") {
    TabViewExamplesView()
}

#Preview("Basic Tab") {
    BasicTabLayout()
}

#Preview("Custom Content") {
    CustomTabLayout()
}

#Preview("Page Style") {
    PageStyleTabLayout()
}

#Preview("State Management") {
    StateTabLayout()
}

#Preview("Custom Style") {
    CustomStyleTabLayout()
} 