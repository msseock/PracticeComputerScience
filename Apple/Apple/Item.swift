//
//  Item.swift
//  Apple
//
//  Created by 석민솔 on 9/11/25.
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
