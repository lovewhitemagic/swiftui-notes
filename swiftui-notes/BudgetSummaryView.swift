import SwiftUI
//单月统计
struct BudgetSummaryView: View {
    struct SummaryItem: Identifiable {
        let id = UUID()
        let amount: String
        let title: String
    }
    
    let items: [SummaryItem] = [
        SummaryItem(amount: "-1267", title: "花了"),
        SummaryItem(amount: "4850", title: "赚了"),
        SummaryItem(amount: "3583", title: "还剩"),
        SummaryItem(amount: "1500", title: "预算"),
        SummaryItem(amount: "233", title: "结余")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(items) { item in
                        VStack {
                            Spacer()
                            
                            Text(item.amount)
                                .font(.system(size: 20, weight: .medium))
                            
                            Spacer()
                            
                            Text(item.title)
                                .font(.system(size: 12))
                                .foregroundStyle(.gray)
                                .padding(.bottom, 16)
                        }
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemGray6))
                        )
                    }
                }
                .padding(24)
                
                Spacer()
            }
            .navigationTitle("单月统计")
        }
    }
}

#Preview {
    BudgetSummaryView()
} 
