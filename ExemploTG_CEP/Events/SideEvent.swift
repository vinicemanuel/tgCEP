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
    case left = "Left"
    case right = "Right"
    case down = "Down"
    case up = "Up"
    case straight = "Straight"
}

class SideEvent: Event {
    var timestamp: Date
    var data: Side
    
    init(data: Side) {
        self.data = data
        self.timestamp = Date()
    }
}
