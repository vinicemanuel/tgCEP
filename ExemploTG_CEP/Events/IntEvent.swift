//
//  IntEvent.swift
//  ExemploTG_CEP
//
//  Created by vinicius emanuel on 12/11/18.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import Foundation
import CEPSwift

class IntEvent: Event {
    var timestamp: Date
    var data: Int
    
    init(data: Int) {
        self.data = data
        self.timestamp = Date()
    }
}
