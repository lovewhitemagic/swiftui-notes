import SwiftUI

struct ExpenseCategory {
    let name: String
    let amount: Double
}

struct ExpenseCategoryView: View {
    let categories: [ExpenseCategory] = [
        ExpenseCategory(name: "房租", amount: 400),
        ExpenseCategory(name: "红包", amount: 200),
        ExpenseCategory(name: "交通", amount: 100),
        ExpenseCategory(name: "购物", amount: 100),
        ExpenseCategory(name: "餐饮", amount: 100),
        ExpenseCategory(name: "娱乐", amount: 100),
        ExpenseCategory(name: "医疗", amount: 300),
        ExpenseCategory(name: "其他", amount: 200)
    ]
    
    private var totalAmount: Double {
        categories.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ForEach(0..<categories.count, id: \.self) { index in
                    let category = categories[index]
                    let ratio = category.amount / totalAmount
                    let height = geometry.size.height * ratio
                    
                    HStack {
                        Text("\(category.name): \(Int(category.amount))")
                            .foregroundStyle(.white)
                            .padding(.leading)
                            .padding(.top, index == 0 ? 80 : 0)
                            .frame(maxHeight: .infinity, alignment: .top)
                        Spacer()
                        if index == 0 {
                            Text("总支出: \(Int(totalAmount))")
                                .foregroundStyle(.white)
                                .padding(.trailing)
                                .padding(.top, 80)
                                .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                    .frame(height: height)
                    .background(Color(white: 0.8 - (Double(index) * 0.1)))
                }
            }
        }
        .ignoresSafeArea()
    } 
}

#Preview {
    ExpenseCategoryView()
} 