import SwiftUI

struct BudgetGradientView: View {
    struct BudgetItem: Identifiable {
        let id = UUID()
        let title: String
        let amount: Double
        let color: Color
        
        // 添加一个计算属性来获取显示金额
        var displayAmount: Int {
            return Int(abs(amount))
        }
    }
    
    // 按照图片顺序重新排列数据
    let items: [BudgetItem] = [
        BudgetItem(title: "花了", amount: -500, color: Color(.systemGray)),
        BudgetItem(title: "赚了", amount: 3000, color: Color(.systemGray2)),
        BudgetItem(title: "还剩", amount: 2500, color: Color(.systemGray3)),
        BudgetItem(title: "预算", amount: 1000, color: Color(.systemGray4)),
        BudgetItem(title: "结余", amount: 500, color: Color(.systemGray5))
    ]
    
    // 计算总金额
    private var totalAmount: Double {
        items.reduce(0) { $0 + abs($1.amount) }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(items) { item in
                    // 计算每个项目的高度比例
                    let heightRatio = abs(item.amount) / totalAmount
                    
                    HStack {
                        Text("\(item.title): \(item.displayAmount)")
                            .foregroundStyle(.black)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.leading, 16)
                        Spacer()
                    }
                    .frame(height: geometry.size.height * heightRatio)
                    .frame(maxWidth: .infinity)
                    .background(item.color)
                }
            }
        }
    }
}

#Preview {
    BudgetGradientView()
} 