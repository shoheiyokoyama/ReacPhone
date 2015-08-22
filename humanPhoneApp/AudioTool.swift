//
//  AudioTool.swift
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/08/18.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

import UIKit
import AVFoundation

class AudioTool: NSObject, AVAudioPlayerDelegate {
   
    var soundArray: NSMutableArray
    var filterController: OEFliteController
    var slt: Slt
    
    
    class var sharedInstance: AudioTool {
        
        struct Static {
            static let instance: AudioTool = AudioTool()
        }
        return Static.instance
    }
    
    override init () {
        soundArray = NSMutableArray()
        filterController = OEFliteController()
        slt = Slt()
        super.init()
    }
    
    func playSoundFile(fileName: String) {
        var soundPath: String = NSBundle.mainBundle().bundlePath.stringByAppendingPathComponent(fileName)
        var urlOfSound: NSURL = NSURL(fileURLWithPath: soundPath)!
        
        var player: AVAudioPlayer = AVAudioPlayer(contentsOfURL: urlOfSound, error: nil)!
        player.numberOfLoops = 0
        player.delegate = self
        soundArray.insertObject(player, atIndex: 0)
        player.prepareToPlay()
        player.play()
    }
    
    func playEnglishSound(speakContent: String) {
        filterController.say(speakContent, withVoice: slt)
    }
    
    func speak(speakContent: String, rate: Float, pitchMultiplier: Float) {
        var speechSynthesizer = AVSpeechSynthesizer()
        var speakingText = speakContent
        var utterance: AVSpeechUtterance = AVSpeechUtterance(string: speakContent)
        utterance.rate = rate
        utterance.pitchMultiplier = pitchMultiplier
        utterance.volume = 0.5
        speechSynthesizer.speakUtterance(utterance)
    }
    
    func speakRandom(rate: Float, pitchMultiplier: Float) {
        var speechSynthesizer = AVSpeechSynthesizer()
        var array: NSArray = NSArray(array: ["お!", "なんだよ", "なんだし", "なんだね", "よ", "暇なの?", "何ですか?", "はい!", "ご用は何ですか？"])
        var randomNumber = random() % array.count
        var speakContent: String = array.objectAtIndex(randomNumber) as! String
        var utterance: AVSpeechUtterance = AVSpeechUtterance(string: speakContent)
        utterance.rate = rate
        utterance.pitchMultiplier = pitchMultiplier
        utterance.volume = 0.5
        speechSynthesizer.speakUtterance(utterance)
    }
}
