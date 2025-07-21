import SwiftUI

// 触觉反馈示例视图
struct HapticFeedbackExampleView: View {
    @State private var selectedTab = 0
    @State private var buttonTapCount = 0
    @State private var sliderValue: Double = 0.5
    @State private var toggleState = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                // Tab选择器 - 展示tab切换的触觉反馈
                VStack(spacing: 12) {
                    Text("Tab切换触觉反馈")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Picker("选择Tab", selection: $selectedTab) {
                        Text("首页").tag(0)
                        Text("搜索").tag(1)
                        Text("设置").tag(2)
                        Text("个人").tag(3)
                    }
                    .pickerStyle(.segmented)
                    .sensoryFeedback(.impact(weight: .medium), trigger: selectedTab)
                    
                    Text("当前选择: Tab \(selectedTab + 1)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // 按钮点击触觉反馈
                VStack(spacing: 12) {
                    Text("按钮点击触觉反馈")
                        .font(.headline)
                    
                    Button("点击我 (已点击 \(buttonTapCount) 次)") {
                        buttonTapCount += 1
                    }
                    .buttonStyle(.borderedProminent)
                    .sensoryFeedback(.impact(weight: .heavy), trigger: buttonTapCount)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                
                // 滑块触觉反馈
                VStack(spacing: 12) {
                    Text("滑块触觉反馈")
                        .font(.headline)
                    
                    VStack {
                        Slider(value: $sliderValue, in: 0...1, step: 0.1)
                            .sensoryFeedback(.selection, trigger: sliderValue)
                        
                        Text("当前值: \(String(format: "%.1f", sliderValue))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
                
                // 开关触觉反馈
                VStack(spacing: 12) {
                    Text("开关触觉反馈")
                        .font(.headline)
                    
                    HStack {
                        Text("启用通知")
                        Spacer()
                        Toggle("", isOn: $toggleState)
                            .sensoryFeedback(.impact(weight: .light), trigger: toggleState)
                    }
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(12)
                
                // TabView页面滑动触觉反馈
                TabViewPageExample()
                
                Spacer()
            }
            .padding()
            .navigationTitle("触觉反馈示例")
        }
    }
}

// TabView页面滑动触觉反馈组件
struct TabViewPageExample: View {
    @State private var currentPage = 0
    
    var body: some View {
        VStack(spacing: 12) {
            Text("页面滑动触觉反馈")
                .font(.headline)
            
            TabView(selection: $currentPage) {
                // 第一页
                VStack {
                    Image(systemName: "house.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                    Text("首页")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                .tag(0)
                
                // 第二页
                VStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                    Text("搜索")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
                .tag(1)
                
                // 第三页
                VStack {
                    Image(systemName: "person.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.purple)
                    Text("个人")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .background(Color.purple.opacity(0.1))
                .cornerRadius(12)
                .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(height: 150)
            .sensoryFeedback(.impact(weight: .medium), trigger: currentPage)
            
            Text("当前页面: \(currentPage + 1)/3")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.pink.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    HapticFeedbackExampleView()
} 