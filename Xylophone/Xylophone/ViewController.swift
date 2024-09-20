//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: UIButton) { 
        print("Start")
        
        sender.layer.opacity*=0.5
        playSound(buttonString:sender.titleLabel?.text)
        sender.layer.opacity*=2
        sleep(2)
        print("End")
    }
    
    func playSound(buttonString:String?) {
        let url = Bundle.main.url(forResource: buttonString , withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
}


