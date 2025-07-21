import SwiftUI

struct ProStatusCard: View {
    let isPro: Bool
    @State private var showProUpgrade = false
    
    var body: some View {
        VStack(spacing: 8) {
            Text(isPro ? "专业版" : "升级到 Pro")
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundColor(.white)
            
            Text(isPro ? "感谢您的支持" : "一次性购买，永久使用所有功能")
                .font(.system(.caption, design: .rounded))
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(LinearGradient(
                    colors: isPro ? [.green, .green.opacity(0.8)] : [.blue, .blue.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
        )
        .padding(.horizontal, 20)
        .onTapGesture {
            if !isPro {
                showProUpgrade = true
            }
        }
        .fullScreenCover(isPresented: $showProUpgrade) {
            ProUpgradeView()
        }
    }
}

struct ProUpgradeView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Pro 升级页面")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") {
                        dismiss()
                    }
                }
            }
        }
    }
}



#Preview {
    VStack {
        ProStatusCard(isPro: false)
        ProStatusCard(isPro: true)
    }
    .padding()
} 
