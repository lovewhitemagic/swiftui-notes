/*
 * 设计名称: InteractivePaywallView (动态交互型付费墙)
 * 设计特点:
 * - 包含丰富的动画和交互元素
 * - 使用视差滚动增强用户体验
 * - 实时反馈用户操作
 * - 强调内容流动与过渡效果
 * - 用户可以通过滑动/点击探索不同价值主张
 * - 引导用户自然地完成转化流程
 * - 适合想要提供沉浸式体验的高端应用
 */

import SwiftUI

struct InteractivePaywallView: View {
    // MARK: - 状态属性
    @State private var selectedBenefit: Int = 0
    @State private var highlightedFeature: Int = 0
    @State private var isShowingPlanDetails: Bool = false
    @State private var selectedPlan: SubscriptionPlan = .yearly
    @State private var animateIcon: Bool = false
    @State private var scrollOffset: CGFloat = 0
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - 数据模型
    enum SubscriptionPlan: String, CaseIterable, Identifiable {
        case monthly = "月付"
        case yearly = "年付"
        
        var id: String { self.rawValue }
        
        var price: String {
            switch self {
            case .monthly: return "¥28"
            case .yearly: return "¥248"
            }
        }
        
        var period: String {
            switch self {
            case .monthly: return "每月"
            case .yearly: return "每年"
            }
        }
        
        var savingsText: String? {
            switch self {
            case .monthly: return nil
            case .yearly: return "较月付节省26%"
            }
        }
        
        var color: Color {
            switch self {
            case .monthly: return Color.blue
            case .yearly: return Color.purple
            }
        }
    }
    
    // 核心优势数据
    struct Benefit: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let iconName: String
        let color: Color
        
