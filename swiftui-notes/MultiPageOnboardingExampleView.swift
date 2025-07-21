import SwiftUI

// 多页的引导页示例
struct MultiPageOnboardingExampleView: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    @State private var showOnboarding = false

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
            OnboardingSheet()
                .presentationDetents([.large])
        }
        .onAppear {
            if isFirstLaunch {
                showOnboarding = true
            }
        }
    }
}

struct OnboardingSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentPage = 0

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                OnboardingPage(title: "欢迎", description: "探索我们的应用！", image: "house.fill", tag: 0)
                OnboardingPage(title: "功能", description: "体验强大功能！", image: "gear", tag: 1)
                OnboardingPage(title: "开始", description: "立即开始使用！", image: "star", tag: 2)
                    .overlay(alignment: .bottom) {
                        Button("开始使用") {
                            dismiss()
                        }
                        .padding()
                        .background(Color("AccentColor"))
                        .foregroundColor(.blue)
                        .clipShape(Capsule())
                        .padding(.bottom, 50)
                    }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .sensoryFeedback(.impact(weight: .medium), trigger: currentPage)
        }
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let image: String
    let tag: Int

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(Color("AccentColor"))
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .tag(tag)
    }
}

#Preview {
    MultiPageOnboardingExampleView()
} 