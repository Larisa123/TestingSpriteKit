//
//  Setup.swift
//  MojaIgra1
//
//  Created by Lara Carli on 10/25/15.
//  Copyright © 2015 Larisa Carli. All rights reserved.
//

import Foundation
import SpriteKit

class Setup {
    var scene: SKScene!
    
    init(scene: SKScene){
        self.scene = scene
    }
    
    func setupBackground(bg1: SKSpriteNode, bg2: SKSpriteNode) {
        bg1.anchorPoint = CGPointZero
        bg1.position = CGPointMake(0, 0)
        bg1.size = CGSize(width: scene.size.width, height: scene.size.height)
        scene.addChild(bg1)
        
        bg2.anchorPoint = CGPointZero
        bg2.position = CGPointMake(0, bg1.size.height + 1)
        bg2.size = CGSize(width: scene.size.width, height: scene.size.height)
        scene.addChild(bg2)
    }
    
    func setupMainMenu(logo: SKSpriteNode) -> GameState {
        logo.position = CGPointMake(scene.size.width/2, scene.size.height*0.8)
        logo.zPosition = Layer.Label.rawValue
        scene.addChild(logo)
        
        let pop = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
        let wait = SKAction.waitForDuration(0.1)
        let popAction = SKAction.scaleBy(1.5, duration: 0.15)
        let backPopAction = SKAction.scaleBy(0.75, duration: 0.1)
        let action = SKAction.sequence([wait, popAction, pop, backPopAction])
        logo.runAction(action)
        
        let playButton = SKSpriteNode(imageNamed: "Button")
        playButton.position = CGPointMake(scene.size.width*0.5, -scene.size.height/2)
        playButton.zPosition = Layer.Label.rawValue
        playButton.size = CGSizeMake(playButton.size.width*2, playButton.size.height*1.7)
        scene.addChild(playButton)
        
        let play = SKSpriteNode(imageNamed: "Play")
        play.position = CGPointMake(scene.size.width*0.5, -scene.size.height/2)
        play.zPosition = Layer.Label2.rawValue
        play.size = CGSizeMake(play.size.width*1.8, play.size.height*1.5)
        scene.addChild(play)
        
        let moveTo = SKAction.moveTo(CGPointMake(scene.size.width/2, scene.size.height/2), duration: 0.5)
        moveTo.timingMode = .EaseInEaseOut
        playButton.runAction(SKAction.sequence([SKAction.waitForDuration(0.3), moveTo, popAction, pop, backPopAction]))
        play.runAction(SKAction.sequence([SKAction.waitForDuration(0.5), moveTo, popAction, pop, backPopAction]))
        
        let tapMeAction1 = SKAction.scaleBy(1.1, duration: 0.5)
        let tapMeAction2 = SKAction.scaleBy(0.9, duration: 0.5)
        play.runAction(SKAction.waitForDuration(0.4))
        play.runAction(SKAction.repeatActionForever(SKAction.sequence([tapMeAction1, tapMeAction2])))
        
        return .Start
    }
    
    func setupBird(birdSprite: Bird) {
        birdSprite.anchorPoint = CGPointMake(0.5, 0.5)
        birdSprite.position = CGPointMake(scene.size.width*0.5, scene.size.height*0.2)
        scene.addChild(birdSprite)
        
        print("bird setup")
    }
    
    func setupLabel(scoreLabel: SKLabelNode) {
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(scene.size.width*0.11, scene.size.height*0.94)
        scoreLabel.zPosition = Layer.Label.rawValue
        scene.addChild(scoreLabel)
        
    }
    
    func setupTutorial() {
    }
    
    func setupScorecard(GameOverNode: SKSpriteNode, scoreLabel: SKLabelNode, Scorecard: SKSpriteNode, lastScore: SKLabelNode, bestScoreNode: SKLabelNode, score: Int, bestScore: Int) {
        scoreLabel.removeFromParent()
        
        GameOverNode.position = CGPointMake(scene.size.width*0.5, scene.size.height*0.8)
        GameOverNode.zPosition = Layer.GameOver.rawValue
        GameOverNode.name = "game_over"
        scene.addChild(GameOverNode)
        
        Scorecard.position = CGPointMake(scene.size.width*0.5, -Scorecard.size.height/2)
        Scorecard.name = "game_over"
        Scorecard.zPosition = Layer.Label.rawValue
        scene.addChild(Scorecard)
        
        lastScore.fontColor = SKColor.whiteColor()
        lastScore.position = CGPointMake(scene.size.width*0.3, -Scorecard.size.height/2)
        lastScore.zPosition = Layer.GameOver.rawValue
        lastScore.text = "\(score)"
        scene.addChild(lastScore)
        
        bestScoreNode.fontColor = SKColor.whiteColor()
        bestScoreNode.position = CGPointMake(scene.size.width*0.7, -Scorecard.size.height * 0.2)
        bestScoreNode.zPosition = Layer.GameOver.rawValue
        bestScoreNode.text = "\(bestScore)"
        scene.addChild(bestScoreNode)
        
        let pop = SKAction.playSoundFileNamed("pop.wav",
waitForCompletion: false)
        let wait = SKAction.waitForDuration(0.1)
        let popAction = SKAction.scaleBy(1.5, duration: 0.1)
        let backPopAction = SKAction.scaleBy(0.75, duration: 0.1)
        let action = SKAction.sequence([wait, popAction, pop, backPopAction])
        GameOverNode.runAction(action)
        
        let moveTo = SKAction.moveTo(CGPointMake(scene.size.width*0.5, scene.size.height/2 + 50.0), duration: 0.2)
        moveTo.timingMode = .EaseInEaseOut
        Scorecard.runAction(SKAction.sequence([SKAction.waitForDuration(0.4), moveTo, pop]))
        let moveToLastScore = SKAction.moveToY(scene.size.height/2 + 27.0, duration: 0.4)
        let moveToBestScore = SKAction.moveToY(scene.size.height/2 + 27.0, duration: 0.4)
        lastScore.runAction(SKAction.sequence([SKAction.waitForDuration(0.4), moveToLastScore, pop]))
        bestScoreNode.runAction(SKAction.sequence([SKAction.waitForDuration(0.4), moveToBestScore, pop]))
        
        // SKLabelNodes can't perform actions?
    }
    
}