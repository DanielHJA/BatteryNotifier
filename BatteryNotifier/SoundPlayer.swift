//
//  SoundPlayer.swift
//  BatteryNotifier
//
//  Created by Daniel Hjärtström on 2019-12-04.
//  Copyright © 2019 Daniel Hjärtström. All rights reserved.
//

import Cocoa
import AVFoundation

class SoundPlayer {
    
    private var player: AVAudioPlayer!

    func playSound(url: URL) -> Void {
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
