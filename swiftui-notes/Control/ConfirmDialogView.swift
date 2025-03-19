import SwiftUI

struct ConfirmDialogView: View {
    @State private var showBasicDialog = false
    @State private var showCustomDialog = false
    @State private var showRoleDialog = false
    @State private var showDestructiveDialog = false
    @State private var showMultipleActionsDialog = false
    @State private var selectedOption = "None"
    
     
    var body: some View {
        NavigationStack {
            List {
                Section("基础对话框") {
                    Button("显示基础对话框") {
                        showBasicDialog = true
                    }
                    .confirmationDialog(
                        "基础对话框",
                        isPresented: $showBasicDialog
                    ) {
                        Button("选项 1") {
                            selectedOption = "选项 1"
                        }
                        Button("选项 2") {
                            selectedOption = "选项 2"
                        }
                    }
                }
                
                Section("带消息的对话框") {
                    Button("显示自定义对话框") {
                        showCustomDialog = true
                    }
                    .confirmationDialog(
                        "选择一个选项",
                        isPresented: $showCustomDialog,
                        titleVisibility: .visible
                    ) {
                        Button("保存") {
                            selectedOption = "保存"
                        }
                        Button("删除") {
                            selectedOption = "删除"
                        }
                    } message: {
                        Text("请选择要执行的操作")
                    }
                }
                
                Section("带角色的对话框") {
                    Button("显示角色对话框") {
                        showRoleDialog = true
                    }
                    .confirmationDialog(
                        "选择操作",
                        isPresented: $showRoleDialog
                    ) {
                        Button("取消", role: .cancel) {
                            selectedOption = "已取消"
                        }
                        Button("继续", role: .none) {
                            selectedOption = "已继续"
                        }
                    }
                }
                
                Section("破坏性操作对话框") {
                    Button("显示破坏性操作对话框") {
                        showDestructiveDialog = true
                    }
                    .confirmationDialog(
                        "删除项目",
                        isPresented: $showDestructiveDialog,
                        titleVisibility: .visible
                    ) {
                        Button("删除", role: .destructive) {
                            selectedOption = "已删除"
                        }
                        Button("取消", role: .cancel) {
                            selectedOption = "已取消"
                        }
                    } message: {
                        Text("此操作无法撤销")
                    }
                }
                
                Section("多操作对话框") {
                    Button("显示多个操作") {
                        showMultipleActionsDialog = true
                    }
                    .confirmationDialog(
                        "分享选项",
                        isPresented: $showMultipleActionsDialog,
                        titleVisibility: .visible
                    ) {
                        Button("复制链接") {
                            selectedOption = "已复制链接"
                        }
                        Button("通过邮件分享") {
                            selectedOption = "已通过邮件分享"
                        }
                        Button("通过消息分享") {
                            selectedOption = "已通过消息分享"
                        }
                        Button("添加到收藏") {
                            selectedOption = "已添加到收藏"
                        }
                        Button("取消", role: .cancel) {
                            selectedOption = "已取消"
                        }
                    } message: {
                        Text("选择分享方式")
                    }
                }
                
                Section("已选择的选项") {
                    Text("已选择: \(selectedOption)")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("ConfirmDialog")
        }
    }
}

#Preview {
    ConfirmDialogView()
} 