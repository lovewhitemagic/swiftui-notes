import SwiftUI

// 自定义分享项目模型
struct ShareItem: Transferable {
    let title: String
    let description: String
    let url: URL
    let image: Image
    
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.description)
    }
}

struct ShareLinkExampleView: View {
    let text = "这是一段要分享的文本"
    let url = URL(string: "https://www.apple.com")!
    
    var body: some View {
        NavigationStack {
            List {
                // 基础文本分享
                Section("分享文本") {
                    ShareLink(
                        "分享这段文本",
                        item: text
                    )
                    
                    ShareLink(item: text) {
                        Label("自定义分享按钮", systemImage: "square.and.arrow.up")
                    }
                }
                
                // URL分享
                Section("分享链接") {
                    ShareLink(
                        "分享苹果官网",
                        item: url
                    )
                    
                    ShareLink(
                        "带预览的链接分享",
                        item: url,
                        preview: SharePreview(
                            "Apple官网",
                            image: Image(systemName: "apple.logo")
                        )
                    )
                }
                
                // 带主题和消息的分享
                Section("带主题的分享") {
                    ShareLink(
                        "分享链接",
                        item: url,
                        subject: Text("看看这个！"),
                        message: Text("我发现了一个很棒的网站")
                    )
                }
                
                // 自定义样式
                Section("自定义样式") {
                    ShareLink(item: text) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("点击分享")
                        }
                        .padding()
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .navigationTitle("ShareLink 示例")
        }
    }
}

#Preview {
    ShareLinkExampleView()
} 