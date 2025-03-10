import SwiftUI
import UserNotifications

struct NotificationScheduleView: View {
    @State private var selectedDate = Date()
    @State private var title = ""
    @State private var message = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("通知内容") {
                    TextField("标题", text: $title)
                    TextField("内容", text: $message)
                }
                
                Section("时间设置") {
                    DatePicker("选择时间",
                              selection: $selectedDate,
                              in: Date()...,  // 只能选择未来时间
                              displayedComponents: [.date, .hourAndMinute]
                    )
                }
                
                Section {
                    Button(action: scheduleNotification) {
                        HStack {
                            Image(systemName: "bell.badge")
                            Text("设置提醒")
                        }
                    }
                    
                    Button(action: checkPendingNotifications) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("查看待发送通知")
                        }
                    }
                    
                    Button(action: cancelAllNotifications) {
                        HStack {
                            Image(systemName: "bell.slash")
                            Text("取消所有通知")
                        }
                        .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("提醒设置")
            .alert("通知", isPresented: $showAlert) {
                Button("确定", role: .cancel) {}
            } message: {
                Text(alertMessage)
            }
            .onAppear {
                requestNotificationPermission()
            }
        }
    }
    
    // 请求通知权限
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("请求通知权限出错：\(error.localizedDescription)")
            }
            if granted {
                print("通知权限已获取")
            } else {
                print("通知权限被拒绝")
            }
        }
    }
    
    // 设置通知
    private func scheduleNotification() {
        // 创建通知内容
        let content = UNMutableNotificationContent()
        content.title = title.isEmpty ? "提醒" : title
        content.body = message.isEmpty ? "到时间了！" : message
        content.sound = .default
        
        // 创建触发器
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: selectedDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        // 创建请求
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        // 添加通知请求
        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "设置通知失败：\(error.localizedDescription)"
                } else {
                    alertMessage = "通知设置成功！将在 \(selectedDate.formatted(date: .long, time: .shortened)) 提醒您。"
                }
                showAlert = true
            }
        }
    }
    
    // 查看待发送的通知
    private func checkPendingNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                if requests.isEmpty {
                    alertMessage = "没有待发送的通知"
                } else {
                    alertMessage = "待发送通知数量：\(requests.count)"
                }
                showAlert = true
            }
        }
    }
    
    // 取消所有通知
    private func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        DispatchQueue.main.async {
            alertMessage = "已取消所有待发送的通知"
            showAlert = true
        }
    }
}

#Preview {
    NotificationScheduleView()
} 