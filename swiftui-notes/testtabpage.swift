//
//  testtabpage.swift
//  swiftui-notes
//
//  Created by Hui Peng on 2025/3/16.
//
import SwiftUI
import PagerTabStripView

struct MyFirstView: View {
    var body: some View {
        List {
            ForEach(1...5, id: \.self) { number in
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("First View Item \(number)")
                }
            }
        }
        .navigationTitle("First Tab")
    }
}

struct MySecondView: View {
    var body: some View {
        List {
            ForEach(["Apple", "Banana", "Orange", "Grape", "Mango"], id: \.self) { fruit in
                HStack {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.green)
                    Text(fruit)
                }
            }
        }
        .navigationTitle("Second Tab")
    }
}

struct MyProfileView: View {
    var body: some View {
        List {
            Section(header: Text("个人信息")) {
                HStack {
                    Image(systemName: "person.circle.fill")
                    Text("用户名: John Doe")
                }
                HStack {
                    Image(systemName: "envelope.fill")
                    Text("邮箱: john@example.com")
                }
                HStack {
                    Image(systemName: "phone.fill")
                    Text("电话: +1 234 567 890")
                }
            }
            
            Section(header: Text("设置")) {
                HStack {
                    Image(systemName: "gear")
                    Text("账户设置")
                }
                HStack {
                    Image(systemName: "bell")
                    Text("通知")
                }
            }
        }
        .navigationTitle("个人资料")
    }
}

struct TitleNavBarItem: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
    }
}

class User {
    static var isLoggedIn: Bool = true  // 为了测试设置为 true
}

struct MyPagerView: View {
    @State private var selection: Int = 1
    
    var body: some View {
        PagerTabStripView(
            edgeSwipeGestureDisabled: .constant(
                selection == 1 ? [.left] :  // 第一页禁用左滑
                selection == 3 ? [.right] : // 最后一页禁用右滑
                []                         // 中间页面不禁用
            ),
            selection: $selection
        ) {
            MyFirstView()
                .pagerTabItem(tag: 1) {
                    TitleNavBarItem(title: "Tab 1")
                }
            MySecondView()
                .pagerTabItem(tag: 2) {
                    TitleNavBarItem(title: "Tab 2")
                }
            if User.isLoggedIn {
                MyProfileView()
                    .pagerTabItem(tag: 3) {
                        TitleNavBarItem(title: "Profile")
                    }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .pagerTabStripViewStyle(.barButton(tabItemSpacing: 15, 
					   tabItemHeight: 50, 
	    			           indicatorView: {
            				   	Rectangle().fill(.gray).cornerRadius(5)
            				   }))
    }

}


#Preview {
    MyPagerView()
}
