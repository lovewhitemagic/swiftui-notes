import SwiftUI

struct MonthlyFinance: Identifiable {
    let id = UUID()
    let month: String
    let income: Double
    let expense: Double
    
    var netIncome: Double {
        income - expense
    }
}

struct MonthlyFinanceView: View {
    let monthlyData: [MonthlyFinance] = [
        MonthlyFinance(month: "1月", income: 4000, expense: 3500),
        MonthlyFinance(month: "2月", income: 4200, expense: 3800),
        MonthlyFinance(month: "3月", income: 4000, expense: 3200),
        MonthlyFinance(month: "4月", income: 4500, expense: 3900),
        MonthlyFinance(month: "5月", income: 4300, expense: 3600),
        MonthlyFinance(month: "6月", income: 4800, expense: 4200),
        MonthlyFinance(month: "7月", income: 5000, expense: 4500),
        MonthlyFinance(month: "8月", income: 4600, expense: 4100),
        MonthlyFinance(month: "9月", income: 4400, expense: 3800),
        MonthlyFinance(month: "10月", income: 4700, expense: 4000),
        MonthlyFinance(month: "11月", income: 4900, expense: 4300),
        MonthlyFinance(month: "12月", income: 5200, expense: 4600)
    ]
    
    // 计算年度总和
    private var yearlyTotals: (income: Double, expense: Double, net: Double) {
        let income = monthlyData.reduce(0) { $0 + $1.income }
        let expense = monthlyData.reduce(0) { $0 + $1.expense }
        return (income, expense, income - expense)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(monthlyData.enumerated()), id: \.element.id) { index, data in
                        let height = geometry.size.height * 0.09
                        
                        HStack {
                            // 月份
                            Text(data.month)
                                .foregroundStyle(.white)
                                .frame(width: 50, alignment: .leading)
                            
                            // 收入支出（使用emoji）
                            HStack(spacing: 12) {
                                Text("💰 \(Int(data.income))")
                                Text("💸 \(Int(data.expense))")
                            }
                            .font(.system(size: 14))
                            .foregroundStyle(.white)
                            
                            Spacer()
                            
                            // 右侧显示
                            if index == 0 {
                                // 第一行显示年度净收入
                                Text("年度净收入: ¥\(Int(yearlyTotals.net))")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.white)
                            } else {
                                // 其他行显示月度净收入
                                Text("¥\(Int(data.netIncome))")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.horizontal)
                        .frame(height: height)
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
    MonthlyFinanceView()
} 