import SwiftUI

struct Email: Identifiable {
    let id = UUID()
    let sender: String
    let subject: String
    let preview: String
    let date: Date
    var isStarred: Bool
    var isRead: Bool
}

struct SwipeActionsExampleView: View {
    @State private var emails: [Email] = [
        Email(sender: "John Doe", subject: "Meeting Tomorrow", preview: "Hi, regarding tomorrow's meeting...", date: Date(), isStarred: false, isRead: false),
        Email(sender: "App Store", subject: "Your app is ready for sale", preview: "Congratulations! Your app has been...", date: Date().addingTimeInterval(-3600), isStarred: true, isRead: true),
        Email(sender: "GitHub", subject: "Pull request submitted", preview: "A new pull request has been...", date: Date().addingTimeInterval(-7200), isStarred: false, isRead: false),
        Email(sender: "Netflix", subject: "New shows available", preview: "Check out what's new this week...", date: Date().addingTimeInterval(-86400), isStarred: false, isRead: true),
        Email(sender: "Twitter", subject: "Security alert", preview: "We noticed a new login to your...", date: Date().addingTimeInterval(-172800), isStarred: true, isRead: false)
    ]
    
    @State private var showAlert = false
    @State private var selectedEmail: Email?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($emails) { $email in
                    EmailRow(email: email)
                        // 左滑动作
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            // 删除按钮
                            Button(role: .destructive) {
                                selectedEmail = email
                                showAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                            // 归档按钮
                            Button {
                                withAnimation {
                                    if let index = emails.firstIndex(where: { $0.id == email.id }) {
                                        emails.remove(at: index)
                                    }
                                }
                            } label: {
                                Label("Archive", systemImage: "archivebox")
                            }
                            .tint(.orange)
                        }
                        // 右滑动作
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            // 标记已读/未读
                            Button {
                                withAnimation {
                                    email.isRead.toggle()
                                }
                            } label: {
                                Label(email.isRead ? "Unread" : "Read", 
                                      systemImage: email.isRead ? "envelope.badge" : "envelope.open")
                            }
                            .tint(.blue)
                            
                            // 星标
                            Button {
                                withAnimation {
                                    email.isStarred.toggle()
                                }
                            } label: {
                                Label("Star", systemImage: email.isStarred ? "star.slash" : "star.fill")
                            }
                            .tint(.yellow)
                        }
                }
            }
            .navigationTitle("Inbox")
            .alert("Delete Email", isPresented: $showAlert, presenting: selectedEmail) { email in
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    withAnimation {
                        emails.removeAll { $0.id == email.id }
                    }
                }
            } message: { email in
                Text("Are you sure you want to delete this email from \(email.sender)?")
            }
        }
    }
}

struct EmailRow: View {
    let email: Email
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // 发件人和日期
                Text(email.sender)
                    .font(.headline)
                    .foregroundStyle(email.isRead ? .secondary : .primary)
                Spacer()
                Text(email.date, style: .relative)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            // 主题
            Text(email.subject)
                .font(.subheadline)
                .foregroundStyle(email.isRead ? .secondary : .primary)
            
            // 预览
            Text(email.preview)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
            
            // 标记
            HStack {
                if !email.isRead {
                    Circle()
                        .fill(.blue)
                        .frame(width: 8, height: 8)
                }
                if email.isStarred {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .font(.caption)
                }
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SwipeActionsExampleView()
} 