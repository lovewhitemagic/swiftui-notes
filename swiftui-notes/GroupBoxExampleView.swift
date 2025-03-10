import SwiftUI

struct GroupBoxExampleView: View {
    @State private var isEnabled = true
    @State private var volume = 50.0
    @State private var brightness = 70.0
    @State private var isAutoPlayEnabled = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 基础样式
                    GroupBox("Basic GroupBox") {
                        Text("This is a basic GroupBox with a title")
                            .padding(.vertical, 8)
                    }
                    
                    // 自定义标题
                    GroupBox {
                        Text("GroupBox with custom label")
                            .padding(.vertical, 8)
                    } label: {
                        Label("Custom Label", systemImage: "star.fill")
                            .foregroundStyle(.blue)
                    }
                    
                    // 带背景色
                    GroupBox {
                        Text("GroupBox with background")
                            .padding(.vertical, 8)
                    }
                    .backgroundStyle(.blue.opacity(0.1))
                    
                    // 带控件的 GroupBox
                    GroupBox("Settings") {
                        VStack(alignment: .leading, spacing: 16) {
                            Toggle("Enable Feature", isOn: $isEnabled)
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                Text("Volume")
                                Slider(value: $volume, in: 0...100)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Brightness")
                                Slider(value: $brightness, in: 0...100)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    
                    // 嵌套的 GroupBox
                    GroupBox("Nested GroupBox") {
                        VStack(spacing: 16) {
                            GroupBox("Playback") {
                                Toggle("Auto Play", isOn: $isAutoPlayEnabled)
                                    .padding(.vertical, 4)
                            }
                            
                            GroupBox("Quality") {
                                Picker("Quality", selection: .constant("High")) {
                                    Text("Low").tag("Low")
                                    Text("Medium").tag("Medium")
                                    Text("High").tag("High")
                                }
                                .pickerStyle(.segmented)
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    // 自定义样式
                    GroupBox {
                        HStack {
                            Image(systemName: "bell.fill")
                                .font(.title2)
                            VStack(alignment: .leading) {
                                Text("Notifications")
                                    .font(.headline)
                                Text("Configure your notification preferences")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                    .backgroundStyle(.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // 带阴影的 GroupBox
                    GroupBox("Shadowed GroupBox") {
                        Text("This GroupBox has a custom shadow")
                            .padding(.vertical, 8)
                    }
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    
                    // 带边框的 GroupBox
                    GroupBox {
                        Text("This GroupBox has a custom border")
                            .padding(.vertical, 8)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.blue.opacity(0.3), lineWidth: 1)
                    }
                }
                .padding()
            }
            .navigationTitle("GroupBox Examples")
        }
    }
}

#Preview {
    GroupBoxExampleView()
} 