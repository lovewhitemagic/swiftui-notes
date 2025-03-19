import SwiftUI

struct MenuStylesView: View {
    @State private var selectedColor = "Red"
    @State private var selectedSize = "Medium"
    @State private var isEnabled = true
    
    var body: some View {
        NavigationStack {
            List {
                // 基础菜单
                Section("Basic Menu") {
                    Menu("Basic Menu") {
                        Button("Option 1") {}
                        Button("Option 2") {}
                        Button("Option 3") {}
                    }
                }
                
                // 带图标的菜单
                Section("Menu with Icons") {
                    Menu {
                        Button(action: {}) {
                            Label("Add to Bookmarks", systemImage: "bookmark")
                        }
                        Button(action: {}) {
                            Label("Add to Favorites", systemImage: "star")
                        }
                        Button(action: {}) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                    } label: {
                        Label("Actions", systemImage: "ellipsis.circle")
                    }
                }
                
                // 带标题的分组菜单
                Section("Menu with Section Titles") {
                    Menu("Edit Options") {
                        Text("Text Actions").foregroundStyle(.secondary)
                        Group {
                            Button("Copy") {}
                            Button("Paste") {}
                            Button("Cut") {}
                        }
                        
                        Divider()
                        
                        Text("Selection Actions").foregroundStyle(.secondary)
                        Group {
                            Button("Select All") {}
                            Button("Select None") {}
                            Button("Invert Selection") {}
                        }
                        
                        Divider()
                        
                        Text("Advanced Actions").foregroundStyle(.secondary)
                        Group {
                            Button("Format") {}
                            Button("Transform") {}
                            Button("Convert") {}
                        }
                    }
                }
                
                // 子菜单
                Section("Submenu") {
                    Menu("File Operations") {
                        Menu("Export As...") {
                            Button("PDF") {}
                            Button("Word") {}
                            Button("Image") {}
                        }
                        
                        Menu("Share With...") {
                            Button("Email") {}
                            Button("Messages") {}
                            Button("AirDrop") {}
                        }
                    }
                }
                
                // Picker 菜单
                Section("Picker Menus") {
                    Menu {
                        Picker("Color", selection: $selectedColor) {
                            Text("Red").tag("Red")
                            Text("Green").tag("Green")
                            Text("Blue").tag("Blue")
                        }
                    } label: {
                        Label("Color: \(selectedColor)", systemImage: "paintpalette")
                    }
                    
                    Menu {
                        Picker("Size", selection: $selectedSize) {
                            Text("Small").tag("Small")
                            Text("Medium").tag("Medium")
                            Text("Large").tag("Large")
                        }
                    } label: {
                        Label("Size: \(selectedSize)", systemImage: "ruler")
                    }
                }
                
                // 混合菜单
                Section("Mixed Menu") {
                    Menu {
                        Button(action: {}) {
                            Label("New Item", systemImage: "plus")
                        }
                        
                        Menu("More Options") {
                            Button("Option 1") {}
                            Button("Option 2") {}
                        }
                        
                        Divider()
                        
                        Toggle("Enabled", isOn: $isEnabled)
                        
                        Divider()
                        
                        Button(role: .destructive, action: {}) {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Label("Advanced", systemImage: "gearshape.2")
                    }
                }
                
                // 主要/次要按钮菜单
                Section("Role-based Menu") {
                    Menu("Actions") {
                        Button("Save", role: .none) {}
                        Button("Archive", role: .cancel) {}
                        Button("Delete", role: .destructive) {}
                    }
                }
                
               
                
                // 控制组菜单
                Section("Menu with Control Group") {
                    Menu("Edit Controls") {
                        // 水平控制组
                        ControlGroup {
                            Button(action: {}) {
                                Label("Cut", systemImage: "scissors")
                            }
                            Button(action: {}) {
                                Label("Copy", systemImage: "doc.on.doc")
                            }
                            Button(action: {}) {
                                Label("Paste", systemImage: "doc.on.clipboard")
                            }
                        }
                        
                        Divider()
                        
                        // 垂直控制组
                        ControlGroup {
                            Button(action: {}) {
                                Label("Bold", systemImage: "bold")
                            }
                            Button(action: {}) {
                                Label("Italic", systemImage: "italic")
                            }
                            Button(action: {}) {
                                Label("Underline", systemImage: "underline")
                            }
                        }
                        .controlGroupStyle(.navigation)  // 垂直样式
                        
                        Divider()
                        
                        // 混合控制组
                        Text("Alignment").foregroundStyle(.secondary)
                        ControlGroup {
                            Button(action: {}) {
                                Label("Left", systemImage: "text.align.left")
                            }
                            Button(action: {}) {
                                Label("Center", systemImage: "text.align.center")
                            }
                            Button(action: {}) {
                                Label("Right", systemImage: "text.align.right")
                            }
                            Button(action: {}) {
                                Label("Justify", systemImage: "text.align.justified")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Menu Styles")
        }
    }
}

#Preview {
    MenuStylesView()
} 
