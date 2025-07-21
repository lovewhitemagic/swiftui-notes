import SwiftUI

struct BlurEffectExampleView: View {
    var body: some View {
        ZStack {
            // 背景内容-最底层
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<20, id: \.self) { index in
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
                .padding(.horizontal)
                .padding(.top, 50)
                .padding(.bottom, 100)
            }
            
            // 顶部模糊浮动导航栏-在内容上层
            VariableBlurView(maxBlurRadius: 7, direction: .blurredTopClearBottom)
                .frame(height: 120)
                .ignoresSafeArea(edges: .top)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
             // 底部模糊背景-在内容上层
            VariableBlurView(maxBlurRadius: 6, direction: .blurredBottomClearTop)
                .frame(height: 70)
                .ignoresSafeArea(edges: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
            // 顶部导航栏文字-在内容和上层模糊浮动导航栏最上层
            Text("模糊导航栏")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            // 底部浮动按钮-在内容和上层模糊浮动导航栏最上层
            Button(action: {
                // 按钮动作
            }) {
                Text("浮动按钮")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    BlurEffectExampleView()
} 