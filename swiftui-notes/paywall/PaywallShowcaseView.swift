/*
 * 设计名称: PaywallShowcaseView (付费墙展示视图)
 * 设计特点:
 * - 集成展示所有付费墙设计
 * - 包含各种设计风格的导航入口
 * - 提供每种设计的简要描述
 * - 支持深色和浅色模式
 * - 可以方便地预览和比较不同风格
 */

import SwiftUI

struct PaywallShowcaseView: View {
    // MARK: - 状态属性
    @State private var selectedPaywall: PaywallType?
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Paywall类型
    enum PaywallType: String, CaseIterable, Identifiable {
        case minimalist = "简约优雅型"
        case featureComparison = "特性对比型"
        case gradient = "渐变背景型"
        case cardStyle = "卡片式布局"
        case imageRich = "图像丰富型"
        case interactive = "动态交互型"
        
        var id: String { self.rawValue }
        
        var description: String {
            switch self {
            case .minimalist:
                return "干净的界面设计，强调价值主张，使用有限的色彩选择"
            case .featureComparison:
                return "清晰展示不同订阅级别的特性对比，帮助用户做出选择"
            case .gradient:
                return "使用现代渐变色彩，提供视觉冲击力和吸引眼球效果"
            case .cardStyle:
                return "使用卡片组件展示不同的订阅选项，增强视觉层次感"
            case .imageRich:
                return "使用高质量图像作为背景或点缀，提供沉浸式用户体验"
            case .interactive:
                return "包含动画和交互元素增强用户体验，视差效果增强沉浸感"
            }
        }
        
        var iconName: String {
            switch self {
            case .minimalist: return "star.circle"
            case .featureComparison: return "list.bullet.rectangle"
            case .gradient: return "paintpalette"
            case .cardStyle: return "rectangle.grid.2x2"
            case .imageRich: return "photo"
            case .interactive: return "hand.tap"
            }
        }
        
        var color: Color {
            switch self {
            case .minimalist: return .blue
            case .featureComparison: return .indigo
            case .gradient: return .purple
            case .cardStyle: return .orange
            case .imageRich: return .pink
            case .interactive: return .teal
            }
        }
        
        @ViewBuilder
        func view() -> some View {
            switch self {
            case .minimalist:
                MinimalistPaywallView()
            case .featureComparison:
                FeatureComparisonPaywallView()
            case .gradient:
                GradientPaywallView()
            case .cardStyle:
                CardStylePaywallView()
            case .imageRich:
                ImageRichPaywallView()
            case .interactive:
                InteractivePaywallView()
            }
        }
    }
    
    // MARK: - 主视图
    var body: some View {
        NavigationView {
            List {
                // 标题部分
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("iOS Paywall设计集")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top, 10)
                        
                        Text("选择下方任意设计风格查看详细实现")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                }
                
                // Paywall类型列表
                Section(header: Text("可用设计风格").font(.headline)) {
                    ForEach(PaywallType.allCases) { paywallType in
                        PaywallItemRow(type: paywallType)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedPaywall = paywallType
                            }
                    }
                }
                
                // 使用说明
                Section(header: Text("使用说明").font(.headline)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• 点击任意设计样式查看完整实现")
                            .font(.subheadline)
                        
                        Text("• 每个设计都可以根据实际需求自由定制")
                            .font(.subheadline)
                        
                        Text("• 所有设计都支持深色模式和浅色模式")
                            .font(.subheadline)
                        
                        Text("• 代码结构清晰，易于维护和扩展")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Paywall设计", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(PaywallType.allCases) { type in
                            Button(action: {
                                selectedPaywall = type
                            }) {
                                Label(type.rawValue, systemImage: type.iconName)
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(item: $selectedPaywall) { paywallType in
                NavigationView {
                    paywallType.view()
                        .navigationBarTitle(paywallType.rawValue, displayMode: .inline)
                        .navigationBarItems(trailing: Button("关闭") {
                            selectedPaywall = nil
                        })
                        .ignoresSafeArea(.all, edges: .bottom)
                }
            }
        }
    }
}

// MARK: - 辅助视图
struct PaywallItemRow: View {
    let type: PaywallShowcaseView.PaywallType
    
    var body: some View {
        HStack(spacing: 16) {
            // 图标
            Image(systemName: type.iconName)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(type.color)
                )
            
            // 内容
            VStack(alignment: .leading, spacing: 4) {
                Text(type.rawValue)
                    .font(.headline)
                
                Text(type.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            // 箭头
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - 预览
struct PaywallShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        PaywallShowcaseView()
            .previewDisplayName("付费墙展示 (浅色模式)")
        
        PaywallShowcaseView()
            .preferredColorScheme(.dark)
            .previewDisplayName("付费墙展示 (深色模式)")
    }
} 