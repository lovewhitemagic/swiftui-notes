import SwiftUI

// MARK: - Navigation Examples
struct NavigationExample: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Basic Navigation", destination: Text("Detail View"))
                NavigationLink("Programmatic Navigation") {
                    Text("Programmatically Pushed View")
                }
            }
            .navigationTitle("Navigation")
        }
    }
}

// MARK: - Sheet Examples
struct SheetExample: View {
    @State private var showBasicSheet = false
    @State private var showFullScreenSheet = false
    @State private var showCustomSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Basic Sheet") {
                showBasicSheet.toggle()
            }
            .sheet(isPresented: $showBasicSheet) {
                NavigationStack {
                    Text("Basic Sheet Content")
                        .navigationTitle("Basic Sheet")
                        .toolbar {
                            Button("Dismiss") {
                                showBasicSheet = false
                            }
                        }
                }
            }
            
            Button("Show Fullscreen Sheet") {
                showFullScreenSheet.toggle()
            }
            .fullScreenCover(isPresented: $showFullScreenSheet) {
                NavigationStack {
                    Text("Fullscreen Content")
                        .navigationTitle("Fullscreen")
                        .toolbar {
                            Button("Dismiss") {
                                showFullScreenSheet = false
                            }
                        }
                }
            }
            
            Button("Show Custom Sheet") {
                showCustomSheet.toggle()
            }
            .sheet(isPresented: $showCustomSheet) {
                Text("Custom Sheet")
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(30)
            }
        }
    }
}

// MARK: - Segmented Control Examples
struct SegmentedExample: View {
    @State private var selectedTab = 0
    @State private var viewMode = 0
    
