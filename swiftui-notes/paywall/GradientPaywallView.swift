/*
 * 设计名称: GradientPaywallView (渐变背景型付费墙)
 * 设计特点:
 * - 使用现代化渐变背景色，提升视觉吸引力
 * - 半透明卡片设计，营造轻盈感
 * - 突出最受欢迎的订阅选项
 * - 提供限时促销信息，增加紧迫感
 * - 包含动态背景元素，增强交互体验
 * - 使用大胆的文字和图标设计
 * - 适合追求时尚设计感的应用
 */

import SwiftUI

struct GradientPaywallView: View {
    // MARK: - 状态属性
    @State private var selectedOption: SubscriptionOption = .annual
    @State private var animationAmount: CGFloat = 1.0
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - 订阅选项枚举
    enum SubscriptionOption: String, CaseIterable, Identifiable {
        case monthly = "月度会员"
        case quarterly = "季度会员"
        case annual = "年度会员"
        
        var id: String { self.rawValue }
        
        var price: String {
            switch self {
            case .monthly: return "¥28"
            case .quarterly: return "¥68"
            case .annual: return "¥198"
            }
        }
        
        var description: String {
            switch self {
            case .monthly: return "每月自动续费"
            case .quarterly: return "每3个月自动续费"
            case .annual: return "每年自动续费"
            }
        }
        
        var discount: String? {
            switch self {
            case .monthly: return nil
            case .quarterly: return "省20%"
            case .annual: return "省42%"
            }
        }
        
        var isPopular: Bool {
            return self == .annual
        }
        
        var gradientColors: [Color] {
            switch self {
            case .monthly:
                return [Color.purple, Color.blue]
            case .quarterly:
                return [Color.blue, Color.cyan]
            case .annual:
                return [Color.pink, Color.purple]
            }
        }
    }
    
