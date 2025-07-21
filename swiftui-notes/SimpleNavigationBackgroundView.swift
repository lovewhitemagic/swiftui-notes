import SwiftUI

// 简单的导航栏背景颜色展示
struct SimpleNavigationBackgroundView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(1...30, id: \.self) { index in
                    Text("示例项目 \(index)")
                        .font(.body)
                } 
                .padding()
            }
                    .navigationTitle("My Page")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.blue, for: .navigationBar)
        }

    }
}

#Preview {
    SimpleNavigationBackgroundView()
} 