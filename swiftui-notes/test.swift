import SwiftUI

struct BlurEffectExampleView: View {
    var body: some View {
        ZStack(alignment: .top) {
            // 背景内容
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<20) { index in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.1))
                            .frame(height: 80)
                            .overlay(
                                Text("内容卡片 \(index + 1)")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                            )
                    }
                }
                .padding([.horizontal, .top], 20)
                .padding(.bottom, 100)
            }

            // 顶部模糊导航栏
            VariableBlurView(maxBlurRadius: 7, direction: .blurredTopClearBottom)
                .frame(height: 120)
                .ignoresSafeArea(edges: .top)

            // 顶部文字
            Text("模糊导航栏")
                .font(.title2)
                .padding(.top, 50)

            // 底部模糊背景 + 按钮
            VStack {
                Spacer()
                VariableBlurView(maxBlurRadius: 6, direction: .blurredBottomClearTop)
                    .frame(height: 70)
                    .ignoresSafeArea(edges: .bottom)

                Button(action: {}) {
                    Text("浮动按钮")
                        .font(.headline)
                        .foregroundColor(.white)
                     .padding(.horizontal, 24)
                        .padding(.vertical, 12)
        .background(Color.blue)
                        .cornerRadius(25)
                }
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    BlurEffectExampleView()
}