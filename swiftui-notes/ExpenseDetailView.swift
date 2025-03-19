import SwiftUI

struct ExpenseDetail: Identifiable {
    let id = UUID()
    let category: String
    let emoji: String
    let description: String
    let date: Date
    let amount: Double
}

struct ExpenseDetailView: View {
    let expenses: [ExpenseDetail] = [
        // 3月15日
        ExpenseDetail(category: "房租", emoji: "🏠", description: "3月房租", date: Date().addingTimeInterval(-0), amount: 400),
        ExpenseDetail(category: "红包", emoji: "🧧", description: "同事结婚", date: Date().addingTimeInterval(-3600), amount: 200),
        ExpenseDetail(category: "交通", emoji: "🚇", description: "地铁上下班", date: Date().addingTimeInterval(-7200), amount: 100),
        // 3月14日
        ExpenseDetail(category: "购物", emoji: "🛒", description: "超市日用品", date: Date().addingTimeInterval(-86400), amount: 100),
        ExpenseDetail(category: "餐饮", emoji: "🍱", description: "午餐", date: Date().addingTimeInterval(-90000), amount: 100),
        ExpenseDetail(category: "娱乐", emoji: "🎬", description: "电影票", date: Date().addingTimeInterval(-93600), amount: 100),
 
        // 3月12日
        ExpenseDetail(category: "购物", emoji: "👕", description: "衣服", date: Date().addingTimeInterval(-259200), amount: 300),
        ExpenseDetail(category: "餐饮", emoji: "☕️", description: "下午茶", date: Date().addingTimeInterval(-262800), amount: 80),
        ExpenseDetail(category: "娱乐", emoji: "🎮", description: "游戏充值", date: Date().addingTimeInterval(-266400), amount: 100)
    ]
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日"
        return formatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // 按日期分组
    private var groupedExpenses: [(String, [ExpenseDetail], Double)] {
        let grouped = Dictionary(grouping: expenses) { expense in
            dateFormatter.string(from: expense.date)
        }
        return grouped.map { date, expenses in
            let dailyTotal = expenses.reduce(0) { $0 + $1.amount }
            return (date, expenses, dailyTotal)
        }.sorted { $0.0 > $1.0 }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(Array(groupedExpenses.enumerated()), id: \.1.0) { groupIndex, group in
                    let (date, expenses, dailyTotal) = group
                    // 日期标题
                    HStack {
                        Text(date)
                            .foregroundStyle(.black)
                            .padding(.leading)
                        Spacer()
                        Text("¥\(Int(dailyTotal))")
                            .foregroundStyle(.black)
                            .padding(.trailing)
                    }
                    .frame(height: 40)
                    .background(Color(white: 0.8 - (Double(groupIndex) * 0.1)))
                    
                    // 当日支出列表
                    ForEach(expenses) { expense in
                        HStack {
                            // 左侧emoji和分类
                            HStack(spacing: 4) {
                                Text(expense.emoji)
                                Text(expense.category)
                            }
                            .foregroundStyle(.white)
                            .frame(width: 80, alignment: .leading)
                            
                            // 中间描述和时间
                            VStack(alignment: .leading, spacing: 4) {
                                Text(expense.description)
                                    .foregroundStyle(.white)
                                Text(timeFormatter.string(from: expense.date))
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            
                            Spacer()
                            
                            // 右侧金额
                            Text("¥\(Int(expense.amount))")
                                .foregroundStyle(.white)
                                .frame(width: 80, alignment: .trailing)
                        }
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(Color(white: 0.8 - (Double(groupIndex) * 0.1)))
                    }
                }
            }
        }
        .background(Color(white: 0.8 - (Double(groupedExpenses.count - 1) * 0.1)))
        .ignoresSafeArea()
    }
}

#Preview {
    ExpenseDetailView()
} 