import SwiftUI

struct TransactionListView: View {
    @State private var selectedSegment = 0
    let segments = ["All", "Write-offs", "Deposits"]
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部卡片
            TopExpenseCard()
            
            // 分段控制器
            CustomSegmentedControl(
                selectedIndex: $selectedSegment,
                segments: segments
            )
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            // 交易列表
            TransactionsList()
        }
        .background(Color(uiColor: .systemGray6))
    }
}

// 顶部卡片
struct TopExpenseCard: View {
    var body: some View {
        VStack(spacing: 16) {
            // 金额和月份
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("$345")
                        .font(.system(size: 32, weight: .bold))
                    Text("Expenses for October")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "arrow.down.circle")
                    .font(.title2)
                    .foregroundStyle(.purple)
            }
            
            // 功能按钮组
            HStack(spacing: 20) {
                CategoryButton(
                    icon: "chart.pie.fill",
                    title: "Spending\ncategories"
                )
                
                CategoryButton(
                    icon: "calendar",
                    title: "Forecast\nof write-offs"
                )
                
                CategoryButton(
                    icon: "arrow.left.arrow.right",
                    title: "Traffic\nFlow"
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 5)
        )
        .padding()
    }
}

// 功能按钮
struct CategoryButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.purple)
            
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(uiColor: .systemGray6))
        )
    }
}

// 自定义分段控制器
struct CustomSegmentedControl: View {
    @Binding var selectedIndex: Int
    let segments: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments.indices, id: \.self) { index in
                Button {
                    withAnimation {
                        selectedIndex = index
                    }
                } label: {
                    Text(segments[index])
                        .font(.system(.body, weight: selectedIndex == index ? .semibold : .regular))
                        .foregroundStyle(selectedIndex == index ? .purple : .secondary)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

// 交易列表
struct TransactionsList: View {
    var body: some View {
        List {
            Section(header: Text("TODAY")) {
                TransactionRow(
                    icon: "phone.fill",
                    title: "+324 356-12-65",
                    subtitle: "Outgoing",
                    amount: "-$1.2",
                    time: "04:00 PM"
                )
                
                TransactionRow(
                    icon: "phone.fill",
                    title: "+324 123-45-65",
                    subtitle: "Outgoing",
                    amount: "-$2",
                    time: "02:00 PM"
                )
                
                TransactionRow(
                    icon: "globe",
                    title: "Turbo-button",
                    subtitle: "Internet",
                    amount: "-$0.2",
                    time: "03:00 PM"
                )
                
                TransactionRow(
                    icon: "creditcard.fill",
                    title: "Tariff «Number Four»",
                    subtitle: "Monthly fee",
                    amount: "-$20",
                    time: "00:00 PM"
                )
            }
            
            Section(header: Text("YESTERDAY")) {
                TransactionRow(
                    icon: "phone.fill",
                    title: "+324 356-12-65",
                    subtitle: "Outgoing",
                    amount: "-$0.1",
                    time: "11:30 AM"
                )
            }
        }
        .listStyle(.plain)
    }
}

// 交易行
struct TransactionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let amount: String
    let time: String
    
    var body: some View {
        HStack {
            // 图标
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.purple)
                .frame(width: 40, height: 40)
                .background(Color(uiColor: .systemGray6))
                .clipShape(Circle())
            
            // 标题和副标题
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(.body, weight: .medium))
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // 金额和时间
            VStack(alignment: .trailing, spacing: 4) {
                Text(amount)
                    .font(.system(.body, weight: .medium))
                Text(time)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TransactionListView()
} 