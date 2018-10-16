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
    @IBOutlet weak var phoneSideLabel: UILabel!
    @IBOutlet weak var gameSideLabel: UILabel!
    @IBOutlet weak var gameStatusLabel: UILabel!
    
    private let tiltLimitSup = 0.4
    private let tiltLimitInf = -0.4
    
    private var sequence: [String] = ["Left","Right","Left","Dwon","Left"]
    
    let motion = CMMotionManager()
    var motionEvents = EventManager<MotionEvent>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.motion.deviceMotionUpdateInterval = 0.3
        self.motion.startDeviceMotionUpdates(to: .main) { [unowned self] (data, error) in
            guard error == nil else {return}
            guard let data = data else {return}
            self.motionEvents.addEvent(event: MotionEvent(data: data))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.gameSideLabel.text = ""
        self.phoneSideLabel.text = ""
        self.gameStatusLabel.text = ""
    }
}

