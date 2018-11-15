//
//  InteractionEvent.swift
//  ExemploTG_CEP
//
//  Created by vinicius emanuel on 20/10/2018.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import Foundation
import CEPSwift

enum Side: String {
    case left = "⬅️"
    case right = "➡️"
    case down = "⬇️"
    case up = "⬆️"
    case straight = "⏹"
}

class SideEvent: Event {
    var timestamp: Date
    var data: Side
    
    init(data: Side) {
        self.data = data
        self.timestamp = Date()
    }
}
