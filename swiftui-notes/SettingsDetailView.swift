import SwiftUI

struct SettingItem: Identifiable {
    let id = UUID()
    let icon: String      // SF Symbol 名称
    let title: String
    let subtitle: String?
    let type: SettingType
}

enum SettingType {
    case pro           // PRO版本
    case toggle        // 开关选项
    case navigation    // 导航到新页面
    case action        // 直接操作
}

struct SettingsDetailView: View {
    @State private var isDarkMode = false
    @State private var currency = "¥"
    
    let settings: [SettingItem] = [
        SettingItem(icon: "crown.fill", title: "升级 PRO", subtitle: "解锁全部高级功能", type: .pro),
        SettingItem(icon: "paintbrush.fill", title: "主题", subtitle: "深色", type: .toggle),
        SettingItem(icon: "yensign.circle", title: "货币单位", subtitle: "¥", type: .navigation),
        SettingItem(icon: "tag.fill", title: "标签管理", subtitle: "自定义支出分类", type: .navigation),
        SettingItem(icon: "square.and.arrow.down", title: "导入数据", subtitle: nil, type: .action),
        SettingItem(icon: "square.and.arrow.up", title: "导出数据", subtitle: nil, type: .action),
        SettingItem(icon: "book.fill", title: "使用教程", subtitle: nil, type: .navigation),
        SettingItem(icon: "envelope.fill", title: "反馈建议", subtitle: nil, type: .action),
        SettingItem(icon: "star.fill", title: "好评鼓励", subtitle: nil, type: .action),
        SettingItem(icon: "info.circle.fill", title: "关于", subtitle: "版本 1.0.0", type: .navigation)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(settings.enumerated()), id: \.element.id) { index, item in
                        HStack {
                            // 图标
                            Image(systemName: item.icon)
                                .foregroundStyle(item.type == .pro ? .yellow : .white)
                                .frame(width: 30)
                            
                            // 标题
                            Text(item.title)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            // 副标题或指示器
                            if let subtitle = item.subtitle {
                                Text(subtitle)
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 14))
                            }
                            
                            // 导航箭头
                            if item.type == .navigation {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 14))
                            }
                            
                            // PRO标识
                            if item.type == .pro {
                                Text("PRO")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(.black)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(.yellow)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                            }
                        }
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(
                            Color(white: 0.8 - (Double(index) * 0.05))
                        )
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SettingsDetailView()
} 