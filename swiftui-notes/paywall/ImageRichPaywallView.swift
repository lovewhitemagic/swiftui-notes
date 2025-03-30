/*
 * 设计名称: ImageRichPaywallView (图像丰富型付费墙)
 * 设计特点:
 * - 使用高质量图像作为背景或点缀
 * - 多媒体展示产品功能，视觉冲击力强
 * - 深色模式下效果更佳，提高对比度
 * - 半透明UI元素与背景图像融合
 * - 强调视觉设计与品牌形象
 * - 提供沉浸式用户体验
 * - 适合拥有优美界面或内容的应用
 */

import SwiftUI

struct ImageRichPaywallView: View {
    // MARK: - 状态属性
    @State private var selectedPlan: SubscriptionType = .yearly
    @State private var isShowingDetails: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - 订阅类型
    enum SubscriptionType: String, CaseIterable, Identifiable {
        case monthly = "月度会员"
        case yearly = "年度会员"
        
        var id: String { self.rawValue }
        
        var price: String {
            switch self {
            case .monthly: return "¥28"
            case .yearly: return "¥218"
            }
        }
        
        var duration: String {
            switch self {
            case .monthly: return "每月"
            case .yearly: return "每年"
            }
        }
        
        var discount: String? {
            switch self {
            case .monthly: return nil
            case .yearly: return "节省35%"
            }
        }
        
        var trialPeriod: String {
            return "7天免费试用"
        }
    }
    
    // MARK: - 特性数据模型
    struct Feature: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let imageName: String
        
