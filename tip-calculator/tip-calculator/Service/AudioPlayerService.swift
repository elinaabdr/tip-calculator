//
//  AudioPlayerService.swift
//  tip-calculator
//
//  Created by Элина Абдрахманова on 20.07.2023.
//

<<<<<<< Updated upstream
import UIKit
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    
    private var player: AVAudioPlayer?
    
    func playSound() {
        let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
=======
import Foundation
import AVFoundation

protocol AudioPlayerService {
  func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
  
  private var player: AVAudioPlayer?
  
  func playSound() {
    let path = Bundle.main.path(forResource: "click", ofType: "m4a")!
    let url = URL(fileURLWithPath: path)
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.play()
    } catch(let error) {
      print(error.localizedDescription)
    }
  }
>>>>>>> Stashed changes
}
