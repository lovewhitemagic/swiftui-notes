//
//  Item.swift
//  swiftui-notes
//
//  Created by Hui Peng on 2025/3/10.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
