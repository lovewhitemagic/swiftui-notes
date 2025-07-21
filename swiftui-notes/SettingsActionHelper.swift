import SwiftUI
import StoreKit

// MARK: - 反馈功能
class SettingsActionHelper: ObservableObject {
    
    // MARK: - 反馈功能
    static func sendFeedback() {
        let email = "282979785@qq.com"
        let subject = String(localized: "日记App反馈")
        
        // 创建邮件URL
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let emailURL = URL(string: "mailto:\(email)?subject=\(encodedSubject)") {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL)
            } else {
                // 如果无法打开邮件应用，复制邮箱地址
                UIPasteboard.general.string = email
                print("邮箱地址已复制到剪贴板：\(email)")
            }
        }
    }
    
    // MARK: - 评价功能
    static func rateApp() {
        let appID = "6748575745"
        
        // 如果应用内评价不可用，跳转到App Store
        if let appStoreURL = URL(string: "https://apps.apple.com/app/id\(appID)?action=write-review") {
            if UIApplication.shared.canOpenURL(appStoreURL) {
                UIApplication.shared.open(appStoreURL)
            }
        }
    }
    
    // MARK: - 分享功能
    static func shareApp() -> [Any] {
        let appURL = URL(string: "https://apps.apple.com/app/id6748575745")!
        let shareText = "我在使用这款很棒的日记应用：日记，推荐给你！"
        
        return [shareText, appURL]
    }
}

// MARK: - SwiftUI 组件封装

struct AboutSection: View {
    @State private var showShareSheet = false
    
    var body: some View {
        SettingsSection {
            // 反馈
            Button(action: {
                SettingsActionHelper.sendFeedback()
            }) {
                SettingsItem(icon: "questionmark.bubble", title: "反馈", showExternalArrow: true)
            }
            .buttonStyle(PlainButtonStyle())
            
            // 评价
            Button(action: {
                SettingsActionHelper.rateApp()
            }) {
                SettingsItem(icon: "star", title: "评价", showExternalArrow: true)
            }
            .buttonStyle(PlainButtonStyle())
            
            // 分享
            Button(action: {
                showShareSheet = true
            }) {
                SettingsItem(icon: "info.circle", title: "分享", showExternalArrow: true, isLast: true)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(
                activityItems: SettingsActionHelper.shareApp(),
                isPresented: $showShareSheet
            )
        }
    }
}

// MARK: - ShareSheet 实现
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        
        // 排除一些不需要的分享选项
        activityViewController.excludedActivityTypes = [
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList
        ]
        
        // 设置完成回调
        activityViewController.completionWithItemsHandler = { _, _, _, _ in
            isPresented = false
        }
        
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // 为iPad设置popover
        if let popover = uiViewController.popoverPresentationController {
            popover.sourceView = context.coordinator.sourceView
            popover.sourceRect = CGRect(x: 0, y: 0, width: 1, height: 1)
            popover.permittedArrowDirections = .up
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        var sourceView: UIView?
        
        init() {
            // 获取当前窗口的根视图
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                sourceView = window.rootViewController?.view
            }
        }
    }
} 