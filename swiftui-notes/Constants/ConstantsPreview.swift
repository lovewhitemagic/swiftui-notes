import SwiftUI // 导入 SwiftUI 框架

struct ConstantsPreview: View {
    var body: some View {
        TabView {
            // 颜色预览
            ColorsPreview()
                .tabItem {
                    Label("颜色", systemImage: "paintpalette")
                }
            
            // 间距预览
            SpacingPreview()
                .tabItem {
                    Label("间距", systemImage: "arrow.left.and.right")
                }
            
            // 字体预览
            FontsPreview()
                .tabItem {
                    Label("字体", systemImage: "textformat")
                }
            
            // 圆角预览
            CornerRadiusPreview()
                .tabItem {
                    Label("圆角", systemImage: "rectangle.roundedtop")
                }
            
            // 尺寸预览
            SizesPreview()
                .tabItem {
                    Label("尺寸", systemImage: "ruler")
                }
            
            // 材质预览
            MaterialsPreview()
                .tabItem {
                    Label("材质", systemImage: "square.stack.3d.up")
                }
        }
       // .preferredColorScheme(.light) // 默认浅色模式，可切换测试深色
    }
}

// MARK: - 颜色预览
struct ColorsPreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .spcMedium) {
                ColorItem(name: "clrPrimary 主强调色", color: .clrPrimary)
                ColorItem(name: "clrPrimaryLight 主强调色浅色", color: .clrPrimaryLight)
                ColorItem(name: "clrPrimaryDark 主强调色深色", color: .clrPrimaryDark)
                ColorItem(name: "clrBackground 系统默认背景色", color: .clrBackground)
                ColorItem(name: "clrBackgroundLight 系统浅灰背景", color: .clrBackgroundLight)
                ColorItem(name: "clrBackgroundDark 系统深灰背景", color: .clrBackgroundDark)
                ColorItem(name: "clrSecondaryBackground 系统次要背景色", color: .clrSecondaryBackground)
                ColorItem(name: "clrSecondary 系统次要灰色", color: .clrSecondary)
                ColorItem(name: "clrDivider 系统分割线颜色", color: .clrDivider)
                ColorItem(name: "clrText 系统默认文本色", color: .clrText)
                ColorItem(name: "clrTextSecondary 系统次要文本色", color: .clrTextSecondary)
                ColorItem(name: "clrTextDisabled 系统禁用文本色", color: .clrTextDisabled)
            }
            .padding(.spcMedium)
        }
    }
}

// MARK: - 间距预览
struct SpacingPreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .spcMedium) {
                SpacingItem(name: "spcSmall 小间距", value: .spcSmall)
                SpacingItem(name: "spcMedium 中间距", value: .spcMedium)
                SpacingItem(name: "spcLarge 大间距", value: .spcLarge)
                SpacingItem(name: "spcExtraLarge 超大间距", value: .spcExtraLarge)
                SpacingItem(name: "spcCard 卡片内间距", value: .spcCard)
                SpacingItem(name: "spcSection 段落间距", value: .spcSection)
            }
            .padding(.spcMedium)
        }
    }
}

// MARK: - 字体预览
struct FontsPreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .spcMedium) {
                FontItem(name: "fntLargeTitle 大标题", font: .fntLargeTitle)
                FontItem(name: "fntTitle 标题", font: .fntTitle)
                FontItem(name: "fntSubTitle 副标题", font: .fntSubTitle)
                FontItem(name: "fntBody 正文", font: .fntBody)
                FontItem(name: "fntBodyBold 粗体正文", font: .fntBodyBold)
                FontItem(name: "fntCaption 说明文字", font: .fntCaption)
                FontItem(name: "fntCaptionBold 粗体说明文字", font: .fntCaptionBold)
                FontItem(name: "fntCustomSmall 自定义小字体", font: .fntCustomSmall)
                FontItem(name: "fntCustomLarge 自定义大字体", font: .fntCustomLarge)
            }
            .padding(.spcMedium)
        }
    }
}

