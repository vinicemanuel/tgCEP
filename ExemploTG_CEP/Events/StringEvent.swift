//
//  InteractionEvent.swift
//  ExemploTG_CEP
//
//  Created by vinicius emanuel on 20/10/2018.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import Foundation
import CEPSwift

class StringEvent: Event {
    var timestamp: Date
    var data: String
    
    init(data: String) {
        self.data = data
        self.timestamp = Date()
    }
}
