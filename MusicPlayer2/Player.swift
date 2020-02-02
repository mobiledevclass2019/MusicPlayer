//
//  Player.swift
//  MusicPlayer
//
//  Created by 李超逸 on 2018/03/24.
//  Copyright © 2018 ebuser. All rights reserved.
//

import AVFoundation

class Player {
    
    var delegate: PlayerDelegate?
    
    private var player: AVAudioPlayer?
    private var timer: Timer!
    
    static let main: Player = {
        let sharedInstance = Player()
        sharedInstance.timer =
            Timer.scheduledTimer(timeInterval: 0.1,
                                 target: sharedInstance,
                                 selector: #selector(timerFired),
                                 userInfo: true,
                                 repeats: true)
        return sharedInstance
    }()
    
    func prepareAndPlay() {
        do {
            let url = URL(fileURLWithPath: Bundle.main.path(forResource: "Godknows", ofType: "flac")!)
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        } catch let error {
            print(error)
        }
    }
    
    var duration: Int {
        guard let player = player else { return 0 }
        return lround(player.duration)
    }
    
    var isPlaying: Bool {
        guard let player = player else { return false }
        return player.isPlaying
    }
    
    func setProgress(_ progress: Float) {
        guard let player = player else { return }
        player.currentTime = player.duration * Double(progress)
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    @objc
    private func timerFired() {
        if let player = player {
            let progress = Float(player.currentTime / player.duration)
            delegate?.player(self, onProgress: progress)
            delegate?.player(self, onTime: lround(player.currentTime))
        }
    }
}

protocol PlayerDelegate {
    func player(_ player: Player, onProgress progress: Float)
    func player(_ player: Player, onTime currentTime: Int)
}
