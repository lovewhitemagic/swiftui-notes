import SwiftUI
import Charts

struct SalesData: Identifiable {
    let id = UUID()
    let month: String
    let sales: Double
    let category: String
}

struct ChartExampleView: View {
    // 示例数据
    let salesData: [SalesData] = [
        // 手机销量
        SalesData(month: "Jan", sales: 100, category: "Phone"),
        SalesData(month: "Feb", sales: 130, category: "Phone"),
        SalesData(month: "Mar", sales: 110, category: "Phone"),
        SalesData(month: "Apr", sales: 150, category: "Phone"),
        
        // 平板销量
        SalesData(month: "Jan", sales: 50, category: "Tablet"),
        SalesData(month: "Feb", sales: 80, category: "Tablet"),
        SalesData(month: "Mar", sales: 70, category: "Tablet"),
        SalesData(month: "Apr", sales: 90, category: "Tablet"),
        
        // 笔记本销量
        SalesData(month: "Jan", sales: 70, category: "Laptop"),
        SalesData(month: "Feb", sales: 90, category: "Laptop"),
        SalesData(month: "Mar", sales: 85, category: "Laptop"),
        SalesData(month: "Apr", sales: 100, category: "Laptop")
    ]
    
    var body: some View {
        NavigationStack {
            List {
                // 折线图
                Section("Line Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            LineMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .frame(height: 200)
                }
                
                // 柱状图
                Section("Bar Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            BarMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .frame(height: 200)
                }
                
                // 面积图
                Section("Area Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            AreaMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .frame(height: 200)
                }
                
                // 点图
                Section("Point Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            PointMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .frame(height: 200)
                }
                
                // 混合图表
                Section("Mixed Chart") {
                    Chart {
                        ForEach(salesData) { item in
                            LineMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                            
                            PointMark(
                                x: .value("Month", item.month),
                                y: .value("Sales", item.sales)
                            )
                            .foregroundStyle(by: .value("Category", item.category))
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic)
                    }
                    .chartLegend(position: .bottom)
                    .frame(height: 200)
                }
            }
            .navigationTitle("Charts")
        }
    }
}

#Preview {
    ChartExampleView()
} 