/*
 * 设计名称: CardStylePaywallView (卡片式布局付费墙)
 * 设计特点:
 * - 采用卡片组件展示不同订阅选项
 * - 每个订阅选项以卡片形式直观展示
 * - 卡片可以滑动切换，增强交互体验
 * - 使用阴影和深度效果增强视觉层次感
 * - 清晰的价格和功能对比
 * - 具有现代感的设计语言
 * - 适合展示多种订阅选项的应用
 */

import SwiftUI

struct CardStylePaywallView: View {
    // MARK: - 状态属性
    @State private var currentCardIndex: Int = 1  // 默认选中中间的卡片
    @State private var dragOffset: CGFloat = 0
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - 订阅套餐数据
    struct SubscriptionPlan: Identifiable {
        let id = UUID()
        let title: String
        let period: String
        let price: String
        let originalPrice: String?
        let featuresTitle: String
        let features: [String]
        let ctaButtonText: String
        let cardColor: Color
        let isPopular: Bool
        
        // 便捷创建函数
        static func plans() -> [SubscriptionPlan] {
            return [
                SubscriptionPlan(
                    title: "基础会员",
                    period: "月付",
                    price: "¥18",
                    originalPrice: nil,
                    featuresTitle: "包含以下功能",
                    features: [
                        "无广告体验",
                        "基础功能解锁",
                        "云端存储10GB"
                    ],
                    ctaButtonText: "开始基础会员",
                    cardColor: Color.blue.opacity(0.1),
                    isPopular: false
                ),
                SubscriptionPlan(
                    title: "高级会员",
                    period: "年付",
                    price: "¥128",
                    originalPrice: "¥216",
                    featuresTitle: "包含以下所有功能",
                    features: [
                        "无广告体验",
                        "所有功能完全解锁",
                        "云端存储100GB",
                        "优先客户支持",
                        "专属内容更新"
                    ],
                    ctaButtonText: "选择高级会员",
                    cardColor: Color.purple.opacity(0.15),
                    isPopular: true
                ),
                SubscriptionPlan(
                    title: "终身会员",
                    period: "一次性付费",
                    price: "¥298",
                    originalPrice: "¥398",
                    featuresTitle: "一次付费，终身享有",
                    features: [
                        "无广告体验",
                        "所有功能完全解锁",
                        "云端存储200GB",
                        "VIP客户支持",
                        "优先获取新功能",
                        "终身免费更新"
                    ],
                    ctaButtonText: "获取终身会员",
                    cardColor: Color.orange.opacity(0.15),
                    isPopular: false
                )
            ]
        }
    }
    
    // 订阅计划数据
    private let subscriptionPlans = SubscriptionPlan.plans()
    
    // 卡片尺寸常量
    private let cardWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    private let cardPadding: CGFloat = 10
    private let cardOffset: CGFloat = UIScreen.main.bounds.width * 0.1
    
