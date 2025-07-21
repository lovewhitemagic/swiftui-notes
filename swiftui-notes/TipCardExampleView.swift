import SwiftUI

struct TipCard: View {
    let description: String
    let color: Color
    let isVisible: Binding<Bool>
    
    // 获取浅色版本的颜色
    private func getLightColor(from color: Color) -> Color {
        switch color {
        case .blue:
            return Color(red: 0.93, green: 0.96, blue: 1.0)
        case .green:
            return Color(red: 0.93, green: 0.98, blue: 0.93)
        case .red:
            return Color(red: 1.0, green: 0.93, blue: 0.93)
        case .orange:
            return Color(red: 1.0, green: 0.95, blue: 0.88)
        case .purple:
            return Color(red: 0.96, green: 0.93, blue: 1.0)
        case .yellow:
            return Color(red: 1.0, green: 0.98, blue: 0.88)
        case .pink:
            return Color(red: 1.0, green: 0.93, blue: 0.96)
        case .mint:
            return Color(red: 0.90, green: 0.98, blue: 0.95)
        case .teal:
            return Color(red: 0.88, green: 0.98, blue: 0.98)
        case .cyan:
            return Color(red: 0.88, green: 0.98, blue: 1.0)
        case .indigo:
            return Color(red: 0.93, green: 0.93, blue: 1.0)
        default:
            return Color(red: 0.95, green: 0.95, blue: 0.95)
        }
    }
    
    var body: some View {
        ZStack {
            // 背景
            RoundedRectangle(cornerRadius: 16)
                .fill(getLightColor(from: color))
            
            // 内容
            HStack {
                Text(description)
                    .font(.caption)
                    .foregroundColor(color)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            
            // 关闭按钮 - 右上角
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isVisible.wrappedValue = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
            }
            .padding(.top, 8)
            .padding(.trailing, 8)
        }
        .transition(.asymmetric(
            insertion: .scale.combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        ))
    }
}

struct TipCardExampleView: View {
    @State private var showInfoTip = true
    @State private var showWarningTip = true
    @State private var showSuccessTip = true
    @State private var showErrorTip = true
    @State private var showCustomTip = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("提示卡片示例")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    VStack(spacing: 12) {
                        // 信息提示
                        if showInfoTip {
                            TipCard(
                                description: "这是一个信息提示，用于显示一般性的提示信息给用户。",
                                color: .blue,
                                isVisible: $showInfoTip
                            )
                        }
                        
                        // 警告提示
                        if showWarningTip {
                            TipCard(
                                description: "注意：这是一个警告提示，请仔细阅读相关内容。",
                                color: .orange,
                                isVisible: $showWarningTip
                            )
                        }
                        
                        // 成功提示
                        if showSuccessTip {
                            TipCard(
                                description: "恭喜！操作已成功完成，您可以继续下一步。",
                                color: .green,
                                isVisible: $showSuccessTip
                            )
                        }
                        
                        // 错误提示
                        if showErrorTip {
                            TipCard(
                                description: "出现错误：请检查您的输入并重试。",
                                color: .red,
                                isVisible: $showErrorTip
                            )
                        }
                        
                        // 自定义颜色提示
                        if showCustomTip {
                            TipCard(
                                description: "这是一个自定义紫色主题的提示卡片，展示了组件的灵活性。",
                                color: .purple,
                                isVisible: $showCustomTip
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // 重置按钮
                    Button("重新显示所有提示") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            showInfoTip = true
                            showWarningTip = true
                            showSuccessTip = true
                            showErrorTip = true
                            showCustomTip = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 20)
                    
                    Spacer(minLength: 50)
                }
            }
            .navigationTitle("提示卡片")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TipCardExampleView()
} 