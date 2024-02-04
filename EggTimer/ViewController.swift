//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation // For sound

class ViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel! // To have an access to the Label
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    // Dictionary for the times
    let eggTimes: [String: Int] = ["Soft": 10, "Medium": 20, "Hard": 30]

    var timer = Timer()

    var totalTime = 0
    var secondsPassed = 0
    
    // Variable for sound
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //Progress Bar
        //progressBar.progress = 1.0
        
        // Countdown
        timer.invalidate() // Every time we press a button we start the timer and start it over again
        let hardness = sender.currentTitle!
        
        // To restart the Progress Bar
        progressBar.progress = 0.0
        titleLabel.text = hardness
        secondsPassed = 0
        
        // ********* \\
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)

        } else if secondsPassed == totalTime {
            timer.invalidate()
            titleLabel.text = "Done!"
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
            // AAdding the sound when the eggs are done!
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
    }
    
    
}
