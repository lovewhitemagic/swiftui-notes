import SwiftUI

struct DailyExpense: Identifiable {
    let id = UUID()
    let date: Int // 日期
    let expense: Double // 支出
    let income: Double? // 收入（可选）
    
    var dayString: String {
        return "\(date)日"
    }
}

struct DailyExpenseView: View {
    // 示例数据：3月份31天
    let dailyExpenses: [DailyExpense] = [
        DailyExpense(date: 1, expense: 100, income: 4000),
        DailyExpense(date: 2, expense: 250, income: nil),
        DailyExpense(date: 3, expense: 80, income: nil),
        DailyExpense(date: 4, expense: 150, income: nil),
        DailyExpense(date: 5, expense: 200, income: nil),
        DailyExpense(date: 6, expense: 90, income: nil),
        DailyExpense(date: 7, expense: 120, income: nil),
        DailyExpense(date: 8, expense: 300, income: nil),
        DailyExpense(date: 9, expense: 180, income: nil),
        DailyExpense(date: 10, expense: 160, income: 1000),
        DailyExpense(date: 11, expense: 140, income: nil),
        DailyExpense(date: 12, expense: 220, income: nil),
        DailyExpense(date: 13, expense: 170, income: nil),
        DailyExpense(date: 14, expense: 130, income: nil),
        DailyExpense(date: 15, expense: 400, income: 2000),
        DailyExpense(date: 16, expense: 110, income: nil),
        DailyExpense(date: 17, expense: 190, income: nil),
        DailyExpense(date: 18, expense: 240, income: nil),
        DailyExpense(date: 19, expense: 280, income: nil),
        DailyExpense(date: 20, expense: 150, income: 800),
        DailyExpense(date: 21, expense: 200, income: nil),
        DailyExpense(date: 22, expense: 170, income: nil),
        DailyExpense(date: 23, expense: 140, income: nil),
        DailyExpense(date: 24, expense: 260, income: nil),
        DailyExpense(date: 25, expense: 190, income: 1500),
        DailyExpense(date: 26, expense: 230, income: nil),
        DailyExpense(date: 27, expense: 180, income: nil),
        DailyExpense(date: 28, expense: 210, income: nil),
        DailyExpense(date: 29, expense: 160, income: nil),
        DailyExpense(date: 30, expense: 290, income: nil),
        DailyExpense(date: 31, expense: 320, income: 500)
    ]
    
    // 计算总支出
    private var totalExpense: Double {
        dailyExpenses.reduce(0) { $0 + $1.expense }
    }
    
    // 计算总收入
    private var totalIncome: Double {
        dailyExpenses.reduce(0) { $0 + ($1.income ?? 0) }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    // 月度总计
                    HStack {
                        Text("3月支出总计")
                            .foregroundStyle(.white)
                        Spacer()
                        Text("¥\(Int(totalExpense))")
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    .frame(height: 40)
                    .background(Color(white: 0.3))
                    
                    // 每日支出列表
                    ForEach(Array(dailyExpenses.enumerated()), id: \.element.id) { index, daily in
                        let ratio = daily.expense / totalExpense
                        let height = max(geometry.size.height * ratio * 0.8, 50) // 最小高度50
                        
                        HStack {
                            // 日期
                            Text(daily.dayString)
                                .foregroundStyle(.white)
                                .frame(width: 50, alignment: .leading)
                            
                            // 支出金额
                            Text("💸 \(Int(daily.expense))")
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            // 收入金额（如果有）
                            if let income = daily.income {
                                Text("💰 \(Int(income))")
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal)
                        .frame(height: height)
                        .background(
                            Color(white: 0.8 - (Double(index) * 0.02))
                        )
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DailyExpenseView()
} 