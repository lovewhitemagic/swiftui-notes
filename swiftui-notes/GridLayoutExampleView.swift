import SwiftUI

struct GridLayoutExampleView: View {
    // 网格布局配置
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    // 自适应列数的网格
    let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 16)
    ]
    
    // 固定列宽的网格
    let fixedColumns = [
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16)
    ]
    
    // 示例数据
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange]
    let numbers = Array(1...100)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // LazyVGrid 示例
                    Group {
                        Text("LazyVGrid - 灵活列宽")
                            .font(.headline)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(0..<12) { index in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(colors[index % colors.count])
                                    .frame(height: 100)
                                    .overlay(
                                        Text("\(index + 1)")
                                            .foregroundStyle(.white)
                                    )
                            }
                        }
                    }
                    
                    Divider()
                    
                    // 自适应列宽的 LazyVGrid
                    Group {
                        Text("LazyVGrid - 自适应列宽")
                            .font(.headline)
                        
                        LazyVGrid(columns: adaptiveColumns, spacing: 16) {
                            ForEach(0..<12) { index in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(colors[index % colors.count])
                                    .frame(height: 100)
                                    .overlay(
                                        Text("\(index + 1)")
                                            .foregroundStyle(.white)
                                    )
                            }
                        }
                    }
                    
                    Divider()
                    
                    // 固定列宽的 LazyVGrid
                    Group {
                        Text("LazyVGrid - 固定列宽")
                            .font(.headline)
                        
                        LazyVGrid(columns: fixedColumns, spacing: 16) {
                            ForEach(0..<8) { index in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(colors[index % colors.count])
                                    .frame(height: 100)
                                    .overlay(
                                        Text("\(index + 1)")
                                            .foregroundStyle(.white)
                                    )
                            }
                        }
                    }
                    
                    Divider()
                    
                    // LazyHGrid 示例
                    Group {
                        Text("LazyHGrid - 水平滚动")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.fixed(100))], spacing: 16) {
                                ForEach(0..<10) { index in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(colors[index % colors.count])
                                        .frame(width: 100)
                                        .overlay(
                                            Text("\(index + 1)")
                                                .foregroundStyle(.white)
                                        )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Divider()
                    
                    // LazyVStack 示例
                    Group {
                        Text("LazyVStack - 懒加载垂直列表")
                            .font(.headline)
                        
                        LazyVStack(spacing: 16) {
                            ForEach(numbers, id: \.self) { number in
                                HStack {
                                    Text("Item \(number)")
                                    Spacer()
                                    Text("Detail")
                                        .foregroundStyle(.secondary)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.gray.opacity(0.1))
                                )
                                .onAppear {
                                    print("Item \(number) appeared")
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    // LazyHStack 示例
                    Group {
                        Text("LazyHStack - 懒加载水平列表")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16) {
                                ForEach(0..<50) { index in
                                    VStack {
                                        Circle()
                                            .fill(colors[index % colors.count])
                                            .frame(width: 60, height: 60)
                                        Text("Item \(index + 1)")
                                            .font(.caption)
                                    }
                                    .onAppear {
                                        print("Horizontal item \(index + 1) appeared")
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("网格布局示例")
        }
    }
}

#Preview {
    GridLayoutExampleView()
} 