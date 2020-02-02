//
//  PlaySongViewController.swift
//  MusicPlayer2
//
//  Created by 李超逸 on 2020/02/02.
//  Copyright © 2020 李超逸. All rights reserved.
//

import UIKit

class PlaySongViewController: UIViewController {

    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    var isSliderDragging = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressSlider.setThumbImage(#imageLiteral(resourceName: "sliderThumb"), for: .normal)
        
        Player.main.prepareAndPlay()
        Player.main.play()
        Player.main.delegate = self
        
        durationLabel.text = Player.main.duration.minuteFormat
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        if Player.main.isPlaying {
            Player.main.pause()
            sender.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else {
            Player.main.play()
            sender.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
    }

    @IBAction func sliderValueChanged(_ sender: UISlider, forEvent event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                isSliderDragging = true
            case .ended:
                let progress = sender.value
                Player.main.setProgress(progress)
                isSliderDragging = false
            default:
                break
            }
        }
    }
    
}

extension PlaySongViewController: PlayerDelegate {
    func player(_ player: Player, onProgress progress: Float) {
        if !isSliderDragging {
            progressSlider.value = progress
        }
    }
    
    func player(_ player: Player, onTime currentTime: Int) {
        currentTimeLabel.text = currentTime.minuteFormat
    }
}

extension Int {
    var minuteFormat: String {
        let minute = self / 60
        let second = self % 60
        return String(format: "%d:%02d", minute, second)
    }
}

