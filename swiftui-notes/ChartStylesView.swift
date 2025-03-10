import SwiftUI
import Charts

struct StyleSalesData: Identifiable {
    let id = UUID()
    let month: String
    let sales: Double
    let category: String
}

struct ChartStylesView: View {
    // 示例数据
    let salesData: [StyleSalesData] = [
        StyleSalesData(month: "Jan", sales: 100, category: "Phone"),
        StyleSalesData(month: "Feb", sales: 130, category: "Phone"),
        StyleSalesData(month: "Mar", sales: 110, category: "Phone"),
        StyleSalesData(month: "Apr", sales: 150, category: "Phone"),
        
        StyleSalesData(month: "Jan", sales: 50, category: "Tablet"),
        StyleSalesData(month: "Feb", sales: 80, category: "Tablet"),
        StyleSalesData(month: "Mar", sales: 70, category: "Tablet"),
        StyleSalesData(month: "Apr", sales: 90, category: "Tablet")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                // 渐变色柱状图
                Section("Gradient Bar Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            BarMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .chartForegroundStyleScale([
                        "Phone": .linearGradient(colors: [.blue, .purple], startPoint: .bottom, endPoint: .top),
                        "Tablet": .linearGradient(colors: [.orange, .red], startPoint: .bottom, endPoint: .top)
                    ])
                    .frame(height: 200)
                }
                
                // 圆角柱状图
                Section("Rounded Bar Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            BarMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .cornerRadius(8)
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .frame(height: 200)
                }
                
                // 带标注的折线图
                Section("Annotated Line Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            LineMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                            .symbol(by: .value("Category", item.category))
                            .symbolSize(100)
                            
                            // 添加数值标注
                            PointMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .annotation(position: .top) {
                                Text("\(Int(item.sales))")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .frame(height: 200)
                }
                
                // 堆叠柱状图
                Section("Stacked Bar Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            BarMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .chartForegroundStyleScale([
                        "Phone": Color.blue.opacity(0.8),
                        "Tablet": Color.green.opacity(0.8)
                    ])
                    .frame(height: 200)
                }
                
                // 自定义样式折线图
                Section("Styled Line Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            LineMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                            .lineStyle(StrokeStyle(lineWidth: 3, dash: [5, 5]))
                            
                            PointMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .chartYScale(domain: 0...200)
                    .chartYAxis {
                        AxisMarks(position: .leading, values: .automatic(desiredCount: 5))
                    }
                    .frame(height: 200)
                }
                
                // 带背景的面积图
                Section("Area Chart with Background") {
                    Chart {
                        ForEach(salesData) { item in
                            AreaMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                            .opacity(0.3)
                            
                            LineMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .chartYScale(domain: 0...200)
                    .chartLegend(position: .bottom)
                    .frame(height: 200)
                }
            }
            .navigationTitle("Chart Styles")
        }
    }
}

#Preview {
    ChartStylesView()
} 