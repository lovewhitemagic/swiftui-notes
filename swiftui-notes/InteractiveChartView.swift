import SwiftUI
import Charts

struct SalesDataPoint: Identifiable {
    let id = UUID()
    let month: String
    let sales: Double
    let category: String
}

struct InteractiveChartView: View {
    // 示例数据
    let salesData: [SalesDataPoint] = [
        SalesDataPoint(month: "Jan", sales: 100, category: "Phone"),
        SalesDataPoint(month: "Feb", sales: 130, category: "Phone"),
        SalesDataPoint(month: "Mar", sales: 110, category: "Phone"),
        SalesDataPoint(month: "Apr", sales: 150, category: "Phone"),
        
        SalesDataPoint(month: "Jan", sales: 50, category: "Tablet"),
        SalesDataPoint(month: "Feb", sales: 80, category: "Tablet"),
        SalesDataPoint(month: "Mar", sales: 70, category: "Tablet"),
        SalesDataPoint(month: "Apr", sales: 90, category: "Tablet")
    ]
    
    @State private var selectedMonth: String? = nil
    @State private var plotWidth: CGFloat = 0
    @State private var selectedX: CGFloat? = nil
    
    var body: some View {
        NavigationStack {
            List {
                // 交互式折线图
                Section("Interactive Line Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            LineMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                            .symbol(by: .value("Category", item.category))
                            .symbolSize(selectedMonth == item.month ? 100 : 50)
                            .lineStyle(StrokeStyle(lineWidth: 2))
                            
                            if selectedMonth == item.month {
                                PointMark(
                                    x: .value("Month", item.month),
                                    y: .value("Sales", item.sales)
                                )
                                .foregroundStyle(by: .value("Category", item.category))
                                .annotation(position: .top) {
                                    Text("\(Int(item.sales))")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .chartXSelection(value: $selectedMonth)
                    .frame(height: 200)
                }
                
                // 交互式柱状图
                Section("Interactive Bar Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            BarMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                            .opacity(selectedMonth == nil || selectedMonth == item.month ? 1 : 0.3)
                        }
                        
                        if let selectedMonth {
                            RuleMark(
                                x: .value("Month", selectedMonth)
                            )
                            .foregroundStyle(.gray.opacity(0.3))
                            .lineStyle(StrokeStyle(lineWidth: 1))
                            .annotation(position: .top) {
                                let total = salesData
                                    .filter { $0.month == selectedMonth }
                                    .reduce(0) { $0 + $1.sales }
                                
                                VStack {
                                    Text("Total")
                                        .font(.caption2)
                                    Text("\(Int(total))")
                                        .font(.caption)
                                        .bold()
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(.white.opacity(0.9))
                                .cornerRadius(8)
                            }
                        }
                    }
                    .chartXSelection(value: $selectedMonth)
                    .frame(height: 200)
                }
                
                // 显示选中的数据
                if let selectedMonth {
                    Section("Selected Data") {
                        let selectedData = salesData.filter { $0.month == selectedMonth }
                        ForEach(selectedData) { item in
                            HStack {
                                Text(item.category)
                                Spacer()
                                Text("\(Int(item.sales))")
                                    .bold()
                            }
                        }
                        
                        let total = selectedData.reduce(0) { $0 + $1.sales }
                        HStack {
                            Text("Total")
                                .bold()
                            Spacer()
                            Text("\(Int(total))")
                                .bold()
                        }
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Interactive Charts")
        }
    }
}

#Preview {
    InteractiveChartView()
} 