//
//  Desk.swift
//  MojaIgra1
//
//  Created by Lara Carli on 10/24/15.
//  Copyright © 2015 Larisa Carli. All rights reserved.
//

import Foundation
import SpriteKit

class Desk: SKSpriteNode {
    let popSound = SKAction.playSoundFileNamed("pop.wav", waitForCompletion: false)
    var start = CGPointZero
    var end = CGPointZero
    
    init(start: CGPoint, end: CGPoint) {
        let texture = SKTexture(imageNamed: "Platform")
        let size = CGSizeMake(texture.size().width*1.5, texture.size().height*0.6)
        self.start = start
        self.end = end
        
        super.init(texture: texture, color: UIColor.clearColor(), size: size)

        self.zPosition = Layer.Desk.rawValue
        self.name = "desk"
        self.zRotation = calculateTheAngle()
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.pinned = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.Desk
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.contactTestBitMask = PhysicsCategory.None
        self.physicsBody?.dynamic = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func runPopAction() {
        runAction(popSound)
        
        let popAction = SKAction.scaleBy(1.4, duration: 0.1)
        let backPopAction = SKAction.scaleBy(0.7, duration: 0.1)
        let waitAction = SKAction.waitForDuration(5.0)
        let fadeAction = SKAction.fadeOutWithDuration(0.3)
        let removeAction = SKAction.removeFromParent()
        let action = SKAction.sequence([popAction, backPopAction, waitAction, fadeAction, removeAction])
        self.runAction(action)
    }
    
    func runCollisionAction() {
        runAction(popSound)
        
        let popAction = SKAction.scaleBy(1.3, duration: 0.07)
        let backPopAction = SKAction.scaleBy(0.5, duration: 0.07)
        let fadeAction = SKAction.fadeOutWithDuration(0.07)
        let removeAction = SKAction.removeFromParent()
        let action = SKAction.sequence([popAction, backPopAction, fadeAction, removeAction])
        self.runAction(action)
    }
    
    func calculateTheAngle() -> CGFloat {
        let angle = atan((end.y - start.y)/(end.x - start.x))
        return angle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
