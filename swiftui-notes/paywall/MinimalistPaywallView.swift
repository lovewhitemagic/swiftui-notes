/*
 * 设计名称: MinimalistPaywallView (简约优雅型付费墙)
 * 设计特点:
 * - 简洁干净的界面布局
 * - 主要使用黑白配色，搭配一个强调色
 * - 清晰的层级结构，重点突出价值主张
 * - 精简的文案描述，突出核心功能价值
 * - 圆角按钮和卡片设计，增强视觉舒适度
 * - 使用SF Symbols图标增强可读性
 * - 订阅选项之间有明确的视觉区分
 */

import SwiftUI

struct MinimalistPaywallView: View {
    // MARK: - 状态属性
    @State private var selectedPlan: SubscriptionPlan = .monthly
    @State private var isAnnualDiscountVisible = true
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - 订阅计划枚举
    enum SubscriptionPlan: String, CaseIterable, Identifiable {
        case monthly = "月度订阅"
        case annual = "年度订阅"
        case lifetime = "终身订阅"
        
        var id: String { self.rawValue }
        
        var price: String {
            switch self {
            case .monthly: return "¥18"
            case .annual: return "¥168"
            case .lifetime: return "¥298"
            }
        }
        
        var description: String {
            switch self {
            case .monthly: return "按月支付，随时取消"
            case .annual: return "年付享8折优惠"
            case .lifetime: return "一次付费，终身使用"
            }
        }
        
        var icon: String {
            switch self {
            case .monthly: return "calendar"
            case .annual: return "calendar.badge.clock"
            case .lifetime: return "infinity"
            }
        }
    }
    
    // MARK: - 主视图
    var body: some View {
        ZStack {
            // 背景色
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // 顶部关闭按钮
                closeButton
                
                // 产品标志和标题
                appHeader
                
                // 功能描述列表
                featuresList
                
                // 订阅选项
                subscriptionOptions
                
                // 续订说明
                renewalDisclosure
                
                // 底部按钮
                subscribeButton
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
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
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color(UIColor.secondarySystemBackground))
                    )
            }
        }
    }
    
    private var appHeader: some View {
        VStack(spacing: 16) {
            Image(systemName: "star.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.blue)
                .padding()
                .background(
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                )
            
            Text("升级至专业版")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("解锁所有高级功能，提升您的使用体验")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 20)
    }
    
    private var featuresList: some View {
        VStack(alignment: .leading, spacing: 16) {
            FeatureRow(icon: "checkmark.circle.fill", text: "无限数量的记录和自定义分类")
            FeatureRow(icon: "checkmark.circle.fill", text: "数据导出和高级统计分析")
            FeatureRow(icon: "checkmark.circle.fill", text: "云同步和多设备支持")
            FeatureRow(icon: "checkmark.circle.fill", text: "自定义主题和深色模式")
            FeatureRow(icon: "checkmark.circle.fill", text: "优先获取最新功能和更新")
        }
        .padding(.vertical, 10)
    }
    
    private var subscriptionOptions: some View {
        VStack(spacing: 16) {
            ForEach(SubscriptionPlan.allCases) { plan in
                SubscriptionOptionCard(
                    plan: plan,
                    isSelected: selectedPlan == plan,
                    action: { selectedPlan = plan }
                )
            }
        }
    }
    
    private var renewalDisclosure: some View {
        Text("订阅会自动续费，可随时在App Store设置中取消")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.top, 10)
    }
    
    private var subscribeButton: some View {
        Button(action: {
            // 处理订阅逻辑
            print("用户选择了: \(selectedPlan.rawValue)")
        }) {
            Text("立即订阅 \(selectedPlan.price)")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(16)
        }
        .padding(.top, 10)
    }
}

// MARK: - 辅助视图
struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 20))
            
            Text(text)
                .font(.body)
        }
    }
}

struct SubscriptionOptionCard: View {
    let plan: MinimalistPaywallView.SubscriptionPlan
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: plan.icon)
                            .font(.system(size: 16))
                        
                        Text(plan.rawValue)
                            .fontWeight(.semibold)
                    }
                    
                    Text(plan.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(plan.price)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if plan == .annual && isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .padding(.leading, 4)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: isSelected ? 2 : 1)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isSelected ? Color.blue.opacity(0.05) : Color(UIColor.secondarySystemBackground))
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - 预览
struct MinimalistPaywallView_Previews: PreviewProvider {
    static var previews: some View {
        MinimalistPaywallView()
            .previewDisplayName("简约优雅型Paywall")
        
        MinimalistPaywallView()
            .preferredColorScheme(.dark)
            .previewDisplayName("简约优雅型Paywall (深色模式)")
    }
} 