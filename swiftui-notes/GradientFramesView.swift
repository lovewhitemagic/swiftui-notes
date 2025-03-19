import SwiftUI

struct GradientFramesView: View {
    let frameCount = 10
    let baseInsetAmount: CGFloat = 20 // 底部偏移量
    let topInsetAmount: CGFloat = 0 // 顶部偏移量
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            GeometryReader { geometry in
                Color.clear.preference(key: GradientScrollOffsetKey.self,
                    value: geometry.frame(in: .named("scroll")).minY)
            }
            .frame(height: 0)
            
            VStack(spacing: 0) {
                ForEach(0..<frameCount, id: \.self) { index in
                    GeometryReader { innerGeometry in
                        ZStack {
                            RoundedRectangle(cornerRadius: index == 0 ? 20 : 0)
                                .fill(Color(white: Double(frameCount - index) / Double(frameCount)))
                                .frame(width: innerGeometry.size.width, height: 750)
                                .clipShape(
                                    Path { path in
                                        let topOffset = scrollOffset / 10
                                        let dynamicBaseInset = baseInsetAmount + CGFloat(index) * 20 // 底部偏移递增
                                        
                                        // 顶部两点随滚动位置变化
                                        path.move(to: CGPoint(x: max(0, topOffset + topInsetAmount), y: 0))
                                        path.addLine(to: CGPoint(x: min(innerGeometry.size.width, innerGeometry.size.width + topOffset - topInsetAmount), y: 0))
                                        
                                        // 底部两点递增偏移
                                        path.addLine(to: CGPoint(x: innerGeometry.size.width - dynamicBaseInset, y: 750))
                                        path.addLine(to: CGPoint(x: dynamicBaseInset, y: 750))
                                        path.closeSubpath()
                                    }
                                )
                            
                            // 添加长文本
                            Text("""
                            在快节奏的生活中，我们常常忽略身边的美好。清晨的阳光透过窗户洒在桌面上，空气中弥漫着咖啡的香气，街道上的行人匆匆而过，每个人都怀揣着自己的故事。或许，我们总是被忙碌裹挟，忽视了那些微小却温暖的瞬间。
                            
                            一封意外收到的短信、一杯好友递来的热茶、黄昏时分天边渐变的色彩……这些看似不起眼的细节，实则构成了生活最真实的底色。现代社会的节奏让人不自觉地追逐目标，似乎只有不断前进，才能证明自己的价值。但我们是否曾停下来，问问自己：真正的幸福究竟是什么？
                            
                            幸福或许并不需要宏大的成就，也不是远方才有的风景。它存在于日常的点滴之中，只要用心去感受，就会发现它从未远离。一个温暖的微笑，一句简单的"谢谢"，一场不期而遇的细雨，甚至是独自一人的午后时光，都是生命中值得珍惜的馈赠。
                            
                            学会慢下来，让心灵与世界重新对话。清晨醒来时，不妨给自己几分钟，感受窗外的微风；走在路上，抬头看看天上的云，听听街头艺人的旋律；在忙碌的工作间隙，闭上眼睛，深呼吸，给自己一个放松的机会。生活不仅仅是目标和结果，更是每一个当下的体验。
                            
                            愿我们都能在平凡的日子里，找到属于自己的小确幸，让生活在忙碌之余，也能充满温暖与诗意。
                            """)
                            .padding()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                        }
                        .offset(y: CGFloat(index) * -650) // 增加负值以减小间距
                        .zIndex(Double(frameCount - index)) // 使用 zIndex 堆叠
                        .frame(height: 750 + scrollOffset / 40) // 动态调整高度
                    }
                    .frame(height: 750) // 确保每个 frame 的高度
                }
            }
            //.padding(.vertical, 120) // 添加垂直方向的内边距
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(GradientScrollOffsetKey.self) { value in
            scrollOffset = value
        }
        .frame(maxHeight: .infinity) // 让 ScrollView 填充整个可用高度
    }
}

// 重命名为 GradientScrollOffsetKey
private struct GradientScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    GradientFramesView()
} 