        static func features() -> [Feature] {
            return [
                Feature(
                    title: "专业设计模板",
                    description: "获取超过1000种精美设计模板，由专业设计师精心打造。",
                    imageName: "square.and.pencil"
                ),
                Feature(
                    title: "高级编辑功能",
                    description: "解锁全部专业编辑工具，让您的创作更加自由。",
                    imageName: "slider.horizontal.3"
                ),
                Feature(
                    title: "云端存储",
                    description: "无限容量云端存储，随时随地访问您的作品。",
                    imageName: "cloud"
                ),
                Feature(
                    title: "导出无水印",
                    description: "以最高品质导出您的作品，没有任何水印限制。",
                    imageName: "arrow.down.doc"
                )
            ]
        }
    }
    
    // 特性数据
    private let features = Feature.features()
    
    // MARK: - 主视图
    var body: some View {
        ZStack {
            // 背景图层
            backgroundLayer
                .ignoresSafeArea()
            
            // 内容
            ScrollView {
                VStack(spacing: 30) {
                    // 顶部标题区域
                    headerSection
                    
                    // 特性展示区域
                    featuresSection
                    
                    // 订阅选择区域
                    subscriptionSection
                    
                    // 订阅按钮
                    subscribeButton
                    
                    // 底部法律文本
                    legalText
                }
                .padding(.horizontal, 24)
                .padding(.top, 50)
                .padding(.bottom, 30)
            }
            
            // 关闭按钮
            closeButton
        }
        .preferredColorScheme(.dark) // 图像丰富的付费墙通常在深色模式下效果更好
    }
    
    // MARK: - 组件
    // 背景设计
    private var backgroundLayer: some View {
        ZStack {
            // 底部渐变背景
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black,
                    Color(hex: "06283D"),
                    Color(hex: "1A1A40")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // 底部装饰图形
            ZStack {
                // 左下角的圆形
                Circle()
                    .fill(Color.purple.opacity(0.3))
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .offset(x: -UIScreen.main.bounds.width * 0.3, y: UIScreen.main.bounds.height * 0.3)
                    .blur(radius: 50)
                
                // 右上角的圆形
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                    .offset(x: UIScreen.main.bounds.width * 0.3, y: -UIScreen.main.bounds.height * 0.2)
                    .blur(radius: 60)
            }
            
            // 模拟多媒体内容的网格
            VStack(spacing: 0) {
                ForEach(0..<3) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<4) { column in
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
                                .overlay(
                                    Image(systemName: getImageName(row: row, column: column))
                                        .font(.system(size: 24))
                                        .foregroundColor(.white.opacity(0.1))
                                )
                        }
                    }
                }
            }
            .offset(y: -UIScreen.main.bounds.height * 0.4)
            .opacity(0.5)
        }
    }
    
    private var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.white.opacity(0.15))
                        .clipShape(Circle())
                }
                .padding(.top, 50)
                .padding(.trailing, 24)
            }
            Spacer()
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 15) {
            Image(systemName: "sparkles")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            Text("升级到高级会员")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Text("解锁创作的全部潜能")
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
            
            Text("开启免费试用，探索全部高级功能")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 20)
    }
    
    private var featuresSection: some View {
        VStack(spacing: 25) {
            ForEach(features) { feature in
                FeatureCard(feature: feature)
            }
        }
        .padding(.vertical, 10)
    }
    
    private var subscriptionSection: some View {
        VStack(spacing: 16) {
            Text("选择您的会员计划")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 5)
            
            HStack(spacing: 15) {
                ForEach(SubscriptionType.allCases) { type in
                    ImageRichSubscriptionOptionView(
                        type: type,
                        isSelected: selectedPlan == type,
                        action: { selectedPlan = type }
                    )
                }
            }
        }
        .padding(.top, 10)
    }
    
    private var subscribeButton: some View {
        Button(action: {
            // 处理订阅逻辑
            print("用户选择了: \(selectedPlan.rawValue)")
        }) {
            VStack(spacing: 6) {
                Text("开始\(selectedPlan.trialPeriod)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("之后 \(selectedPlan.price)\(selectedPlan.duration)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.purple.opacity(0.5), radius: 10, x: 0, y: 8)
        }
        .padding(.top, 25)
    }
    
    private var legalText: some View {
        VStack(spacing: 12) {
            Text("试用结束后，订阅将自动续费，除非在试用期结束前取消")
                .font(.caption2)
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            
            HStack(spacing: 25) {
                Button("隐私政策") {
                    // 处理隐私政策
                }
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                
                Button("条款和条件") {
                    // 处理条款条件
                }
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                
                Button("恢复购买") {
                    // 处理恢复购买
                }
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding(.top, 20)
    }
    
    // MARK: - 辅助函数
    private func getImageName(row: Int, column: Int) -> String {
        let icons = [
            "photo", "camera", "paintbrush", "pencil.and.ruler", 
            "scissors", "wand.and.stars", "slider.horizontal.3", "paintbrush.pointed",
            "photo.fill", "camera.fill", "rectangle.3.group", "square.and.arrow.up"
        ]
        let index = (row * 4 + column) % icons.count
        return icons[index]
    }
}

// MARK: - 辅助视图
struct FeatureCard: View {
    let feature: ImageRichPaywallView.Feature
    
    var body: some View {
        HStack(alignment: .center, spacing: 18) {
            // 特性图标
            Image(systemName: feature.imageName)
                .font(.system(size: 26))
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.purple.opacity(0.7), .blue.opacity(0.7)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    }
                )
            
            // 特性文本
            VStack(alignment: .leading, spacing: 5) {
                Text(feature.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(feature.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}

struct ImageRichSubscriptionOptionView: View {
    let type: ImageRichPaywallView.SubscriptionType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Text(type.rawValue)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(type.price)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(type.duration)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                
                if let discount = type.discount {
                    Text(discount)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(
                            Capsule()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.green.opacity(0.8), .blue.opacity(0.8)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                        )
                } else {
                    Spacer()
                        .frame(height: 22)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? Color.white.opacity(0.15) : Color.white.opacity(0.1))
                    
                    if isSelected {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(colors: [.purple, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    }
                }
            )
            .scaleEffect(isSelected ? 1.03 : 1.0)
            .animation(.spring(), value: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - 预览
struct ImageRichPaywallView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRichPaywallView()
            .previewDisplayName("图像丰富型Paywall")
    }
} 