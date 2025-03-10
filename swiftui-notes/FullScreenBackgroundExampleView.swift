import SwiftUI

struct FullScreenBackgroundExampleView: View {
    @State private var selectedStyle = 0
    
    var body: some View {
        TabView(selection: $selectedStyle) {
            // 1. 渐变背景
            ZStack {
                // 背景渐变
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // 内容
                VStack {
                    Text("渐变背景")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
            }
            .tag(0)
            
            // 2. 动态渐变背景
            ZStack {
                // 动态渐变
                RadialGradient(
                    colors: [.blue, .purple, .pink],
                    center: .center,
                    startRadius: 100,
                    endRadius: 400
                )
                .ignoresSafeArea()
                .hueRotation(.degrees(selectedStyle == 1 ? 360 : 0))
                .animation(.linear(duration: 5).repeatForever(autoreverses: true), value: selectedStyle)
                
                // 内容
                VStack {
                    Text("动态渐变背景")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
            }
            .tag(1)
            
            // 3. 图案背景
            ZStack {
                // 重复图案
                GeometryReader { geometry in
                    let size = geometry.size
                    
                    Path { path in
                        let patternSize: CGFloat = 50
                        for row in 0...Int(size.height/patternSize) {
                            for col in 0...Int(size.width/patternSize) {
                                let x = CGFloat(col) * patternSize
                                let y = CGFloat(row) * patternSize
                                path.addEllipse(in: CGRect(x: x, y: y, width: 20, height: 20))
                            }
                        }
                    }
                    .fill(.blue.opacity(0.2))
                }
                .ignoresSafeArea()
                
                // 内容
                VStack {
                    Text("图案背景")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                }
            }
            .tag(2)
            
            // 4. 动态波浪背景
            ZStack {
                WaveBackground()
                    .ignoresSafeArea()
                
                // 内容
                VStack {
                    Text("波浪背景")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
            }
            .tag(3)
            
            // 5. 模糊玻璃背景
            ZStack {
                // 彩色圆形
                Circle()
                    .fill(.blue)
                    .frame(width: 200)
                    .position(x: 100, y: 100)
                
                Circle()
                    .fill(.purple)
                    .frame(width: 200)
                    .position(x: 300, y: 200)
                
                Circle()
                    .fill(.pink)
                    .frame(width: 200)
                    .position(x: 200, y: 400)
                
                // 模糊效果
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                // 内容
                VStack {
                    Text("模糊玻璃背景")
                        .font(.largeTitle)
                }
            }
            .tag(4)
            
            // 6. 网格背景
            ZStack {
                GridBackground()
                    .ignoresSafeArea()
                
                // 内容
                VStack {
                    Text("网格背景")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
            }
            .tag(5)
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
    }
}

// 波浪背景视图
struct WaveBackground: View {
    @State private var phase = 0.0
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let width = size.width
                let height = size.height
                let midHeight = height * 0.5
                let wavelength = width * 0.5
                let amplitude = height * 0.1
                
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.blue))
                
                var path = Path()
                path.move(to: CGPoint(x: 0, y: height))
                
                for x in stride(from: 0, through: width, by: 1) {
                    let relativeX = x/wavelength
                    let sine = sin(relativeX + phase)
                    let y = midHeight + amplitude * sine
                    path.addLine(to: CGPoint(x: x, y: y))
                }
                
                path.addLine(to: CGPoint(x: width, y: height))
                path.closeSubpath()
                
                context.fill(path, with: .color(.purple.opacity(0.5)))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
        }
    }
}

// 网格背景视图
struct GridBackground: View {
    var body: some View {
        Canvas { context, size in
            let gridSize: CGFloat = 50
            let lineWidth: CGFloat = 1
            
            // 绘制垂直线
            for x in stride(from: 0, through: size.width, by: gridSize) {
                var path = Path()
                path.move(to: CGPoint(x: x, y: 0))
                path.addLine(to: CGPoint(x: x, y: size.height))
                context.stroke(path, with: .color(.white.opacity(0.2)), lineWidth: lineWidth)
            }
            
            // 绘制水平线
            for y in stride(from: 0, through: size.height, by: gridSize) {
                var path = Path()
                path.move(to: CGPoint(x: 0, y: y))
                path.addLine(to: CGPoint(x: size.width, y: y))
                context.stroke(path, with: .color(.white.opacity(0.2)), lineWidth: lineWidth)
            }
        }
        .background(Color.black)
    }
}

#Preview {
    FullScreenBackgroundExampleView()
} 