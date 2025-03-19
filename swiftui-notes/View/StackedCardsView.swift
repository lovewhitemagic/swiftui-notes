import SwiftUI

struct CardData: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
    let offset: CGFloat
    let scale: CGFloat
}

struct StackedCardsView: View {
    @State private var isExpanded = false
    @State private var selectedCard: UUID?
    
    let cards: [CardData] = [
        CardData(title: "本月支出", amount: 3500, offset: 0, scale: 1.0),
        CardData(title: "上月支出", amount: 4200, offset: 20, scale: 0.95),
        CardData(title: "去年同期", amount: 3800, offset: 40, scale: 0.9)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 从后往前堆叠卡片
                ForEach(cards.reversed()) { card in
                    StackedCardView(data: card)
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(
                            Color(white: 0.8 - (Double(cards.firstIndex(where: { $0.id == card.id }) ?? 0) * 0.2))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .offset(y: calculateOffset(for: card))
                        .scaleEffect(calculateScale(for: card))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                if selectedCard == card.id {
                                    // 如果点击已展开的卡片，则折叠
                                    selectedCard = nil
                                    isExpanded = false
                                } else if card.id == cards.first?.id {
                                    // 只有点击最上面的卡片才展开
                                    selectedCard = card.id
                                    isExpanded = true
                                }
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal)
        }
        .ignoresSafeArea()
    }
    
    private func calculateOffset(for card: CardData) -> CGFloat {
        if !isExpanded {
            return card.offset // 折叠状态保持原始偏移
        }
        
        let index = cards.firstIndex(where: { $0.id == card.id }) ?? 0
        let cardHeight: CGFloat = 120 // 与卡片高度相同
        
        if card.id == selectedCard {
            return 0 // 选中的卡片在顶部
        } else {
            // 直接使用卡片高度作为间距
            return cardHeight * CGFloat(index)
        }
    }
    
    private func calculateScale(for card: CardData) -> CGFloat {
        if !isExpanded {
            return card.scale // 折叠时使用原始缩放
        }
        return 1.0 // 展开时所有卡片大小相同
    }
}

struct StackedCardView: View {
    let data: CardData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // 标题
            Text(data.title)
                .font(.headline)
                .foregroundStyle(.white)
            
            // 金额
            Text("¥\(Int(data.amount))")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
            
            Spacer()
            
            // 底部信息
            HStack {
                Text("查看详情")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
        .padding()
    }
}

#Preview {
    StackedCardsView()
} 