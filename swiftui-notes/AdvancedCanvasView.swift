import SwiftUI

struct AdvancedCanvasView: View {
    @State private var lines: [Line] = []
    @State private var shapes: [Shape] = []
    @State private var selectedColor: Color = .blue
    @State private var lineWidth: CGFloat = 3
    @State private var drawingMode: DrawingMode = .pen
    @State private var selectedShape: ShapeType = .rectangle
    @State private var startPoint: CGPoint?
    @State private var isDrawing = false
    
    let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange]
    
    var body: some View {
        NavigationStack {
            VStack {
                // 绘图区域
                Canvas { context, size in
                    // 绘制网格背景
                    drawGrid(context: context, size: size)
                    
                    // 绘制所有线条
                    for line in lines {
                        var path = Path()
                        path.addLines(line.points)
                        
                        context.stroke(
                            path,
                            with: .color(line.color),
                            style: StrokeStyle(
                                lineWidth: line.width,
                                lineCap: .round,
                                lineJoin: .round,
                                dash: line.isDashed ? [10, 5] : []
                            )
                        )
                    }
                    
                    // 绘制所有形状
                    for shape in shapes {
                        switch shape.type {
                        case .rectangle:
                            let rect = Path(roundedRect: shape.rect, cornerRadius: 5)
                            if shape.isFilled {
                                context.fill(rect, with: .color(shape.color.opacity(0.3)))
                            }
                            context.stroke(rect, with: .color(shape.color), lineWidth: shape.width)
                            
                        case .circle:
                            let circle = Path(ellipseIn: shape.rect)
                            if shape.isFilled {
                                context.fill(circle, with: .color(shape.color.opacity(0.3)))
                            }
                            context.stroke(circle, with: .color(shape.color), lineWidth: shape.width)
                            
                        case .arrow:
                            drawArrow(context: context, start: shape.rect.origin, end: CGPoint(x: shape.rect.maxX, y: shape.rect.maxY), color: shape.color, width: shape.width)
                        }
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let position = value.location
                            
                            if !isDrawing {
                                isDrawing = true
                                startPoint = position
                                
                                if drawingMode == .pen {
                                    lines.append(Line(
                                        points: [position],
                                        color: selectedColor,
                                        width: lineWidth,
                                        isDashed: false
                                    ))
                                }
                            } else {
                                if drawingMode == .pen {
                                    guard let lastIdx = lines.indices.last else { return }
                                    lines[lastIdx].points.append(position)
                                } else if let start = startPoint {
                                    // 更新或创建形状
                                    let rect = CGRect(
                                        x: min(start.x, position.x),
                                        y: min(start.y, position.y),
                                        width: abs(position.x - start.x),
                                        height: abs(position.y - start.y)
                                    )
                                    
                                    if shapes.isEmpty || shapes.last?.isComplete == true {
                                        shapes.append(Shape(
                                            type: selectedShape,
                                            rect: rect,
                                            color: selectedColor,
                                            width: lineWidth,
                                            isFilled: drawingMode == .filledShape
                                        ))
                                    } else {
                                        shapes[shapes.count - 1].rect = rect
                                    }
                                }
                            }
                        }
                        .onEnded { _ in
                            isDrawing = false
                            if let lastShape = shapes.last {
                                var shape = lastShape
                                shape.isComplete = true
                                shapes[shapes.count - 1] = shape
                            }
                        }
                )
                .background(Color.white)
                .cornerRadius(15)
                .padding()
                
                // 主要工具栏
                HStack(spacing: 30) {
                    // 画笔工具
                    Button {
                        drawingMode = .pen
                    } label: {
                        VStack {
                            Image(systemName: "pencil")
                            Text("画笔")
                                .font(.caption)
                        }
                        .foregroundStyle(drawingMode == .pen ? .blue : .gray)
                    }
                    
                    // 形状工具
                    Button {
                        drawingMode = .shape
                    } label: {
                        VStack {
                            Image(systemName: "square")
                            Text("形状")
                                .font(.caption)
                        }
                        .foregroundStyle(drawingMode == .shape ? .blue : .gray)
                    }
                    
                    // 填充形状
                    Button {
                        drawingMode = .filledShape
                    } label: {
                        VStack {
                            Image(systemName: "square.fill")
                            Text("填充")
                                .font(.caption)
                        }
                        .foregroundStyle(drawingMode == .filledShape ? .blue : .gray)
                    }
                    
                    // 虚线工具
                    Button {
                        drawingMode = .dashedLine
                    } label: {
                        VStack {
                            Image(systemName: "line.3.horizontal")
                            Text("虚线")
                                .font(.caption)
                        }
                        .foregroundStyle(drawingMode == .dashedLine ? .blue : .gray)
                    }
                }
                .padding(.horizontal)
                
                // 形状选择器 (当选择形状模式时显示)
                if drawingMode == .shape || drawingMode == .filledShape {
                    HStack(spacing: 30) {
                        Button {
                            selectedShape = .rectangle
                        } label: {
                            VStack {
                                Image(systemName: "square")
                                Text("矩形")
                                    .font(.caption)
                            }
                            .foregroundStyle(selectedShape == .rectangle ? .blue : .gray)
                        }
                        
                        Button {
                            selectedShape = .circle
                        } label: {
                            VStack {
                                Image(systemName: "circle")
                                Text("圆形")
                                    .font(.caption)
                            }
                            .foregroundStyle(selectedShape == .circle ? .blue : .gray)
                        }
                        
                        Button {
                            selectedShape = .arrow
                        } label: {
                            VStack {
                                Image(systemName: "arrow.right")
                                Text("箭头")
                                    .font(.caption)
                            }
                            .foregroundStyle(selectedShape == .arrow ? .blue : .gray)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // 颜色选择器
                HStack(spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .stroke(color == selectedColor ? .blue : .clear, lineWidth: 3)
                            )
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                }
                
                // 线宽调节
                HStack {
                    Image(systemName: "minus")
                    Slider(value: $lineWidth, in: 1...10)
                    Image(systemName: "plus")
                }
                .padding(.horizontal)
                
                // 底部工具栏
                HStack(spacing: 30) {
                    Button {
                        lines.removeAll()
                        shapes.removeAll()
                    } label: {
                        VStack {
                            Image(systemName: "trash")
                            Text("清除")
                                .font(.caption)
                        }
                    }
                    
                    Button {
                        if !lines.isEmpty {
                            lines.removeLast()
                        } else if !shapes.isEmpty {
                            shapes.removeLast()
                        }
                    } label: {
                        VStack {
                            Image(systemName: "arrow.uturn.backward")
                            Text("撤销")
                                .font(.caption)
                        }
                    }
                    
                    Button {
                        let renderer = ImageRenderer(content: CanvasView(lines: lines, shapes: shapes))
                        if let image = renderer.uiImage {
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        }
                    } label: {
                        VStack {
                            Image(systemName: "square.and.arrow.down")
                            Text("保存")
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("画板")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // 绘制网格
    private func drawGrid(context: GraphicsContext, size: CGSize) {
        let gridSize: CGFloat = 20
        var path = Path()
        
        for x in stride(from: 0, through: size.width, by: gridSize) {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: size.height))
        }
        
        for y in stride(from: 0, through: size.height, by: gridSize) {
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: size.width, y: y))
        }
        
        context.stroke(path, with: .color(.gray.opacity(0.2)), lineWidth: 0.5)
    }
    
    // 绘制箭头
    private func drawArrow(context: GraphicsContext, start: CGPoint, end: CGPoint, color: Color, width: CGFloat) {
        let arrowLength: CGFloat = 20
        let arrowAngle: CGFloat = .pi / 6
        
        let dx = end.x - start.x
        let dy = end.y - start.y
        let angle = atan2(dy, dx)
        
        var path = Path()
        path.move(to: start)
        path.addLine(to: end)
        
        path.move(to: end)
        path.addLine(to: CGPoint(
            x: end.x - arrowLength * cos(angle + arrowAngle),
            y: end.y - arrowLength * sin(angle + arrowAngle)
        ))
        
        path.move(to: end)
        path.addLine(to: CGPoint(
            x: end.x - arrowLength * cos(angle - arrowAngle),
            y: end.y - arrowLength * sin(angle - arrowAngle)
        ))
        
        context.stroke(path, with: .color(color), lineWidth: width)
    }
}

// 线条模型
struct Line {
    var points: [CGPoint]
    var color: Color
    var width: CGFloat
    var isDashed: Bool
}

// 形状模型
struct Shape {
    var type: ShapeType
    var rect: CGRect
    var color: Color
    var width: CGFloat
    var isFilled: Bool
    var isComplete: Bool = false
}

// 形状类型
enum ShapeType {
    case rectangle
    case circle
    case arrow
}

// 绘图模式
enum DrawingMode: CaseIterable {
    case pen
    case shape
    case filledShape
    case dashedLine
    
    var title: String {
        switch self {
        case .pen: return "画笔"
        case .shape: return "形状"
        case .filledShape: return "填充形状"
        case .dashedLine: return "虚线"
        }
    }
    
    var iconName: String {
        switch self {
        case .pen: return "pencil"
        case .shape: return "square"
        case .filledShape: return "square.fill"
        case .dashedLine: return "line.3.horizontal"
        }
    }
}

// 用于渲染的 Canvas 视图
struct CanvasView: View {
    let lines: [Line]
    let shapes: [Shape]
    
    var body: some View {
        Canvas { context, size in
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                context.stroke(path, with: .color(line.color), lineWidth: line.width)
            }
            
            for shape in shapes {
                switch shape.type {
                case .rectangle:
                    let rect = Path(roundedRect: shape.rect, cornerRadius: 5)
                    if shape.isFilled {
                        context.fill(rect, with: .color(shape.color.opacity(0.3)))
                    }
                    context.stroke(rect, with: .color(shape.color), lineWidth: shape.width)
                case .circle:
                    let circle = Path(ellipseIn: shape.rect)
                    if shape.isFilled {
                        context.fill(circle, with: .color(shape.color.opacity(0.3)))
                    }
                    context.stroke(circle, with: .color(shape.color), lineWidth: shape.width)
                case .arrow:
                    // 箭头绘制逻辑
                    break
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40)
        .background(Color.white)
    }
}

#Preview {
    AdvancedCanvasView()
} 