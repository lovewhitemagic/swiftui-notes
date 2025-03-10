import SwiftUI

struct CenterCardView: View {
    @State private var showCard = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    Button("显示卡片") {
                        withAnimation(.spring(duration: 0.3)) {
                            showCard = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .navigationTitle("居中卡片示例")
            }
            
            if showCard {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.3)) {
                                showCard = false
                            }
                        }
                    
                    CardContent(isPresented: $showCard)
                        .transition(.scale)
                }
            }
        }
    }
}

struct CardContent: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // 顶部栏
            HStack {
                Text("卡片标题")
                    .font(.headline)
                Spacer()
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        isPresented = false
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            // 卡片内容
            Text("这是卡片的内容区域\n可以放置任何视图")
                .multilineTextAlignment(.center)
                .padding()
            
            // 底部按钮
            Button("确定") {
                withAnimation(.spring(duration: 0.3)) {
                    isPresented = false
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(width: 300)
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(radius: 10)
        )
    }
}

#Preview {
    CenterCardView()
} 