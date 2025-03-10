import SwiftUI

struct SegmentButtonsView: View {
    @State private var selectedIndex = 0
    
    // 按钮数据模型
    struct ButtonItem: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
    }
    
    // 按钮数据
    let buttons: [ButtonItem] = [
        ButtonItem(icon: "person.fill", title: "Primary"),
        ButtonItem(icon: "cart", title: "购物"),
        ButtonItem(icon: "message", title: "消息"),
        ButtonItem(icon: "megaphone", title: "通知")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    let totalWidth = geometry.size.width - 32  // 减去整体的水平内边距
                    let unitWidth = totalWidth / 5  // 将宽度分成5份
                    let buttonSpacing: CGFloat = 8  // 定义固定的按钮间距
                    
                    HStack(spacing: buttonSpacing) {
                        ForEach(Array(buttons.enumerated()), id: \.element.id) { index, button in
                            ButtonView(
                                icon: button.icon,
                                title: button.title,
                                isSelected: selectedIndex == index
                            )
                            .frame(width: selectedIndex == index ? 
                                   unitWidth * 2 : // 选中时的宽度
                                   unitWidth)     // 未选中时的宽度
                            .onTapGesture {
                                withAnimation(.spring(duration: 0.3)) {
                                    selectedIndex = index
                                }
                            }
                        }
                    }
                    .padding(.horizontal, buttonSpacing)
                }
                
                Spacer()
                Text("模仿邮件APP-动态标签")
            }
            .padding(.horizontal, 16)
            .navigationTitle("邮件")
        }
    }
}

// 单个按钮视图
struct ButtonView: View {
    let icon: String
    let title: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
                .font(.system(size: 16))
            
            if isSelected {
                Text(title)
                    .font(.system(size: 14))
                    .transition(.opacity.combined(with: .move(edge: .leading)))
            }
        }
        .foregroundStyle(isSelected ? .white : .gray)
        .frame(height: 50)  // 固定高度
        .frame(maxWidth: .infinity)  // 填充分配的宽度
        .background(
            Capsule()
                .fill(isSelected ? .blue : Color(.systemGray6))
        )
    }
}

#Preview {
    SegmentButtonsView()
} 