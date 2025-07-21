import SwiftUI

struct AppSettingsView: View {
    @State private var isDailyReminderEnabled = false
    @State private var isDarkModeEnabled = false
    @State private var showDottedBackground = true
    @State private var diaryDisplayStyle = "timeline"
    @State private var diaryTextColor = Color.blue
    private let isProUser = false
    private let dailyReminderTime = "09:00"
    
    var body: some View {
            ScrollView {
                VStack(spacing: 24) {
                    // 标题
                    Text("设置")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    // Pro 卡片
                    ProStatusCard(isPro: isProUser)
                    
                    // 设置组
                    preferencesGroup
                    customizationGroup
                    dataManagementGroup
                    AboutSection()
                    
                    // 版本信息
                    VersionInfoView()
                }
            }
    }
    

    
    private var preferencesGroup: some View {
        SettingsSection {
            SettingsItem(icon: "lightbulb", title: "引导句设置")
            SettingsItem(icon: "moon.fill", title: "深色模式") {
                Toggle("", isOn: $isDarkModeEnabled)
            }
            SettingsItem(
                icon: "bell", 
                title: "每日提醒",
                subtitle: isDailyReminderEnabled ? dailyReminderTime : nil,
                isLast: true
            ) {
                Toggle("", isOn: $isDailyReminderEnabled)
                    .disabled(!isProUser)
            }
        }
    }
    
    private var customizationGroup: some View {
        SettingsSection {
            SettingsItem(icon: "rectangle.3.group", title: "显示风格") {
                Image(systemName: displayStyleIcon)
                    .font(.title3)
                    .foregroundColor(.primary)
            }
            SettingsItem(icon: "textformat", title: "文字颜色") {
                Circle()
                    .fill(diaryTextColor)
                    .frame(width: 30, height: 30)
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            }
            SettingsItem(icon: "circle.dotted", title: "圆点背景", isLast: true) {
                Toggle("", isOn: $showDottedBackground)
            }
        }
    }
    
    private var dataManagementGroup: some View {
        SettingsSection {
            SettingsItem(icon: "icloud.and.arrow.up", title: "CloudKit同步")
            SettingsItem(icon: "square.and.arrow.up", title: "分享整月")
            SettingsItem(icon: "trash.fill", title: "清除所有日记", isLast: true)
        }
    }
    

    

    
    private var displayStyleIcon: String {
        switch diaryDisplayStyle {
        case "timeline": return "list.bullet"
        case "card": return "rectangle.portrait"
        case "gallery": return "square.grid.3x3"
        default: return "photo.stack"
        }
    }
}

// MARK: - 辅助组件

struct SettingsSection<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .background(Color(.systemGray6))
        .cornerRadius(25)
        .padding(.horizontal, 20)
    }
}

struct SettingsItem<TrailingContent: View>: View {
    let icon: String
    let title: String
    var subtitle: String? = nil
    var showExternalArrow: Bool = false
    var isLast: Bool = false
    let trailing: () -> TrailingContent
    
    init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        showExternalArrow: Bool = false,
        isLast: Bool = false,
        @ViewBuilder trailing: @escaping () -> TrailingContent = { EmptyView() }
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.showExternalArrow = showExternalArrow
        self.isLast = isLast
        self.trailing = trailing
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                // 图标
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.gray)
                    .frame(width: 30, height: 30)
                
                // 标题和副标题
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                // 自定义尾部内容或默认箭头
                if TrailingContent.self == EmptyView.self {
                    Image(systemName: showExternalArrow ? "arrow.up.forward" : "chevron.right")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.secondary)
                } else {
                    trailing()
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            
            // 只有不是最后一个项目才显示分割线
            if !isLast {
                    Divider()
                    .padding(.leading, 62)
            }
        }
    }
}

// 便利构造器
extension SettingsItem where TrailingContent == EmptyView {
    init(icon: String, title: String, showExternalArrow: Bool = false, isLast: Bool = false) {
        self.init(icon: icon, title: title, showExternalArrow: showExternalArrow, isLast: isLast) {
            EmptyView()
        }
    }
}


#Preview {
    AppSettingsView()
} 