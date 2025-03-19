import SwiftUI
import PhotosUI

struct BillCategoryButton: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(isSelected ? .blue : .primary)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
            
            // 下划线
            Rectangle()
                .fill(isSelected ? Color.blue : Color.clear)
                .frame(height: 2)
                .padding(.horizontal, 4)
        }
    }
}

struct ReceiptItemRow: View {
    let title: String
    let content: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(content)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
    }
}

// 小票内容视图
struct ReceiptContentView: View {
    @Binding var eventTitle: String
    @Binding var amount: String
    @Binding var selectedCategory: String
    @Binding var selectedAccount: String
    @Binding var date: Date
    @Binding var note: String
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    
    let categories: [String]
    let accounts: [String]
    
    var body: some View {
        VStack(spacing: 16) {
            // 金额输入区域
            VStack(spacing: 16) {
                TextField("0.00", text: $amount)
                    .font(.system(size: 32, weight: .medium))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                TextField("添加事件名称", text: $eventTitle)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(15)
            
            // 类别选择
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(categories, id: \.self) { category in
                        BillCategoryButton(title: category, isSelected: selectedCategory == category)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                .padding(.horizontal, 8)
            }
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(15)
            
            // 支付方式
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(accounts, id: \.self) { account in
                        BillCategoryButton(title: account, isSelected: selectedAccount == account)
                            .onTapGesture {
                                selectedAccount = account
                            }
                    }
                }
                .padding(.horizontal, 8)
            }
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(15)
            // 日期选择
            HStack {
                Spacer()
                DatePicker("",
                         selection: $date,
                         displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.compact)
                    .labelsHidden()
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            
            // 备注
            HStack(alignment: .top) {
                Text("备注")
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                TextEditor(text: $note)
                    .frame(height: 80)
                    .placeholder(when: note.isEmpty) {
                        Text("添加备注...")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            
            // 附件
            HStack(alignment: .top) {
                Text("附件")
                    .foregroundColor(.gray)
                Spacer()
                AttachmentView(selectedItem: $selectedItem, selectedImageData: $selectedImageData)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

// 类别选择视图
struct CategorySelectionView: View {
    let title: String
    let items: [String]
    @Binding var selectedItem: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: title == "类别" ? "tag" : "creditcard")
                    .foregroundColor(.gray)
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(items, id: \.self) { item in
                        BillCategoryButton(title: item, isSelected: selectedItem == item)
                            .onTapGesture {
                                selectedItem = item
                            }
                    }
                }
            }
        }
    }
}

// 附件视图
struct AttachmentView: View {
    @Binding var selectedItem: PhotosPickerItem?
    @Binding var selectedImageData: Data?
    
    var body: some View {
        VStack {
            if selectedImageData == nil {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        HStack {
                            Image(systemName: "photo")
                            Text("添加照片")
                        }
                        .foregroundColor(.blue)
                    }
            }
            
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .cornerRadius(8)
            }
        }
    }
}

struct BillListView: View {
    @State private var showingNewBillSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                // TODO: 这里添加账单列表的内容
                Text("账单列表")
            }
            .navigationTitle("账单")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewBillSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                    }
                }
            }
            .sheet(isPresented: $showingNewBillSheet) {
                CreateBillView()
            }
        }
    }
}

struct CreateBillView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var eventTitle = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var selectedCategory = "餐饮"
    @State private var selectedAccount = "现金"
    @State private var note = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    let categories = ["餐饮", "交通", "购物", "娱乐", "居家", "其他"]
    let accounts = ["现金", "支付宝", "微信", "信用卡", "储蓄卡"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ReceiptContentView(
                    eventTitle: $eventTitle,
                    amount: $amount,
                    selectedCategory: $selectedCategory,
                    selectedAccount: $selectedAccount,
                    date: $date,
                    note: $note,
                    selectedItem: $selectedItem,
                    selectedImageData: $selectedImageData,
                    categories: categories,
                    accounts: accounts
                )
            }
            .background(Color.gray.opacity(0.1))
            .navigationTitle("新建账单")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("保存") {
                        // TODO: 保存账单逻辑
                        dismiss()
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            }
        }
    }
}

// TextEditor占位符扩展
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    BillListView()
} 