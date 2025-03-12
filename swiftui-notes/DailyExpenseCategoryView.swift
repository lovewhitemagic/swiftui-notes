import SwiftUI

struct DailyCategory: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let amount: Double
}

struct DailyExpenseCategoryView: View {
    let categories: [DailyCategory] = [
        DailyCategory(name: "房租", emoji: "🏠", amount: 400),
        DailyCategory(name: "红包", emoji: "🧧", amount: 200),
        DailyCategory(name: "交通", emoji: "🚇", amount: 100),
        DailyCategory(name: "购物", emoji: "🛒", amount: 100),
        DailyCategory(name: "餐饮", emoji: "🍱", amount: 100),
        DailyCategory(name: "娱乐", emoji: "🎮", amount: 100),
        DailyCategory(name: "医疗", emoji: "💊", amount: 300),
        DailyCategory(name: "其他", emoji: "📝", amount: 200)
    ]
    
    private var totalAmount: Double {
        categories.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        GeometryReader { geometry in
          
                VStack(spacing: 0) {
                    // 顶部总计
                    HStack {
                        Text("今日支出")
                            .foregroundStyle(.white)
                            .padding(.leading)
                        Spacer()
                        Text("¥\(Int(totalAmount))")
                            .foregroundStyle(.white)
                            .padding(.trailing)
                    }
                    .frame(height: 40)
                    .background(Color(white: 0.3))
                    
                    // 类别列表
                    ForEach(categories) { category in
                        let ratio = category.amount / totalAmount
                        let height = max(geometry.size.height * ratio * 1, 40) // 最小高度40
                        
                        HStack {
                            // 类别名称和emoji
                            HStack(spacing: 8) {
                                Text(category.emoji)
                                Text(category.name)
                            }
                            .foregroundStyle(.white)
                            .frame(width: 100, alignment: .leading)
                            
                            Spacer()
                            
                            // 金额
                            Text("¥\(Int(category.amount))")
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                        .frame(height: height)
                        .background(
                            Color(white: 0.8 - (Double(categories.firstIndex(where: { $0.id == category.id }) ?? 0) * 0.1))
                        )
                    }
                }
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DailyExpenseCategoryView()
} 