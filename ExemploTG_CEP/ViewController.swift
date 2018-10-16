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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.gameSideLabel.text = ""
        self.phoneSideLabel.text = ""
        self.gameStatusLabel.text = ""
    }
}

