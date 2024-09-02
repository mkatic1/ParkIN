//
//  Item.swift
//  ParkIn
//
//  Created by Marta Katic MAC on 04.06.2024..
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
