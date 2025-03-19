//
//  Constants.swift
//  swiftui-notes
//
//  Created by Hui Peng on 2025/3/19.
//
import SwiftUI // 导入 SwiftUI 框架

// 颜色扩展
extension Color {
    // MARK: - 颜色 - 主色调（强调色）
    static let clrPrimary = Color.accentColor // 主强调色（系统默认）
    static let clrPrimaryLight = Color.accentColor.opacity(0.7) // 主强调色浅色
    static let clrPrimaryDark = Color.accentColor.opacity(1.2) // 主强调色深色（饱和度增强）
    
    // MARK: - 颜色 - 背景（系统颜色）
    static let clrBackground = Color(.systemBackground) // 系统默认背景色
    static let clrBackgroundLight = Color(.systemGray6) // 系统浅灰背景
    static let clrBackgroundDark = Color(.systemGray) // 系统深灰背景
    static let clrSecondaryBackground = Color(.secondarySystemBackground) // 系统次要背景色
    
    // MARK: - 颜色 - 次要
    static let clrSecondary = Color(.systemGray2) // 系统次要灰色
    static let clrDivider = Color(.separator) // 系统分割线颜色
    
    // MARK: - 颜色 - 文本（系统颜色）
    static let clrText = Color(.label) // 系统默认文本色
    static let clrTextSecondary = Color(.secondaryLabel) // 系统次要文本色
    static let clrTextDisabled = Color(.tertiaryLabel) // 系统禁用文本色
}

// 材质扩展
extension Material {
    // MARK: - 材质
    static let matRegular = Material.regular // 常规材质
    static let matThin = Material.thin // 薄材质
    static let matThick = Material.thick // 厚材质
    static let matUltraThin = Material.ultraThin // 超薄材质
}

// CGFloat 扩展
extension CGFloat {
    // MARK: - 间距 - 基础
    static let spcSmall: CGFloat = 8 // 小间距
    static let spcMedium: CGFloat = 16 // 中间距
    static let spcLarge: CGFloat = 24 // 大间距
    static let spcExtraLarge: CGFloat = 32 // 超大间距
    
    // MARK: - 间距 - 特殊
    static let spcCard: CGFloat = 12 // 卡片内间距
    static let spcSection: CGFloat = 20 // 段落间距
    
    // MARK: - 圆角
    static let crnTiny: CGFloat = 4 // 微小圆角
    static let crnSmall: CGFloat = 8 // 小圆角
    static let crnStandard: CGFloat = 12 // 标准圆角
    static let crnLarge: CGFloat = 16 // 大圆角
    static let crnExtraLarge: CGFloat = 24 // 大圆角
    

    
    // MARK: - 尺寸 - 图标
    static let szIconSmall: CGFloat = 16 // 小图标尺寸
    static let szIcon: CGFloat = 24 // 标准图标尺寸
    static let szIconLarge: CGFloat = 32 // 大图标尺寸
    
    // MARK: - 尺寸 - 卡片
    static let szCardHeight: CGFloat = 60 // 卡片高度
    static let szCardWidth: CGFloat = 300 // 卡片宽度
    
    // MARK: - 尺寸 - 图片
    static let szImageTiny: CGFloat = 20 // 微小图片尺寸
    static let szImageSmall: CGFloat = 40 // 小图片尺寸
    static let szImageMedium: CGFloat = 60 // 中图片尺寸
}

// 字体扩展
extension Font {
    // MARK: - 字体 - 标题
    static let fntLargeTitle = Font.largeTitle // 大标题
    static let fntTitle = Font.headline // 标题
    static let fntSubTitle = Font.subheadline // 副标题
    
    // MARK: - 字体 - 正文
    static let fntBody = Font.body // 正文
    static let fntBodyBold = Font.body.bold() // 粗体正文
    static let fntCaption = Font.caption // 说明文字
    static let fntCaptionBold = Font.caption.bold() // 粗体说明文字
    
    // MARK: - 字体 - 自定义
    static let fntCustomSmall = Font.custom("Helvetica", size: 14) // 自定义小字体
    static let fntCustomLarge = Font.custom("Helvetica", size: 20) // 自定义大字体
}

