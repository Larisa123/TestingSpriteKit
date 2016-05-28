//
//  Ball.swift
//  MojaIgra1
//
//  Created by Lara Carli on 10/21/15.
//  Copyright © 2015 Larisa Carli. All rights reserved.
//

import Foundation
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
    static let Cloud: UInt32 = 0b10
    static let Desk: UInt32 = 0b100
}


class Ball: SKSpriteNode {
    
}
