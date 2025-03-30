/*
 * 设计名称: FeatureComparisonPaywallView (特性对比型付费墙)
 * 设计特点:
 * - 采用表格式布局，清晰展示免费版与付费版功能对比
 * - 强调"最佳价值"选项，引导用户选择
 * - 使用图标和勾选标记增强视觉清晰度
 * - 订阅价格与功能特性并列展示
 * - 分类展示功能，帮助用户理解产品价值
 * - 包含自由切换订阅计划的交互功能
 * - 适合功能丰富的应用推广高级订阅
 */

import SwiftUI

struct FeatureComparisonPaywallView: View {
    // MARK: - 状态属性
    @State private var selectedPlan: SubscriptionTier = .premium
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - 订阅类型枚举
    enum SubscriptionTier: String, CaseIterable, Identifiable {
        case free = "免费版"
        case premium = "高级版"
        case pro = "专业版"
        
        var id: String { self.rawValue }
        
        var price: String {
            switch self {
            case .free: return "免费"
            case .premium: return "¥18/月"
            case .pro: return "¥30/月"
            }
        }
        
        var yearlyPrice: String {
            switch self {
            case .free: return "免费"
            case .premium: return "¥158/年"
            case .pro: return "¥288/年"
            }
        }
        
        var highlight: Bool {
            return self == .premium
        }
        
        var color: Color {
            switch self {
            case .free: return .gray
            case .premium: return .blue
            case .pro: return .purple
            }
        }
        
        var icon: String {
            switch self {
            case .free: return "leaf"
            case .premium: return "star.fill"
            case .pro: return "wand.and.stars"
            }
        }
    }
    
    // MARK: - 功能类别枚举
    enum FeatureCategory: String, CaseIterable {
        case basic = "基础功能"
        case advanced = "高级功能"
        case sync = "同步与备份"
        case customization = "个性化设置"
    }
    
    // MARK: - 订阅周期切换
    @State private var isYearly: Bool = true
    
    // MARK: - 主视图
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // 顶部关闭按钮
                    closeButton
                    
                    // 标题
                    headerView
                    
                    // 订阅周期切换
                    billingToggle
                    
                    // 订阅计划选择
                    planSelection
                    
                    // 特性对比表格
                    featureComparisonTable
                    
                    // 订阅按钮
                    subscribeButton
                    
