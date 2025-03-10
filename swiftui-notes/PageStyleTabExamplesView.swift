import SwiftUI

// MARK: - Basic Page Style
struct BasicPageStyleLayout: View {
    var body: some View {
        TabView {
            ForEach(1...5, id: \.self) { index in
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue.opacity(0.2))
                    .overlay {
                        Text("Page \(index)")
                            .font(.largeTitle)
                    }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

// MARK: - Card Page Style
struct CardPageStyleLayout: View {
    var body: some View {
        TabView {
            ForEach(1...5, id: \.self) { index in
                VStack {
                    Image(systemName: "photo")
                        .font(.system(size: 80))
                        .foregroundStyle(.gray)
                    
                    Text("Card Title \(index)")
                        .font(.title)
                    
                    Text("This is the description for card \(index)")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                .padding(.horizontal, 20)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

// MARK: - Image Page Style
struct ImagePageStyleLayout: View {
    let images = ["house", "star", "heart", "person", "gear"]
    
    var body: some View {
        TabView {
            ForEach(images.indices, id: \.self) { index in
                VStack(spacing: 20) {
                    Image(systemName: images[index])
                        .font(.system(size: 100))
                        .symbolEffect(.bounce, options: .repeating)
                    
                    Text("Image \(index + 1)")
                        .font(.title)
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [.blue.opacity(0.2), .purple.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

// MARK: - Interactive Page Style
struct InteractivePageStyleLayout: View {
    @State private var currentPage = 0
    let totalPages = 5
    
    var body: some View {
        VStack {
            // 页面指示器
            HStack {
                ForEach(0..<totalPages, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? .blue : .gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding()
            
            // 内容
            TabView(selection: $currentPage) {
                ForEach(0..<totalPages, id: \.self) { index in
                    VStack {
                        Text("Page \(index + 1)")
                            .font(.largeTitle)
                        
                        if index < totalPages - 1 {
                            Button("Next") {
                                withAnimation {
                                    currentPage = index + 1
                                }
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page)
            
            // 控制按钮
            HStack {
                Button {
                    withAnimation {
                        currentPage = max(0, currentPage - 1)
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                .disabled(currentPage == 0)
                
                Spacer()
                
                Button {
                    withAnimation {
                        currentPage = min(totalPages - 1, currentPage + 1)
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
                .disabled(currentPage == totalPages - 1)
            }
            .padding()
        }
    }
}

// MARK: - Onboarding Page Style
struct OnboardingPageStyleLayout: View {
    @State private var currentPage = 0
    
    let onboardingData = [
        (image: "star", title: "Welcome", description: "Get started with our app"),
        (image: "wand.and.stars", title: "Features", description: "Discover amazing features"),
        (image: "checkmark.circle", title: "Ready", description: "You're all set to go")
    ]
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(onboardingData.indices, id: \.self) { index in
                VStack(spacing: 30) {
                    Image(systemName: onboardingData[index].image)
                        .font(.system(size: 80))
                        .foregroundStyle(.blue)
                        .symbolEffect(.bounce)
                    
                    Text(onboardingData[index].title)
                        .font(.title)
                        .bold()
                    
                    Text(onboardingData[index].description)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)
                    
                    if index == onboardingData.count - 1 {
                        Button("Get Started") {
                            // 开始使用操作
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .tag(index)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

// MARK: - Main View
struct PageStyleTabExamplesView: View {
    var body: some View {
        TabView {
            NavigationStack {
                BasicPageStyleLayout()
                    .navigationTitle("Basic")
            }
            .tabItem {
                Label("Basic", systemImage: "1.circle")
            }
            
            NavigationStack {
                CardPageStyleLayout()
                    .navigationTitle("Cards")
            }
            .tabItem {
                Label("Cards", systemImage: "2.circle")
            }
            
            NavigationStack {
                ImagePageStyleLayout()
                    .navigationTitle("Images")
            }
            .tabItem {
                Label("Images", systemImage: "3.circle")
            }
            
            NavigationStack {
                InteractivePageStyleLayout()
                    .navigationTitle("Interactive")
            }
            .tabItem {
                Label("Interactive", systemImage: "4.circle")
            }
            
            NavigationStack {
                OnboardingPageStyleLayout()
                    .navigationTitle("Onboarding")
            }
            .tabItem {
                Label("Onboarding", systemImage: "5.circle")
            }
        }
    }
}

// MARK: - Previews
#Preview("Main View") {
    PageStyleTabExamplesView()
}

#Preview("Basic") {
    BasicPageStyleLayout()
}

#Preview("Cards") {
    CardPageStyleLayout()
}

#Preview("Images") {
    ImagePageStyleLayout()
}

#Preview("Interactive") {
    InteractivePageStyleLayout()
}

#Preview("Onboarding") {
    OnboardingPageStyleLayout()
} 
