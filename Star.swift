//
//  Star.swift
//  MojaIgra1
//
//  Created by Lara Carli on 10/30/15.
//  Copyright © 2015 Larisa Carli. All rights reserved.
//

import Foundation
import SpriteKit

enum StarType {
    case Special
    case Normal
}

class Star: SKSpriteNode {
    var type: StarType!
    var sc: SKScene!
    
    init(starType: StarType, scene: SKScene) {
        self.type = starType
        self.sc = scene
        
        let textureName = (starType == .Special) ? "StarSpecial" : "Star"
        let texture = SKTexture(imageNamed: textureName)
        
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        /*
        if type == .Special {
            self.position = CGPointMake(random(min: 0.0, max: sc.size.width), random(min: sc.size.height*0.4, max: sc.size.height))
        } else if type == .Normal {
            self.position = CGPointMake(random(min: 25.0, max: sc.size.width - 25.0), sc.size.height + 30.0)
        }
        self.zPosition = Layer.Bird.rawValue
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2, center: self.position)
        if type == .Special {
            self.physicsBody?.affectedByGravity = true
        } else if type == .Normal {
            self.physicsBody?.affectedByGravity = true
        }
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bird
        
        if type == .Special {
            self.physicsBody?.categoryBitMask = PhysicsCategory.StarSpecial
            self.physicsBody?.pinned = true
        } else if type == .Normal {
            self.physicsBody?.categoryBitMask = PhysicsCategory.Star
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.pinned = false
        }*/
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2, center: self.position)

        self.position = CGPointMake(random(min: 0.0, max: sc.size.width), random(min: sc.size.height*0.4, max: sc.size.height))
        self.zPosition = Layer.Bird.rawValue
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.pinned = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.StarSpecial
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Bird
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        
        //do sem
        
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func addStar() {
        sc.addChild(self)
    }
    
    func removeStar(star: Star) {
        runAction(SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false))
        
        let popAction = SKAction.scaleBy(1.3, duration: 0.07)
        let backPopAction = SKAction.scaleBy(0.5, duration: 0.07)
        let fadeAction = SKAction.fadeOutWithDuration(0.07)
        let removeAction = SKAction.removeFromParent()
        let action = SKAction.sequence([popAction, backPopAction, fadeAction, removeAction])
        star.runAction(action)
    }
    
    func makeStars() {
        let makeAction = SKAction.runBlock(addStar)
        let pop = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
        let groupAction = SKAction.repeatActionForever(SKAction.sequence([makeAction, pop, SKAction.waitForDuration(6.0)]))
        sc.runAction(groupAction)
    }
    
    func starRain() {
        let makeAction = SKAction.runBlock(addStar)
        sc.runAction(SKAction.repeatAction(SKAction.sequence([SKAction.waitForDuration(0.1), makeAction]), count: 8), withKey: "starRain")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}