                    // 法律声明
                    legalDisclosure
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
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
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                    .padding(8)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(Circle())
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 12) {
            Text("选择最适合您的计划")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("比较各个计划的功能，选择满足您需求的选项")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.bottom, 16)
    }
    
    private var billingToggle: some View {
        VStack(spacing: 8) {
            HStack(spacing: 20) {
                billingButton(title: "月付", isSelected: !isYearly) {
                    isYearly = false
                }
                
                billingButton(title: "年付", isSelected: isYearly) {
                    isYearly = true
                }
            }
            
            if isYearly {
                Text("年付可节省20%")
                    .font(.caption)
                    .foregroundColor(.green)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.green.opacity(0.1))
                    )
            }
        }
        .padding(.bottom, 16)
    }
    
    private func billingButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.blue : Color(UIColor.secondarySystemBackground))
                )
        }
    }
    
    private var planSelection: some View {
        HStack(spacing: 10) {
            ForEach(SubscriptionTier.allCases) { tier in
                PlanCard(
                    tier: tier,
                    isSelected: selectedPlan == tier,
                    isYearly: isYearly,
                    action: { selectedPlan = tier }
                )
            }
        }
        .padding(.vertical, 10)
    }
    
    private var featureComparisonTable: some View {
        VStack(spacing: 24) {
            ForEach(FeatureCategory.allCases, id: \.self) { category in
                featureCategorySection(category)
            }
        }
        .padding(.vertical, 10)
    }
    
    private func featureCategorySection(_ category: FeatureCategory) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(category.rawValue)
                .font(.headline)
                .padding(.bottom, 4)
            
            featureRows(for: category)
        }
    }
    
    private func featureRows(for category: FeatureCategory) -> some View {
        VStack(spacing: 14) {
            switch category {
            case .basic:
                FeatureComparisonRow(feature: "基础数据记录", 
                                     tiers: [true, true, true])
                FeatureComparisonRow(feature: "数据导出 CSV", 
                                     tiers: [false, true, true])
                FeatureComparisonRow(feature: "每月报告", 
                                     tiers: [false, true, true])
            case .advanced:
                FeatureComparisonRow(feature: "高级图表分析", 
                                     tiers: [false, true, true])
                FeatureComparisonRow(feature: "自定义报告", 
                                     tiers: [false, false, true])
                FeatureComparisonRow(feature: "预测分析", 
                                     tiers: [false, false, true])
            case .sync:
                FeatureComparisonRow(feature: "云端备份", 
                                     tiers: [false, true, true])
                FeatureComparisonRow(feature: "多设备同步", 
                                     tiers: [false, true, true])
                FeatureComparisonRow(feature: "实时协作", 
                                     tiers: [false, false, true])
            case .customization:
                FeatureComparisonRow(feature: "自定义主题", 
                                     tiers: [false, true, true])
                FeatureComparisonRow(feature: "自定义小组件", 
                                     tiers: [false, true, true])
                FeatureComparisonRow(feature: "API 集成", 
                                     tiers: [false, false, true])
            }
        }
    }
    
    private var subscribeButton: some View {
        Button(action: {
            // 处理订阅逻辑
            print("用户选择了: \(selectedPlan.rawValue), \(isYearly ? "年付" : "月付")")
        }) {
            Text("开始使用 \(selectedPlan.rawValue)")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedPlan == .free ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .disabled(selectedPlan == .free)
        .padding(.vertical, 10)
    }
    
    private var legalDisclosure: some View {
        VStack(spacing: 8) {
            Text("订阅会自动续费，可随时在App Store设置中取消")
                .font(.caption2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            HStack {
                Button(action: {
                    // 隐私政策
                }) {
                    Text("隐私政策")
                        .font(.caption2)
                        .foregroundColor(.blue)
                }
                
                Text("·")
                    .foregroundColor(.secondary)
                
                Button(action: {
                    // 服务条款
                }) {
                    Text("服务条款")
                        .font(.caption2)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.top, 10)
    }
}

// MARK: - 辅助视图
struct PlanCard: View {
    let tier: FeatureComparisonPaywallView.SubscriptionTier
    let isSelected: Bool
    let isYearly: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                if tier.highlight {
                    Text("最佳价值")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(tier.color)
                        .cornerRadius(4)
                } else {
                    Spacer()
                        .frame(height: 18)
                }
                
                Image(systemName: tier.icon)
                    .font(.system(size: 24))
                    .foregroundColor(tier.color)
                
                Text(tier.rawValue)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(isYearly ? tier.yearlyPrice : tier.price)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? tier.color : Color.gray.opacity(0.3), lineWidth: isSelected ? 2 : 1)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isSelected ? tier.color.opacity(0.1) : Color(UIColor.secondarySystemBackground))
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FeatureComparisonRow: View {
    let feature: String
    let tiers: [Bool]  // 表示各个订阅级别是否拥有该功能，顺序与SubscriptionTier枚举一致
    
    var body: some View {
        HStack {
            Text(feature)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(0..<tiers.count, id: \.self) { index in
                HStack {
                    Spacer()
                    
                    if tiers[index] {
                        Image(systemName: "checkmark")
                            .foregroundColor(getTierColor(index))
                            .frame(maxWidth: .infinity)
                    } else {
                        Image(systemName: "minus")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    private func getTierColor(_ index: Int) -> Color {
        switch index {
        case 0: return .gray
        case 1: return .blue
        case 2: return .purple
        default: return .primary
        }
    }
}

// MARK: - 预览
struct FeatureComparisonPaywallView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureComparisonPaywallView()
            .previewDisplayName("特性对比型Paywall")
        
        FeatureComparisonPaywallView()
            .preferredColorScheme(.dark)
            .previewDisplayName("特性对比型Paywall (深色模式)")
    }
} 