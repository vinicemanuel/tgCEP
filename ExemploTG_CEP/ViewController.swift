//
//  ViewController.swift
//  ExemploTG_CEP
//
//  Created by vinicius emanuel on 16/10/2018.
//  Copyright © 2018 vinicius emanuel. All rights reserved.
//

import UIKit
import CEPSwift
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var labelX: UILabel!
    @IBOutlet weak var labelY: UILabel!
    @IBOutlet weak var sideLabel: UILabel!
        
    private let manager = CMMotionManager()
    
    var sideEventManager = EventManager<SideEvent>()
    var motionEventManager = EventManager<MotionEvent>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideLabel.text = Side.straight.rawValue
        
        if self.manager.isDeviceMotionAvailable{
            self.manager.deviceMotionUpdateInterval = 0.3
            self.configPublish()
            self.configsubscribe()
        }
    }
    
    func configPublish(){
        self.manager.startDeviceMotionUpdates(to: OperationQueue.current ?? OperationQueue.main) { (motion, error) in
            if let motion = motion{
                let point = (motion.gravity.x, motion.gravity.y)
                self.labelX.text = String(format: "%.1f",motion.gravity.x)
                self.labelY.text = String(format: "%.1f",motion.gravity.y)
                self.motionEventManager.addEvent(event: MotionEvent(data: point))
            }
        }
    }
    
    func configsubscribe(){
        self.motionEventManager.asStream()
            .subscribe { (motionEvent) in
                let point = motionEvent.data
                print(point)
        }
    }
}

