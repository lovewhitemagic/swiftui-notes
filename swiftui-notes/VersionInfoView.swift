import SwiftUI

struct VersionInfoView: View {
    private var appName: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ??
        "应用名称"
    }
    
    private var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0.0"
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(appName)
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("版本 \(version)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.bottom, 100)
    }
}

#Preview {
    VersionInfoView()
} 