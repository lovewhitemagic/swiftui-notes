import SwiftUI
import Charts

// 消费总览数据模型
struct ConsumptionSummary: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let subtitle: String?
}

// 年度、月度、平台等统计数据模型
struct ConsumptionStat: Identifiable {
    let id = UUID()
    let period: String
    let count: Int
    let amount: Double
}

struct ConsumptionStatisticsView: View {
    // MARK: - 静态示例数据
    private let summaryItems: [ConsumptionSummary] = [
        ConsumptionSummary(title: "总消费", value: "19 件", subtitle: "¥63,339.50"),
        ConsumptionSummary(title: "日均成本", value: "¥192.56", subtitle: ""),
        ConsumptionSummary(title: "年度均单价", value: "¥3,333.66", subtitle: "2025 年")
    ]

    private let yearlyStats: [ConsumptionStat] = [
        ConsumptionStat(period: "2025 年", count: 13, amount: 228.60),
        ConsumptionStat(period: "2024 年", count: 3, amount: 62_921.60),
        ConsumptionStat(period: "2023 年", count: 3, amount: 189.30)
    ]

    private let monthlyStats: [ConsumptionStat] = [
        ConsumptionStat(period: "2025-10", count: 10, amount: 158.00),
        ConsumptionStat(period: "2025-09", count: 6, amount: 789.50),
        ConsumptionStat(period: "2024-03", count: 2, amount: 58_665.80),
        ConsumptionStat(period: "2023-02", count: 7, amount: 4_586.65),
        ConsumptionStat(period: "2022-07", count: 3, amount: 189.30)
    ]

    private let platformStats: [ConsumptionStat] = [
        ConsumptionStat(period: "其他", count: 6, amount: 58_907.70)
    ]

    // MARK: - 主体视图
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    summarySection

                    chartCard(title: "年度消费统计", subtitle: "件数与金额随年份的变化") {
                        Chart(yearlyStats) { stat in
                            BarMark(
                                x: .value("年份", stat.period),
                                y: .value("金额", stat.amount)
                            )
                            .cornerRadius(8)
                            .foregroundStyle(Color.indigo.gradient)

                            LineMark(
                                x: .value("年份", stat.period),
                                y: .value("件数", stat.count)
                            )
                            .foregroundStyle(Color.indigo.opacity(0.6))
                            .interpolationMethod(.monotone)

                            PointMark(
                                x: .value("年份", stat.period),
                                y: .value("件数", stat.count)
                            )
                            .foregroundStyle(Color.indigo.opacity(0.8))
                        }
                        .chartYAxis(.hidden)
                        .frame(height: 220)
                    }

                    chartCard(title: "月度消费统计", subtitle: "近一年内各月份的消费分布") {
                        Chart(monthlyStats) { stat in
                            AreaMark(
                                x: .value("月份", stat.period),
                                y: .value("金额", stat.amount)
                            )
                            .foregroundStyle(Color.indigo.opacity(0.35).gradient)
                            .interpolationMethod(.catmullRom)

                            LineMark(
                                x: .value("月份", stat.period),
                                y: .value("金额", stat.amount)
                            )
                            .foregroundStyle(Color.indigo)
                            .lineStyle(StrokeStyle(lineWidth: 2))
                        }
                        .chartXAxis {
                            AxisMarks(values: .automatic) { value in
                                AxisValueLabel()
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .chartYAxis {
                            AxisMarks(position: .leading) { value in
                                AxisValueLabel()
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(height: 240)
                    }

                    chartCard(title: "平台消费统计", subtitle: "不同平台的消费情况") {
                        Chart(platformStats) { stat in
                            BarMark(
                                x: .value("平台", stat.period),
                                y: .value("金额", stat.amount)
                            )
                            .cornerRadius(8)
                            .foregroundStyle(Color.indigo.gradient)
                        }
                        .frame(height: 160)
                    }
                }
                .padding(24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("消费分析")
        }
    }

    // MARK: - 汇总信息模块
    private var summarySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("总体统计")
                .font(.headline)
                .foregroundStyle(.primary)

            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16), count: 3), spacing: 16) {
                ForEach(summaryItems) { item in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.title)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(item.value)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.primary)
                        if let subtitle = item.subtitle, !subtitle.isEmpty {
                            Text(subtitle)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
            }
        }
    }

    // MARK: - 图表卡片通用布局
    private func chartCard<Content: View>(title: String, subtitle: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            content()
        }
        .padding(20)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

#Preview {
    ConsumptionStatisticsView()
}
