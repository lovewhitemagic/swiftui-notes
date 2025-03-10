import SwiftUI

struct CustomBackgroundExampleView: View {
    @State private var showSheet = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 第一个标签 - 基础背景示例
            NavigationStack {
                ScrollView {
                    VStack(spacing: 20) {
                        // 渐变背景
                        Text("渐变背景")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        // 图片背景
                        Text("图片背景")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundStyle(.yellow.opacity(0.3))
                                    .aspectRatio(contentMode: .fill)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        // 半边背景
                        HStack(spacing: 0) {
                            Rectangle()
                                .fill(.blue)
                                .frame(maxWidth: .infinity)
                            Rectangle()
                                .fill(.green)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            Text("半边背景")
                                .font(.title)
                                .foregroundStyle(.white)
                        )
                        
                        // 自定义形状背景
                        Text("自定义形状背景")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(
                                CustomShape()
                                    .stroke(Color.purple.opacity(0.3), lineWidth: 2)
                            )
                        
                        // 带模糊效果的背景
                        Text("模糊背景")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    .padding()
                }
                .navigationTitle("背景示例")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("显示Sheet") {
                            showSheet = true
                        }
                    }
                }
                // 自定义导航栏背景
                .toolbarBackground(
                    LinearGradient(
                        colors: [.blue.opacity(0.2), .purple.opacity(0.2)],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    for: .navigationBar
                )
            }
            // 全屏背景
            .background(
                ZStack {
                    // 底层渐变
                    LinearGradient(
                        colors: [.blue.opacity(0.1), .purple.opacity(0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    // 装饰图形
                    Circle()
                        .fill(.blue.opacity(0.1))
                        .frame(width: 200, height: 200)
                        .position(x: UIScreen.main.bounds.width * 0.8, y: UIScreen.main.bounds.height * 0.2)
                    
                    Circle()
                        .fill(.purple.opacity(0.1))
                        .frame(width: 300, height: 300)
                        .position(x: UIScreen.main.bounds.width * 0.2, y: UIScreen.main.bounds.height * 0.8)
                }
                    .ignoresSafeArea()
            )
            .tabItem {
                Label("基础背景", systemImage: "rectangle.fill")
            }
            .tag(0)
            
            // 第二个标签 - 列表背景示例
            NavigationStack {
                List {
                    ForEach(0..<10) { index in
                        Text("列表项 \(index + 1)")
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.blue.opacity(0.1))
                                    .padding(2)
                            )
                    }
                }
                .navigationTitle("列表背景")
                // 自定义列表背景
                .scrollContentBackground(.hidden)
                .background(
                    LinearGradient(
                        colors: [.purple.opacity(0.1), .blue.opacity(0.1)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .tabItem {
                Label("列表背景", systemImage: "list.bullet")
            }
            .tag(1)
        }
        .sheet(isPresented: $showSheet) {
            // 自定义 Sheet 背景
            VStack {
                Text("自定义 Sheet 背景")
                    .font(.title)
                    .padding()
                
                Button("关闭") {
                    showSheet = false
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                ZStack {
                    // 渐变背景
                    LinearGradient(
                        colors: [.blue.opacity(0.2), .purple.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    // 装饰元素
                    ForEach(0..<20) { index in
                        Circle()
                            .fill(.white.opacity(0.1))
                            .frame(width: 20, height: 20)
                            .position(
                                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
                            )
                    }
                }
            )
            .presentationDetents([.medium, .large])
        }
    }
}

// 自定义形状
struct CustomShape: InsettableShape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: 0),
            control1: CGPoint(x: rect.width * 0.3, y: 50),
            control2: CGPoint(x: rect.width * 0.7, y: -50)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addCurve(
            to: CGPoint(x: 0, y: rect.maxY),
            control1: CGPoint(x: rect.width * 0.7, y: rect.maxY - 50),
            control2: CGPoint(x: rect.width * 0.3, y: rect.maxY + 50)
        )
        path.closeSubpath()
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        self
    }
}

#Preview {
    CustomBackgroundExampleView()
} 