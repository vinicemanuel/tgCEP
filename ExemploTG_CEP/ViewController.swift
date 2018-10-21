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
    
    private var sequence: [String] = ["Left","Right","Left","Down","Left"]
    private var auxSequence: [String] = []
    
    let motion = CMMotionManager()
    var motionEvents = EventManager<MotionEvent>()
    var rule1: EventStream<MotionEvent>!
    var rule2: EventStream<MotionEvent>!
    
    var interactionEvent: EventManager<StringEvent>? = EventManager<StringEvent>()
    var sequenceEvent = EventManager<StringEvent>()
    
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.motion.deviceMotionUpdateInterval = 0.3
        self.motion.startDeviceMotionUpdates(to: .main) { [unowned self] (data, error) in
            guard error == nil else {return}
            guard let data = data else {return}
            self.motionEvents.addEvent(event: MotionEvent(data: data))
        }
        
        self.auxSequence = self.sequence
        self.configRules()
        self.runGame()
    }
    
    func configRules(){
        // merge retorna um ComplexEvent, mas o ComplexEvent não extenra um valor pra mim
        self.rule1 = self.motionEvents.asStream().filter { (deviceMotion) -> Bool in
            if ((deviceMotion.data.gravity.x <= self.tiltLimitInf || deviceMotion.data.gravity.x >= self.tiltLimitSup) &&
                (deviceMotion.data.gravity.y > self.tiltLimitInf && deviceMotion.data.gravity.y < self.tiltLimitSup)){
                return true
            }else{
                return false
            }
        }
        
        self.rule2 = self.motionEvents.asStream().filter(predicate: { (deviceMotion) -> Bool in
            if((deviceMotion.data.gravity.y <= self.tiltLimitInf || deviceMotion.data.gravity.y >= self.tiltLimitSup) &&
                (deviceMotion.data.gravity.x > self.tiltLimitInf && deviceMotion.data.gravity.x < self.tiltLimitSup)){
                    return true
            }else{
                return false
            }
        })
        
        //        self.motionEvents.asStream()
        //            .subscribe { [unowned self] (deviceMotion) in
        //                let x = deviceMotion.data.gravity.x
        //                let y = deviceMotion.data.gravity.y
        //                self.labelX.text = String(format: "%.1f", x)
        //                self.labelY.text = String(format: "%.1f", y)
        //        }
        
        self.motionEvents.asStream()
            .filter(predicate: { [unowned self] (deviceMotion) -> Bool in
                
                let x = deviceMotion.data.gravity.x
                let y = deviceMotion.data.gravity.y
                self.labelX.text = String(format: "%.1f", x)
                self.labelY.text = String(format: "%.1f", y)
                
                if ((deviceMotion.data.gravity.x <= self.tiltLimitInf || deviceMotion.data.gravity.x >= self.tiltLimitSup) &&
                    (deviceMotion.data.gravity.y > self.tiltLimitInf && deviceMotion.data.gravity.y < self.tiltLimitSup)){
                    return true
                }
                else if((deviceMotion.data.gravity.y <= self.tiltLimitInf || deviceMotion.data.gravity.y >= self.tiltLimitSup) &&
                    (deviceMotion.data.gravity.x > self.tiltLimitInf && deviceMotion.data.gravity.x < self.tiltLimitSup)){
                    return true
                }else{
                    return false
                }
            })
            .map(transform: { (deviceMotion) -> String in
                if deviceMotion.data.gravity.x < self.tiltLimitInf{
                    return "Left"
                }else if deviceMotion.data.gravity.x > self.tiltLimitSup{
                    return "Right"
                }else if deviceMotion.data.gravity.y > self.tiltLimitSup{
                    return "Up"
                }else if deviceMotion.data.gravity.y < self.tiltLimitInf{
                    return "Down"
                }
                return "straight"
            })
            .subscribe { [unowned self] (result) in
                self.interactionEvent?.addEvent(event: StringEvent(data: result))
        }
    }
    
    func startUserInteraction(){
        self.interactionEvent?.asStream()
            .followedBy(predicate: { (fst, scd) -> Bool in
                if fst.data != scd.data{
                    return true
                }else{
                    return false
                }
            })
            .map { (result) -> String in
                return result.1.data
            }.subscribe { [unowned self] (result) in
                print(result)
                self.phoneSideLabel.text = result

                if self.auxSequence.count == 0 && self.gameStatusLabel.text == ""{
                    self.gameStatusLabel.text = "Ganhou!!"
                }else if self.auxSequence.count != 0{
                    let value = self.auxSequence.removeFirst()
                    if value != result{
                        self.gameStatusLabel.text = "Pereu!"
                        self.interactionEvent = nil
                    }
                }
        }
        
        //para o followedBy já rodar com a primeira interação
        self.interactionEvent?.addEvent(event: StringEvent(data: ""))
    }
    
    func runGame(){
        self.sequenceEvent.asStream()
            .subscribe { [unowned self] (event) in
                self.gameSideLabel.text = event.data
        }
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] _ in
            if self.auxSequence.count > 0{
                let value = self.auxSequence.removeFirst()
                self.sequenceEvent.addEvent(event: StringEvent(data: value))
            }else{
                self.auxSequence = self.sequence
                self.timer.invalidate()
                self.startUserInteraction()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.gameSideLabel.text = ""
        self.phoneSideLabel.text = ""
        self.gameStatusLabel.text = ""
    }
}

