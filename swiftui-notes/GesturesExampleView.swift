import SwiftUI

struct GesturesExampleView: View {
    // 基础手势状态
    @State private var offset = CGSize.zero
    @State private var rotation = Angle.zero
    @State private var scale: CGFloat = 1.0
    
    // 组合手势状态
    @State private var position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    @State private var dragOffset = CGSize.zero
    
    // 长按状态
    @State private var isLongPressed = false
    
    // 双击状态
    @State private var doubleTapCount = 0
    
    // 空间手势状态
    @State private var tapLocation: CGPoint?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // 拖拽手势示例
                    GestureCard("拖拽手势 (DragGesture)") {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.blue)
                            .frame(width: 100, height: 100)
                            .offset(offset)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        offset = gesture.translation
                                    }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            offset = .zero
                                        }
                                    }
                            )
                    }
                    
                    // 旋转手势示例
                    GestureCard("旋转手势 (RotationGesture)") {
                        Image(systemName: "arrow.up")
                            .font(.largeTitle)
                            .foregroundStyle(.blue)
                            .rotationEffect(rotation)
                            .gesture(
                                RotationGesture()
                                    .onChanged { angle in
                                        rotation = angle
                                    }
                            )
                    }
                    
                    // 缩放手势示例
                    GestureCard("缩放手势 (MagnificationGesture)") {
                        Image(systemName: "star.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.yellow)
                            .scaleEffect(scale)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        scale = value
                                    }
                                    .onEnded { _ in
                                        withAnimation(.spring()) {
                                            scale = 1.0
                                        }
                                    }
                            )
                    }
                    
                    // 长按手势示例
                    GestureCard("长按手势 (LongPressGesture)") {
                        Circle()
                            .fill(isLongPressed ? .green : .blue)
                            .frame(width: 100, height: 100)
                            .scaleEffect(isLongPressed ? 1.2 : 1.0)
                            .animation(.spring(), value: isLongPressed)
                            .gesture(
                                LongPressGesture(minimumDuration: 1)
                                    .onEnded { _ in
                                        isLongPressed.toggle()
                                    }
                            )
                    }
                    
                    // 双击手势示例
                    GestureCard("双击手势 (TapGesture)") {
                        Text("双击次数: \(doubleTapCount)")
                            .font(.title)
                            .padding()
                            .background(.blue.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .gesture(
                                TapGesture(count: 2)
                                    .onEnded {
                                        doubleTapCount += 1
                                    }
                            )
                    }
                    
                    // 空间手势示例
                    GestureCard("空间手势 (SpatialTapGesture)") {
                        Rectangle()
                            .fill(.blue.opacity(0.2))
                            .frame(height: 200)
                            .overlay {
                                if let location = tapLocation {
                                    Circle()
                                        .fill(.blue)
                                        .frame(width: 20, height: 20)
                                        .position(location)
                                }
                            }
                            .gesture(
                                SpatialTapGesture()
                                    .onEnded { event in
                                        tapLocation = event.location
                                    }
                            )
                    }
                    
                    // 组合手势示例
                    GestureCard("组合手势") {
                        let dragGesture = DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation
                            }
                            .onEnded { _ in
                                position.x += dragOffset.width
                                position.y += dragOffset.height
                                dragOffset = .zero
                            }
                        
                        let rotationGesture = RotationGesture()
                            .onChanged { angle in
                                rotation = angle
                            }
                        
                        let scaleGesture = MagnificationGesture()
                            .onChanged { value in
                                scale = value
                            }
                        
                        let combinedGesture = dragGesture
                            .simultaneously(with: rotationGesture)
                            .simultaneously(with: scaleGesture)
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.blue)
                            .frame(width: 100, height: 100)
                            .position(position)
                            .offset(dragOffset)
                            .rotationEffect(rotation)
                            .scaleEffect(scale)
                            .gesture(combinedGesture)
                    }
                }
                .padding()
            }
            .navigationTitle("手势示例")
        }
    }
}

// 手势卡片视图
struct GestureCard<Content: View>: View {
    let title: String
    let content: () -> Content
    
    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            
            content()
                .frame(maxWidth: .infinity, minHeight: 100)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.gray.opacity(0.1))
                )
        }
    }
}

#Preview {
    GesturesExampleView()
} 