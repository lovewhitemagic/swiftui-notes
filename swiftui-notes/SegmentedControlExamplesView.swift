import SwiftUI

// MARK: - Basic Segmented Control
struct BasicSegmentedLayout: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Options", selection: $selectedTab) {
                Text("First").tag(0)
                Text("Second").tag(1)
                Text("Third").tag(2)
            }
            .pickerStyle(.segmented)
            
            // 显示选中的内容
            Text("Selected: \(selectedTab == 0 ? "First" : selectedTab == 1 ? "Second" : "Third")")
        }
        .padding()
    }
}

// MARK: - Custom Style Segmented Control
struct CustomSegmentedLayout: View {
    @State private var selectedMode: ColorScheme = .light
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("Appearance", selection: $selectedMode) {
                Image(systemName: "sun.max.fill")
                    .tag(ColorScheme.light)
                Image(systemName: "moon.fill")
                    .tag(ColorScheme.dark)
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
            
            // 根据选择改变背景色
            RoundedRectangle(cornerRadius: 10)
                .fill(selectedMode == .light ? .yellow : .blue)
                .frame(width: 100, height: 100)
                .animation(.default, value: selectedMode)
        }
        .padding()
    }
}

// MARK: - Content Switching Segmented Control
struct ContentSwitchingLayout: View {
    @State private var selectedView = 0
    
    var body: some View {
        VStack {
            Picker("View Selection", selection: $selectedView) {
                Text("List").tag(0)
                Text("Grid").tag(1)
                Text("Gallery").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()
            
            // 根据选择显示不同内容
            switch selectedView {
            case 0:
                ListView()
            case 1:
                GridView()
            default:
                GalleryView()
            }
        }
    }
}

struct ListView: View {
    var body: some View {
        List(1...5, id: \.self) { item in
            Text("List Item \(item)")
        }
    }
}

struct GridView: View {
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(1...6, id: \.self) { item in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue.opacity(0.2))
                    .frame(height: 100)
                    .overlay {
                        Text("Grid Item \(item)")
                    }
            }
        }
        .padding()
    }
}

struct GalleryView: View {
    var body: some View {
        TabView {
            ForEach(1...3, id: \.self) { item in
                RoundedRectangle(cornerRadius: 15)
                    .fill(.green.opacity(0.2))
                    .overlay {
                        Text("Gallery Item \(item)")
                    }
            }
        }
        .tabViewStyle(.page)
        .frame(height: 200)
    }
}

// MARK: - Form Segmented Control
struct FormSegmentedLayout: View {
    @State private var priority = "Medium"
    @State private var category = "Work"
    
    var body: some View {
        Form {
            Section("Task Settings") {
                Picker("Priority", selection: $priority) {
                    Text("Low").tag("Low")
                    Text("Medium").tag("Medium")
                    Text("High").tag("High")
                }
                .pickerStyle(.segmented)
                
                Picker("Category", selection: $category) {
                    Text("Work").tag("Work")
                    Text("Personal").tag("Personal")
                    Text("Shopping").tag("Shopping")
                }
                .pickerStyle(.segmented)
            }
            
            Section("Summary") {
                Text("Priority: \(priority)")
                Text("Category: \(category)")
            }
        }
        .frame(height: 300)
    }
}

// MARK: - Main View
struct SegmentedControlExamplesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Basic") {
                    BasicSegmentedLayout()
                }
                
                Section("Custom Style") {
                    CustomSegmentedLayout()
                }
                
                Section("Content Switching") {
                    ContentSwitchingLayout()
                }
                
                Section("Form Integration") {
                    FormSegmentedLayout()
                }
            }
            .navigationTitle("Segmented Control")
        }
    }
}

// MARK: - Previews
#Preview("Main View") {
    NavigationStack {
        SegmentedControlExamplesView()
    }
}

#Preview("Basic Segmented") {
    NavigationStack {
        List {
            Section {
                BasicSegmentedLayout()
            }
        }
    }
}

#Preview("Custom Style") {
    NavigationStack {
        List {
            Section {
                CustomSegmentedLayout()
            }
        }
    }
}

#Preview("Content Switching") {
    NavigationStack {
        List {
            Section {
                ContentSwitchingLayout()
            }
        }
    }
}

#Preview("Form Integration") {
    NavigationStack {
        List {
            Section {
                FormSegmentedLayout()
            }
        }
    }
} 