    var body: some View {
        VStack(spacing: 30) {
            // 基本分段控制
            Picker("Options", selection: $selectedTab) {
                Text("First").tag(0)
                Text("Second").tag(1)
                Text("Third").tag(2)
            }
            .pickerStyle(.segmented)
            
            // 视图切换
            Picker("View Mode", selection: $viewMode) {
                Image(systemName: "list.bullet").tag(0)
                Image(systemName: "square.grid.2x2").tag(1)
            }
            .pickerStyle(.segmented)
            
            if viewMode == 0 {
                List(1...5, id: \.self) { item in
                    Text("List Item \(item)")
                }
            } else {
                LazyVGrid(columns: [.init(.flexible()), .init(.flexible())]) {
                    ForEach(1...4, id: \.self) { item in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.blue.opacity(0.2))
                            .aspectRatio(1, contentMode: .fit)
                            .overlay {
                                Text("Grid Item \(item)")
                            }
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

// MARK: - TabView Example
struct TabExample: View {
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

// MARK: - Fullscreen Examples
struct FullscreenExample: View {
    @State private var showFullscreen1 = false
    @State private var showFullscreen2 = false
    @State private var showFullscreen3 = false
    
    var body: some View {
        VStack(spacing: 20) {
            // 1. 基本全屏切换
            Button("Basic Fullscreen") {
                showFullscreen1.toggle()
            }
            .fullScreenCover(isPresented: $showFullscreen1) {
                FullscreenView1(isPresented: $showFullscreen1)
            }
            
            // 2. 自定义过渡动画
            Button("Animated Fullscreen") {
                showFullscreen2.toggle()
            }
            .fullScreenCover(isPresented: $showFullscreen2) {
                FullscreenView2(isPresented: $showFullscreen2)
            }
            
            // 3. 交互式全屏
            Button("Interactive Fullscreen") {
                showFullscreen3.toggle()
            }
            .fullScreenCover(isPresented: $showFullscreen3) {
                FullscreenView3(isPresented: $showFullscreen3)
            }
        }
    }
}

// 基本全屏视图
struct FullscreenView1: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    Text("Basic Fullscreen")
                        .font(.title)
                    
                    Button("Dismiss") {
                        isPresented = false
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("Fullscreen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// 动画全屏视图
struct FullscreenView2: View {
    @Binding var isPresented: Bool
    @State private var offset: CGFloat = 1000
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.2).ignoresSafeArea()
            
            VStack {
                Text("Animated Fullscreen")
                    .font(.title)
                
                Button("Dismiss with Animation") {
                    withAnimation(.spring()) {
                        offset = 1000
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isPresented = false
                        }
                    }
                }
                .buttonStyle(.bordered)
            }
            .offset(y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
    }
}

// 交互式全屏视图
struct FullscreenView3: View {
    @Binding var isPresented: Bool
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack {
            Color.purple.opacity(0.2).ignoresSafeArea()
            
            VStack {
                Text("Interactive Fullscreen")
                    .font(.title)
                
                Text("Drag down to dismiss")
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .offset(y: offset.height)
            .animation(.spring(), value: offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        isDragging = true
                        if gesture.translation.height > 0 {
                            offset = gesture.translation
                        }
                    }
                    .onEnded { gesture in
                        isDragging = false
                        if gesture.translation.height > 100 {
                            isPresented = false
                        } else {
                            offset = .zero
                        }
                    }
            )
        }
        .overlay(alignment: .top) {
            RoundedRectangle(cornerRadius: 3)
                .fill(.secondary)
                .frame(width: 40, height: 5)
                .padding(.top, 10)
        }
    }
}

// MARK: - Page Examples
struct PageExample: View {
    var body: some View {
        VStack(spacing: 20) {
            // 1. 基本页面切换
            TabView {
                ForEach(1...3, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.blue.opacity(0.2))
                        .overlay {
                            Text("Page \(index)")
                                .font(.title)
                        }
                }
            }
            .tabViewStyle(.page)
            .frame(height: 200)
            
            // 2. 卡片式页面
            TabView {
                ForEach(1...3, id: \.self) { index in
                    VStack {
                        Image(systemName: "photo")
                            .font(.system(size: 50))
                        Text("Card \(index)")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green.opacity(0.2))
                    )
                    .padding(.horizontal)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .frame(height: 200)
        }
    }
}

// MARK: - Custom Page Control
struct CustomPageControl: View {
    @State private var currentPage = 0
    let pages = ["First", "Second", "Third"]
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    Text(pages[index])
                        .font(.title)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
            
            // 自定义页面指示器
            HStack(spacing: 10) {
                ForEach(0..<pages.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? .blue : .gray)
                        .frame(width: 8, height: 8)
                        .scaleEffect(currentPage == index ? 1.2 : 1)
                        .animation(.spring(), value: currentPage)
                        .onTapGesture {
                            withAnimation {
                                currentPage = index
                            }
                        }
                }
            }
            .padding()
        }
    }
}

// MARK: - Main View
struct ViewTransitionExamplesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Navigation") {
                    NavigationExample()
                }
                
                Section("Sheets") {
                    SheetExample()
                }
                
                Section("Segmented Control") {
                    SegmentedExample()
                }
                
                Section("Tab View") {
                    TabExample()
                        .frame(height: 200)
                }
                
                Section("Fullscreen") {
                    FullscreenExample()
                }
                
                Section("Page View") {
                    PageExample()
                }
                
                Section("Custom Page Control") {
                    CustomPageControl()
                }
            }
            .navigationTitle("View Transitions")
        }
    }
}

// MARK: - Previews
#Preview("All Transitions") {
    ViewTransitionExamplesView()
}

#Preview("Navigation") {
    NavigationStack {
        List {
            Section {
                NavigationExample()
            }
        }
    }
}

#Preview("Sheets") {
    NavigationStack {
        List {
            Section {
                SheetExample()
            }
        }
    }
}

#Preview("Segmented Control") {
    NavigationStack {
        List {
            Section {
                SegmentedExample()
            }
        }
    }
}

#Preview("Tab View") {
    NavigationStack {
        List {
            Section {
                TabExample()
                    .frame(height: 200)
            }
        }
    }
}

#Preview("Fullscreen") {
    NavigationStack {
        List {
            Section {
                FullscreenExample()
            }
        }
    }
}

#Preview("Page View") {
    NavigationStack {
        List {
            Section {
                PageExample()
            }
        }
    }
}

#Preview("Custom Page Control") {
    NavigationStack {
        List {
            Section {
                CustomPageControl()
            }
        }
    }
}