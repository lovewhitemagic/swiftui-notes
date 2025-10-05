import SwiftUI

struct FullScreenCoverDismissView: View {
    @State private var showFullScreenCover = false

    var body: some View {
        VStack(spacing: 24) {
            Text("Full Screen Cover")
                .font(.largeTitle)
                .bold()

            Text("Tap the button to present a full screen cover. Tap anywhere on the presented view to dismiss it.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Show Cover") {
                showFullScreenCover = true
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color(uiColor: .systemGroupedBackground))
        .fullScreenCover(isPresented: $showFullScreenCover) {
            FullScreenMessageView()
        }
    }
}

private struct FullScreenMessageView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "hand.tap")
                    .font(.system(size: 56))
                    .foregroundStyle(.white)

                Text("Tap anywhere to dismiss")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)

                Text("This view is presented as a full screen cover.")
                    .foregroundStyle(.white.opacity(0.8))
            }
            .padding(32)
            .background(Color.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    FullScreenCoverDismissView()
}