        static func benefits() -> [Benefit] {
            return [
                Benefit(
                    title: "解锁高级功能",
                    description: "获取全部专业功能，充分发挥创造力",
                    iconName: "wand.and.stars",
                    color: .purple
                ),
                Benefit(
                    title: "无限内容访问",
                    description: "访问所有高级内容和模板库",
                    iconName: "infinity",
                    color: .blue
                ),
                Benefit(
                    title: "云端同步",
                    description: "在多台设备之间无缝同步您的数据",
                    iconName: "cloud",
                    color: .cyan
                ),
                Benefit(
                    title: "优先支持",
                    description: "获得专属客服支持，解决您的问题",
                    iconName: "person.fill.checkmark",
                    color: .green
                )
            ]
        }
    }
    
    // 功能项数据
    struct FeatureItem: Identifiable {
        let id = UUID()
        let name: String
        
        static func features() -> [FeatureItem] {
            return [
                FeatureItem(name: "无限项目创建"),
                FeatureItem(name: "高级图表分析"),
                FeatureItem(name: "导出PDF和CSV"),
                FeatureItem(name: "批量处理工具"),
                FeatureItem(name: "自定义模板"),
                FeatureItem(name: "智能推荐"),
                FeatureItem(name: "无水印导出"),
                FeatureItem(name: "协作功能")
            ]
        }
    }
    
    // 数据实例
    private let benefits = Benefit.benefits()
    private let features = FeatureItem.features()
    
    // 计时器
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // MARK: - 主视图
    var body: some View {
        ZStack {
            // 背景
            background
            
            // 内容
            VStack(spacing: 0) {
                // 关闭按钮
                closeButtonArea
                
                ScrollView {
                    VStack(spacing: 25) {
                        // 标题区域
                        headerSection
                        
                        // 核心优势区域（可横向滑动）
                        benefitCarouselSection
                        
                        // 功能列表区域（交互动画）
                        featuresSection
                        
                        // 计划选择区域
                        subscriptionSection
                        
                        // 订阅按钮和说明
                        callToActionSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                    // 监听滚动
                    .background(GeometryReader { proxy in
                        Color.clear.preference(
                            key: InteractiveScrollOffsetPreferenceKey.self,
                            value: proxy.frame(in: .named("scrollView")).minY
                        )
                    })
                    .onPreferenceChange(InteractiveScrollOffsetPreferenceKey.self) { value in
                        scrollOffset = value
                    }
                }
                .coordinateSpace(name: "scrollView")
            }
        }
        .onAppear {
            // 启动图标动画
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                animateIcon = true
            }
            
            // 定时切换高亮功能
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    highlightedFeature = 1
                }
            }
        }
        .onReceive(timer) { _ in
            // 定时轮换高亮的功能
            withAnimation {
                highlightedFeature = (highlightedFeature + 1) % features.count
            }
        }
    }
    
    // MARK: - 背景
    private var background: some View {
        ZStack {
            // 基础背景
            Color(UIColor.systemBackground)
                .ignoresSafeArea()
            
            // 动态背景元素
            ZStack {
                // 顶部渐变圆
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [benefits[selectedBenefit].color.opacity(0.2), Color.clear]),
                            center: .center,
                            startRadius: 1,
                            endRadius: 300
                        )
                    )
                    .frame(width: 300, height: 300)
                    .offset(x: 100, y: -200 + scrollOffset * 0.5) // 视差效果
                
                // 底部渐变圆
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [selectedPlan.color.opacity(0.15), Color.clear]),
                            center: .center,
                            startRadius: 5,
                            endRadius: 200
                        )
                    )
                    .frame(width: 250, height: 250)
                    .offset(x: -120, y: 300 - scrollOffset * 0.3) // 视差效果
            }
        }
    }
    
    // MARK: - 组件
    private var closeButtonArea: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary.opacity(0.7))
                    .padding(10)
                    .background(Circle().fill(Color(UIColor.tertiarySystemBackground)))
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
            }
            .padding(.trailing, 20)
            .padding(.top, 15)
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 15) {
            // 动态图标
            Image(systemName: benefits[selectedBenefit].iconName)
                .font(.system(size: 50))
                .foregroundColor(benefits[selectedBenefit].color)
                .scaleEffect(animateIcon ? 1.1 : 1.0)
                .shadow(color: benefits[selectedBenefit].color.opacity(0.5), radius: 8, x: 0, y: 4)
                .padding()
            
            // 标题
            Text("升级到专业版")
                .font(.system(size: 30, weight: .bold))
                .multilineTextAlignment(.center)
            
            // 副标题
            Text("获得完整的专业级体验")
                .font(.title3)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
        }
        .padding(.top, 20)
        .padding(.bottom, 10)
    }
    
    private var benefitCarouselSection: some View {
        VStack(spacing: 10) {
            // 标题
            Text("专业版特权")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            
            // 轮播视图
            TabView(selection: $selectedBenefit) {
                ForEach(Array(benefits.enumerated()), id: \.element.id) { index, benefit in
                    BenefitCard(benefit: benefit, isSelected: selectedBenefit == index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(height: 180)
            .animation(.spring(), value: selectedBenefit)
        }
        .padding(.vertical, 5)
    }
    
    private var featuresSection: some View {
        VStack(spacing: 15) {
            // 标题
            Text("包含全部功能")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            
            // 功能网格
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 15) {
                ForEach(Array(features.enumerated()), id: \.element.id) { index, feature in
                    FeatureCell(
                        feature: feature,
                        isHighlighted: highlightedFeature == index
                    )
                }
            }
        }
        .padding(.vertical, 10)
    }
    
    private var subscriptionSection: some View {
        VStack(spacing: 15) {
            // 标题
            Text("选择您的计划")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 5)
            
            // 计划选择器
            HStack(spacing: 15) {
                ForEach(SubscriptionPlan.allCases) { plan in
                    PlanOptionView(
                        plan: plan,
                        isSelected: selectedPlan == plan,
                        action: {
                            withAnimation(.spring()) {
                                selectedPlan = plan
                            }
                        }
                    )
                }
            }
            
            // 计划详情
            if isShowingPlanDetails {
                VStack(alignment: .leading, spacing: 10) {
                    Text("计划详情")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Text("• 7天免费试用期\n• 随时取消\n• 所有设备都可使用\n• 高级客户支持")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 5)
                .transition(.opacity)
            }
            
            // 显示/隐藏详情按钮
            Button(action: {
                withAnimation {
                    isShowingPlanDetails.toggle()
                }
            }) {
                HStack {
                    Text(isShowingPlanDetails ? "隐藏详情" : "查看详情")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Image(systemName: isShowingPlanDetails ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.top, 5)
        }
        .padding(.vertical, 10)
    }
    
    private var callToActionSection: some View {
        VStack(spacing: 15) {
            // 订阅按钮
            Button(action: {
                // 处理订阅逻辑
                print("用户选择了: \(selectedPlan.rawValue), 价格: \(selectedPlan.price)")
            }) {
                HStack {
                    Text("开始7天免费试用")
                        .fontWeight(.bold)
                    
                    Image(systemName: "arrow.right")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [selectedPlan.color, selectedPlan.color.opacity(0.8)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(16)
                .shadow(color: selectedPlan.color.opacity(0.4), radius: 10, x: 0, y: 5)
            }
            
            // 价格信息
            HStack {
                Text("试用结束后 ")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("\(selectedPlan.price)\(selectedPlan.period)")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                if let savingsText = selectedPlan.savingsText {
                    Text(" · \(savingsText)")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
            
            // 法律信息
            Group {
                Text("订阅会自动续费，除非在付费周期开始前至少24小时取消")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
                
                HStack(spacing: 16) {
                    Button("隐私政策") {
                        // 处理隐私政策
                    }
                    
                    Button("服务条款") {
                        // 处理服务条款
                    }
                    
                    Button("恢复购买") {
                        // 处理恢复购买
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding(.top, 15)
    }
}

// MARK: - 辅助视图
struct BenefitCard: View {
    let benefit: InteractivePaywallView.Benefit
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // 图标
            Image(systemName: benefit.iconName)
                .font(.system(size: 30))
                .foregroundColor(benefit.color)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .fill(benefit.color.opacity(0.1))
                )
            
            // 标题
            Text(benefit.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            // 描述
            Text(benefit.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? benefit.color : Color.clear, lineWidth: 2)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(), value: isSelected)
        .padding(.horizontal, 10)
    }
}

struct FeatureCell: View {
    let feature: InteractivePaywallView.FeatureItem
    let isHighlighted: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            // 勾选图标
            Image(systemName: "checkmark")
                .font(.system(size: 12))
                .foregroundColor(.white)
                .padding(4)
                .background(
                    Circle()
                        .fill(isHighlighted ? Color.green : Color.blue)
                )
            
            // 功能名称
            Text(feature.name)
                .font(.subheadline)
                .foregroundColor(isHighlighted ? .primary : .secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(isHighlighted ? Color(UIColor.secondarySystemBackground) : Color.clear)
        )
        .animation(.spring(), value: isHighlighted)
    }
}

struct PlanOptionView: View {
    let plan: InteractivePaywallView.SubscriptionPlan
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                // 计划标题
                Text(plan.rawValue)
                    .font(.headline)
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                // 计划价格
                Text(plan.price)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? plan.color : .primary)
                
                // 计划周期
                Text(plan.period)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // 节省信息
                if let savingsText = plan.savingsText {
                    Text(savingsText)
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(Color.green.opacity(0.1))
                        )
                } else {
                    Spacer()
                        .frame(height: 21)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? plan.color : Color.clear, lineWidth: 2)
                    )
            )
            .shadow(color: isSelected ? plan.color.opacity(0.2) : Color.clear, radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.03 : 1.0)
        .animation(.spring(), value: isSelected)
    }
}

// MARK: - 首选项Key
struct InteractiveScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - 预览
struct InteractivePaywallView_Previews: PreviewProvider {
    static var previews: some View {
        InteractivePaywallView()
            .previewDisplayName("动态交互型Paywall")
        
        InteractivePaywallView()
            .preferredColorScheme(.dark)
            .previewDisplayName("动态交互型Paywall (深色模式)")
    }
} 