    // MARK: - 主视图
    var body: some View {
        ZStack {
            // 背景
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            // 内容
            VStack(spacing: 20) {
                // 顶部关闭按钮
                closeButton
                
                // 标题
                headerView
                
                // 卡片滑动区域
                cardsCarouselView
                
                // 卡片指示器
                pageIndicator
                
                // 价格说明
                pricingInfoView
                
                // 特性列表
                featuresListView
                
                // 订阅按钮
                subscribeButtonView
                
                // 底部法律声明
                legalTextView
            }
            .padding(.top, 15)
            .padding(.bottom, 25)
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
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(Color(UIColor.tertiarySystemFill))
                    .clipShape(Circle())
            }
            .padding(.trailing, 20)
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("选择您的会员计划")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
            
            Text("解锁更多高级功能")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 30)
    }
    
    private var cardsCarouselView: some View {
        ZStack {
            ForEach(Array(subscriptionPlans.enumerated()), id: \.element.id) { index, plan in
                // 卡片视图
                CardSubscriptionView(plan: plan, width: cardWidth)
                    .offset(x: offset(for: index) + dragOffset, y: 0)
                    .scaleEffect(scale(for: index))
                    .zIndex(currentCardIndex == index ? 1 : 0)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
        }
        .frame(height: 350)
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation.width
                }
                .onEnded { value in
                    // 滑动方向和距离判断
                    withAnimation(.spring()) {
                        // 计算滑动的距离和方向
                        let swipeDistance = value.translation.width
                        let swipeThreshold: CGFloat = 50
                        
                        if swipeDistance > swipeThreshold && currentCardIndex > 0 {
                            // 向右滑动，显示上一张卡片
                            currentCardIndex -= 1
                        } else if swipeDistance < -swipeThreshold && currentCardIndex < subscriptionPlans.count - 1 {
                            // 向左滑动，显示下一张卡片
                            currentCardIndex += 1
                        }
                        
                        // 重置拖动偏移量
                        dragOffset = 0
                    }
                }
        )
    }
    
    private var pageIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<subscriptionPlans.count, id: \.self) { index in
                Circle()
                    .fill(currentCardIndex == index ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.top, 10)
    }
    
    private var pricingInfoView: some View {
        VStack {
            if let originalPrice = subscriptionPlans[currentCardIndex].originalPrice {
                HStack(spacing: 6) {
                    Text("原价:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(originalPrice)
                        .font(.caption)
                        .strikethrough()
                        .foregroundColor(.secondary)
                    
                    Text("现在:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(subscriptionPlans[currentCardIndex].price)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                if currentCardIndex == 1 { // 只对年度会员展示折扣
                    Text("相当于每月¥10.7，比月付节省40%")
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(.top, 2)
                }
            } else {
                Text(subscriptionPlans[currentCardIndex].price + " / " + subscriptionPlans[currentCardIndex].period)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .frame(height: 40)
    }
    
    private var featuresListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(subscriptionPlans[currentCardIndex].featuresTitle)
                .font(.headline)
                .padding(.bottom, 4)
            
            ForEach(subscriptionPlans[currentCardIndex].features, id: \.self) { feature in
                CardFeatureRow(text: feature)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
    }
    
    private var subscribeButtonView: some View {
        Button(action: {
            // 处理订阅动作
            print("用户选择了: \(subscriptionPlans[currentCardIndex].title)")
        }) {
            Text(subscriptionPlans[currentCardIndex].ctaButtonText)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(16)
        }
        .padding(.horizontal, 30)
        .padding(.top, 10)
    }
    
    private var legalTextView: some View {
        VStack(spacing: 8) {
            Text("订阅会自动续费，可随时在App Store设置中取消")
                .font(.caption2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            HStack(spacing: 20) {
                Button("隐私政策") {
                    // 处理隐私政策
                }
                
                Button("使用条款") {
                    // 处理使用条款
                }
                
                Button("恢复购买") {
                    // 处理恢复购买
                }
            }
            .font(.caption)
            .foregroundColor(.blue)
        }
        .padding(.top, 15)
    }
    
    // MARK: - 辅助函数
    // 计算卡片水平偏移量
    private func offset(for index: Int) -> CGFloat {
        // 相对于当前选中卡片的偏移量
        let relativeIndex = CGFloat(index - currentCardIndex)
        return relativeIndex * (cardWidth + cardPadding)
    }
    
    // 计算卡片缩放比例
    private func scale(for index: Int) -> CGFloat {
        if index == currentCardIndex {
            return 1.0
        } else {
            return 0.9
        }
    }
}

// MARK: - 辅助视图
struct CardSubscriptionView: View {
    let plan: CardStylePaywallView.SubscriptionPlan
    let width: CGFloat
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            // 卡片顶部
            cardHeader
            
            // 卡片内容
            cardContent
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 15)
        .frame(width: width)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(plan.cardColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
    
    private var cardHeader: some View {
        VStack(spacing: 10) {
            if plan.isPopular {
                Text("最受欢迎")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.blue)
                    )
                    .foregroundColor(.white)
            }
            
            Image(systemName: plan.isPopular ? "star.fill" : "star")
                .font(.system(size: 30))
                .foregroundColor(plan.isPopular ? .blue : .gray)
                .padding(.top, plan.isPopular ? 5 : 25)
            
            Text(plan.title)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(plan.period)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var cardContent: some View {
        VStack(spacing: 15) {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text(plan.price)
                    .font(.system(size: 32, weight: .bold))
                
                Text("/" + plan.period.lowercased())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let originalPrice = plan.originalPrice {
                Text("原价 \(originalPrice)")
                    .font(.caption)
                    .strikethrough()
                    .foregroundColor(.secondary)
            }
            
            Divider()
                .padding(.vertical, 5)
            
            Text("包含的功能")
                .font(.headline)
                .padding(.top, 5)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(plan.features.prefix(3), id: \.self) { feature in
                    HStack {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12))
                            .foregroundColor(.green)
                        
                        Text(feature)
                            .font(.caption)
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                }
                
                if plan.features.count > 3 {
                    HStack {
                        Text("更多功能...")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct CardFeatureRow: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 16))
            
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

// MARK: - 预览
struct CardStylePaywallView_Previews: PreviewProvider {
    static var previews: some View {
        CardStylePaywallView()
            .previewDisplayName("卡片式布局Paywall")
        
        CardStylePaywallView()
            .preferredColorScheme(.dark)
            .previewDisplayName("卡片式布局Paywall (深色模式)")
    }
} 