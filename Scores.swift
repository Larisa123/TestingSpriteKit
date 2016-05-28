//
//  Scores.swift
//  MojaIgra1
//
//  Created by Lara Carli on 10/30/15.
//  Copyright © 2015 Larisa Carli. All rights reserved.
//

import Foundation
import SpriteKit

class Score {
    var scene: SKScene!
    var gameSceneDelegate: GameSceneDelegate!
    var score = 0
    
    init(scene: SKScene, gameSceneDelegate: GameSceneDelegate) {
        self.scene = scene
    }
    
    func updateScore(scoreLabel: SKLabelNode) {
        score += 1
        scoreLabel.text = "\(score)"
        let coin = SKAction.playSoundFileNamed("coin.wav", waitForCompletion: false)
        scene.runAction(coin)
    }
    
    func shareScore() {
        let urlString = "http://itunes.apple.com/app/idSJ3G8YWNAB?mt=8"
        let url = NSURL(string: urlString)
        
        let screenshot = gameSceneDelegate.screenshot()
        let initialTextString = "I scored \(score) points in Lara's first game!"
        gameSceneDelegate.shareString(initialTextString, url: url!, image: screenshot)
    }

    func bestScore() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey("bestScore")
    }
    
    func setBestScore(bestScore: Int) {
        NSUserDefaults.standardUserDefaults().setInteger(bestScore, forKey: "bestScore")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
