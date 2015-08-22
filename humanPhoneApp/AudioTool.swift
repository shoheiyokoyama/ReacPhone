//
//  AudioTool.swift
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/08/18.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

import UIKit

class AudioTool: NSObject {
   
    class var sharedInstance: AudioTool {
        
        struct Static {
            static let instance: AudioTool = AudioTool()
        }
        return Static.instance
    }
    
    func playSoundFile(fileName: String) {
        
    }
    
    func speak(speakContent: String, rate: Float, pitchMultiplier: Float) {
        
    }
    
    func speakRandom(rate: Float, pitchMultiplier: Float) {
        
    }
}
