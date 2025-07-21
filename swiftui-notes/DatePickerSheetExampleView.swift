import SwiftUI

// 日期选择器Sheet
struct DatePickerSheet: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) private var dismiss
    
        var body: some View {
        ZStack {
            // 滚轮完全居中 - 使用ZStack让其在整个sheet中心
            DatePicker(
                "选择日期和时间",
                selection: $selectedDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 完全居中
            
            // 渐变背景 - 使用alignment固定在底部
            LinearGradient(
                gradient: Gradient(colors: [
                        Color(.systemBackground).opacity(0.3),
                        Color(.systemBackground).opacity(0.9),
                        Color(.systemBackground).opacity(1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
          
            .ignoresSafeArea(edges: .bottom)
              .frame(height: 80)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
            // 底部确定按钮 - 使用alignment固定在底部
            Button("确定") {
                dismiss()
            }
            .frame(width: 120, height: 44)
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(22)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

// 日期选择器展示视图
struct DatePickerSheetExampleView: View {
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            // 显示当前选择的日期
            VStack(spacing: 8) {
                Text("已选择的日期时间：")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(selectedDate, style: .date)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text(selectedDate, style: .time)
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            // 打开日期选择器按钮
            Button("选择日期时间") {
                showDatePicker = true
            }
            .buttonStyle(.borderedProminent)
            .font(.headline)
        }
        .padding()
        .sheet(isPresented: $showDatePicker) {
            DatePickerSheet(selectedDate: $selectedDate)
            .presentationDetents([.height(300)])//自定义高度
            .presentationCornerRadius(40) // 设置圆角
        }
    }
}

#Preview {
    DatePickerSheetExampleView()
} 