    // MARK: - 主视图
    var body: some View {
        ZStack {
            // 动态渐变背景
            backgroundGradient
                .ignoresSafeArea()
            
            // 前景内容
            ScrollView {
                VStack(spacing: 30) {
                    closeButton
                    
                    headerView
                    
                    featuresView
                    
                    subscriptionOptionsView
                    
                    freeTrialButton
                    
                    legalTexts
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
        .preferredColorScheme(.dark) // 渐变背景型设计通常在深色模式下效果更佳
    }
    
    // MARK: - 背景设计
    private var backgroundGradient: some View {
        GeometryReader { geometry in
            ZStack {
                // 主背景渐变
                LinearGradient(
                    gradient: Gradient(colors: [.black, Color(hex: "1a1a2e"), Color(hex: "16213e")]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // 动态颜色圆形
                ForEach(0..<3) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    selectedOption.gradientColors[index % 2].opacity(0.7),
                                    selectedOption.gradientColors[index % 2].opacity(0.0)
                                ]),
                                center: .center,
                                startRadius: 5,
                                endRadius: geometry.size.width * 0.6
                            )
                        )
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)
                        .position(
                            x: geometry.size.width * [0.2, 0.8, 0.5][index],
                            y: geometry.size.height * [0.2, 0.5, 0.85][index]
                        )
                        .scaleEffect(animationAmount)
                        .animation(
                            Animation.easeInOut(duration: [3, 4, 5][index])
                                .repeatForever(autoreverses: true)
                                .delay(Double(index)),
                            value: animationAmount
                        )
                }
                
                // 浮动小点装饰
                ForEach(0..<20) { index in
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: CGFloat.random(in: 2...5))
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                }
            }
            .onAppear {
                // 启动背景动画
                animationAmount = 1.2
            }
        }
    }
    
    // MARK: - 组件
    private var closeButton: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(8)
                    .background(Color.white.opacity(0.1))
                    .clipShape(Circle())
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 15) {
            Image(systemName: "sparkles")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .padding(20)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.purple.opacity(0.8), .blue.opacity(0.8)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
            
            Text("解锁全部高级功能")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("体验无限可能")
                .font(.headline)
                .foregroundColor(.white.opacity(0.8))
                .padding(.bottom, 5)
            
            Text("限时优惠 - 7天内享受8折优惠")
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.yellow.opacity(0.7), .orange.opacity(0.7)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                )
                .foregroundColor(.white)
        }
        .padding(.vertical, 20)
    }
    
    private var featuresView: some View {
        VStack(spacing: 20) {
            FeatureItem(icon: "infinity", title: "无限制访问", description: "解锁全部高级功能与内容")
            FeatureItem(icon: "icloud", title: "云端同步", description: "跨设备实时同步您的所有数据")
            FeatureItem(icon: "rectangle.and.pencil.and.ellipsis", title: "高级编辑", description: "专业编辑工具与特效")
            FeatureItem(icon: "bell.badge", title: "优先通知", description: "第一时间获取最新功能更新")
        }
        .padding(.vertical, 10)
    }
    
    private var subscriptionOptionsView: some View {
        VStack(spacing: 16) {
            Text("选择您的会员计划")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            
            ForEach(SubscriptionOption.allCases) { option in
                SubscriptionCardView(
                    option: option,
                    isSelected: selectedOption == option,
                    action: { selectedOption = option }
                )
                .scaleEffect(option.isPopular ? 1.05 : 1.0)
            }
        }
        .padding(.vertical, 10)
    }
    
    private var freeTrialButton: some View {
        Button(action: {
            // 处理订阅逻辑
            print("用户选择了: \(selectedOption.rawValue)")
        }) {
            HStack {
                Text("开始3天免费试用")
                    .fontWeight(.bold)
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: selectedOption.gradientColors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.white)
            .cornerRadius(16)
            .shadow(color: selectedOption.gradientColors[0].opacity(0.5), radius: 10, x: 0, y: 5)
        }
        .padding(.top, 10)
    }
    
    private var legalTexts: some View {
        VStack(spacing: 10) {
            Group {
                Text("试用结束后将自动续费，除非在试用期结束前取消")
                + Text("\n价格包含适用的增值税")
                + Text("\n随时可在iTunes账户设置中管理订阅")
            }
            .font(.caption2)
            .foregroundColor(.white.opacity(0.6))
            .multilineTextAlignment(.center)
            
            HStack(spacing: 15) {
                Button("隐私政策") {
                    // 处理隐私政策
                }
                
                Button("条款与条件") {
                    // 处理条款条件
                }
                
                Button("恢复购买") {
                    // 处理恢复购买
                }
            }
            .font(.caption)
            .foregroundColor(.white.opacity(0.8))
        }
        .padding(.top, 20)
    }
}

// MARK: - 辅助视图
struct FeatureItem: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.1))
                )
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
        }
        .padding(.vertical, 5)
    }
}

struct SubscriptionCardView: View {
    let option: GradientPaywallView.SubscriptionOption
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(option.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(option.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text(option.price)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    if let discount = option.discount {
                        Text(discount)
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [.green.opacity(0.7), .blue.opacity(0.7)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                            )
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.1))
                    
                    // 选中状态的边框
                    if isSelected {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: option.gradientColors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    }
                    
                    // 最受欢迎标记
                    if option.isPopular {
                        VStack {
                            HStack {
                                Text("最受欢迎")
                                    .font(.system(size: 10, weight: .bold))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 3)
                                    .background(
                                        Capsule()
                                            .fill(LinearGradient(
                                                gradient: Gradient(colors: option.gradientColors),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            ))
                                    )
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding(.top, -8)
                            .padding(.leading, 10)
                            
                            Spacer()
                        }
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - 颜色扩展
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - 预览
struct GradientPaywallView_Previews: PreviewProvider {
    static var previews: some View {
        GradientPaywallView()
            .previewDisplayName("渐变背景型Paywall")
    }
} 