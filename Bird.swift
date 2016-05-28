//
//  Bird.swift
//  MojaIgra1
//
//  Created by Lara Carli on 10/22/15.
//  Copyright © 2015 Larisa Carli. All rights reserved.
//

import SpriteKit

enum Layer: CGFloat {
    case Background
    case Clouds
    case Foreground
    case Bird
    case Desk
    case Pipe
    case Player
    case Label
    case Label2
    case GameOver
}

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let All: UInt32 = UInt32.max
    static let Bird: UInt32 = 0b1
    static let StarSpecial: UInt32 = 0b10
    static let Desk: UInt32 = 0b100
    static let Star: UInt32 = 0b101
    static let Cloud: UInt32 = 0b110

}

class Bird: SKSpriteNode {
    var Birdsize = CGSizeZero
    var sc: SKScene!
    //var start = CGPointZero
    //var end = CGPointZero
    let flapSound = SKAction.playSoundFileNamed("flapping.wav", waitForCompletion: false)
    
    init(sc: SKScene) {
        let texture = SKTexture(imageNamed: "hero")
        let size = texture.size()
        self.sc = sc
        self.Birdsize = size
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(size.width/2, size.height/2))
        
        self.zPosition = Layer.Bird.rawValue
        self.name = "bird"
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Bird
        self.physicsBody?.collisionBitMask = PhysicsCategory.Desk
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Desk | PhysicsCategory.StarSpecial
        
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.restitution = 0
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func BirdImpulse(location: CGPoint) {
        var vector = CGVectorMake(0.0, 150.0)
        if self.position.x - 50.0  > location.x  {
            vector = CGVectorMake(-40.0, 120.0)
        } else if self.position.x + 50.0 < location.x {
            vector = CGVectorMake(40.0, 120.0)
        }
        self.physicsBody?.velocity = vector
        runAction(flapSound)
    }
    
    func BirdDidCollideWithDesk(bird: Bird, desk: Desk, scoreClass: Score, scoreLabel: SKLabelNode) {
        BirdImpulse(self.position)
        scoreClass.updateScore(scoreLabel)
        desk.runCollisionAction()
        //self.runAction(bounceElastically())
    }
    
    func bounceElastically() -> SKAction {
        let orig_size = Birdsize.height
        let scaleDown = SKAction.scaleYTo(orig_size*0.1, duration: 0.1)
        let scaleUp = SKAction.scaleYTo(orig_size*0.2, duration: 0.1)
        let scaleToNormal = SKAction.scaleYTo(orig_size, duration: 0.1)
        let scalingSequence = SKAction.sequence([scaleDown, scaleUp, scaleToNormal])
        return scalingSequence
    }
    
    /*func calculateTheAngle() -> CGFloat {
        let angle = atan((end.y - start.y)/(end.x - start.x))
        return angle
    }
    func ToTheAngle(angle: CGFloat) {
    }*/

}
