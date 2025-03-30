import SwiftUI

struct CustomSheetView: View {
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            Button("Show Custom Sheet") {
                showSheet = true
            }
            .navigationTitle("Custom Sheet")
        }
        .sheet(isPresented: $showSheet) {
            CustomSheet()
                // 设置背景透明
                .presentationBackground(.clear)
                // 设置检测边缘
                .presentationDetents([.medium])
                // 设置sheet整体边距
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
        }
    }
}

struct CustomSheet: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部栏
            HStack {
                Text("Custom Sheet")
                    .font(.headline)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                        .font(.title2)
                }
            }
            .padding()
            
            // 内容区域
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(1...15, id: \.self) { index in
                        HStack {
                            Text("Item \(index)")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    CustomSheetView()
} 