// MARK: - 圆角预览
struct CornerRadiusPreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .spcMedium) {
                CornerItem(name: "crnTiny 微小圆角", radius: .crnTiny)
                CornerItem(name: "crnSmall 小圆角", radius: .crnSmall)
                CornerItem(name: "crnStandard 标准圆角", radius: .crnStandard)
                CornerItem(name: "crnLarge 大圆角", radius: .crnLarge)
                CornerItem(name: "crnExtraLarge 超大圆角", radius: .crnExtraLarge)
                
            }
            .padding(.spcMedium)
        }
    }
}

// MARK: - 尺寸预览
struct SizesPreview: View {
    var body: some View {
        ScrollView {
            VStack(spacing: .spcMedium) {
                SizeItem(name: "szIconSmall 小图标尺寸", size: .szIconSmall)
                SizeItem(name: "szIcon 标准图标尺寸", size: .szIcon)
                SizeItem(name: "szIconLarge 大图标尺寸", size: .szIconLarge)
                SizeItem(name: "szCardHeight 卡片高度", size: .szCardHeight)
                SizeItem(name: "szCardWidth 卡片宽度", size: .szCardWidth)
                SizeItem(name: "szImageTiny 微小图片尺寸", size: .szImageTiny)
                SizeItem(name: "szImageSmall 小图片尺寸", size: .szImageSmall)
                SizeItem(name: "szImageMedium 中图片尺寸", size: .szImageMedium)
            }
            .padding(.spcMedium)
        }
    }
}

// MARK: - 材质预览
struct MaterialsPreview: View {
    var body: some View {
        ZStack {
            // 添加整个视图的背景
            LinearGradient(
                gradient: Gradient(colors: [.red, .blue, .green, .yellow]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea() // 确保背景覆盖整个区域
            
            ScrollView {
                VStack(spacing: .spcMedium) {
                    MaterialItem(name: "matRegular 常规材质", material: .matRegular)
                    MaterialItem(name: "matThin 薄材质", material: .matThin)
                    MaterialItem(name: "matThick 厚材质", material: .matThick)
                    MaterialItem(name: "matUltraThin 超薄材质", material: .matUltraThin)
                }
                .padding(.spcMedium)
            }
        }
    }
}

// MARK: - 辅助视图
struct ColorItem: View {
    let name: String
    let color: Color
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(color)
                .frame(width: 50, height: 50)
                .cornerRadius(.crnSmall)
            Text(name)
                .font(.fntBody)
            Spacer()
        }
    }
}

struct SpacingItem: View {
    let name: String
    let value: CGFloat
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(Color.clrPrimary)
                .frame(width: value, height: 20)
            Text("\(name) (\(Int(value)))")
                .font(.fntBody)
            Spacer()
        }
    }
}

struct FontItem: View {
    let name: String
    let font: Font
    var body: some View {
        HStack {
            Text(name)
                .font(font)
            Spacer()
        }
    }
}

struct CornerItem: View {
    let name: String
    let radius: CGFloat
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(Color.clrPrimary)
                .frame(width: 100, height: 50)
                .cornerRadius(radius)
            Text("\(name) (\(Int(radius)))")
                .font(.fntBody)
            Spacer()
        }
    }
}

struct SizeItem: View {
    let name: String
    let size: CGFloat
    var body: some View {
        HStack {
            Image(systemName: "square")
                .resizable()
                .frame(width: size, height: size)
                .foregroundStyle(Color.clrPrimary)
            Text("\(name) (\(Int(size)))")
                .font(.fntBody)
            Spacer()
        }
    }
}

struct MaterialItem: View {
    let name: String
    let material: Material
    var body: some View {
        HStack {
            Rectangle()
                .background(material) // 仅应用材质，无独立背景
                .frame(width: 200, height: 150)
                .cornerRadius(.crnSmall)
            Text(name)
                .font(.fntBody)
            Spacer()
        }
    }
}

// 预览
struct ConstantsPreview_Previews: PreviewProvider {
    static var previews: some View {
        ConstantsPreview()
            .preferredColorScheme(.light)
        ConstantsPreview()
            .preferredColorScheme(.dark)
    }
}
