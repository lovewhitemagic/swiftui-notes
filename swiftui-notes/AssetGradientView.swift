import SwiftUI

struct AssetGradientView: View {
    // 金额数据
    let monthlyIncome = 4000  // 总高度基准
    let totalAssets = 16000
    let budget = 2200
    let spent = 800    // 花费金额
    
    // 计算金额
    private var remaining: Int { budget - spent }
    private var netIncome: Int { monthlyIncome - spent }
    
    // 计算高度比例
    private var budgetRatio: CGFloat { CGFloat(budget) / CGFloat(monthlyIncome) }
    // 花费占预算的比例
    private var spentRatio: CGFloat { CGFloat(spent) / CGFloat(budget) }
    // 剩余占预算的比例
    private var remainingRatio: CGFloat { CGFloat(remaining) / CGFloat(budget) }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // 背景色
                Color.gray.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // 总资产和月收入
                    HStack {
                        VStack(alignment: .leading) {
                            Text("总资产还剩")
                                .foregroundStyle(.black)
                            Text("\(totalAssets)")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.black)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("3月份收入")
                                .foregroundStyle(.black)
                            Text("\(monthlyIncome)")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.black)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top,100)
                    
                    // 净收入单独一行
                    HStack {
                        Spacer()
                        Text("净收入：\(netIncome)")
                            .foregroundStyle(.black)
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    
                    Spacer()
                }
                
                // 预算区域 - 固定在底部
                VStack(spacing: 0) {
                    Spacer()
                    
                    // 还剩
                    HStack() {
                        Text("还剩：\(remaining)")
                            .foregroundStyle(.black)
                            .padding()
                            .frame(maxHeight: .infinity, alignment: .top)
                        Spacer()
                        Text("预算：\(budget)")
                            .foregroundStyle(.black)
                            .padding()
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .frame(height: geometry.size.height * budgetRatio * remainingRatio)
                    .background(Color(.systemGray4))
                    
                    // 花了
                    HStack() {
                        Text("花了：\(spent)")
                            .foregroundStyle(.black)
                            .padding()
                            .frame(maxHeight: .infinity, alignment: .top)
                        Spacer()
                    }
                    .frame(height: geometry.size.height * budgetRatio * spentRatio)
                    .background(Color(.systemGray5))
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AssetGradientView()
} 