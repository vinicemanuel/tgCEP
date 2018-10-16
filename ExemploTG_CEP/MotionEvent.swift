//
//  MotionEvent.swift
//  ExemploTG_CEP
//
//  Created by vinicius emanuel on 16/10/2018.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import Foundation
import CEPSwift
import CoreMotion

class MotionEvent: Event {
    var timestamp: Date
    var data: CMDeviceMotion
    
    init(data: CMDeviceMotion) {
        self.data = data
        self.timestamp = Date()
    }
}
