import SwiftUI

// 单页的欢迎页引导示例
struct OnboardingExampleView: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    @State private var showOnboarding = false
    @State private var isTapped = false

    var body: some View {
        VStack {
            Text("主页面")
                .font(.largeTitle)
            Button("显示引导页") {
                showOnboarding = true
            }
            .padding()
            .background(Color("AccentColor"))
            .foregroundColor(.blue)
            .clipShape(Capsule())
        }
        .sheet(isPresented: $showOnboarding, onDismiss: {
            isFirstLaunch = false
        }) {
            VStack(spacing: 20) {
                Image(systemName: "star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("AccentColor"))
                Text("欢迎使用")
                    .font(.title)
                    .fontWeight(.bold)
                Text("开始体验我们的应用！")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Button("开始") {
                    isTapped.toggle()
                    showOnboarding = false
                }
                .padding()
                .background(Color("AccentColor"))
                .foregroundColor(.blue)
                .clipShape(Capsule())
                .sensoryFeedback(.impact(weight: .medium), trigger: isTapped)
            }
            .padding()
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            if isFirstLaunch {
                showOnboarding = true
            }
        }
    }
}

#Preview {
    OnboardingExampleView()
} 