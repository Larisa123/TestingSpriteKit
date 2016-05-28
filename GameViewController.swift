//
//  GameViewController.swift
//  MojaIgra1
//
//  Created by Lara Carli on 10/21/15.
//  Copyright (c) 2015 Larisa Carli. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameSceneDelegate {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let skView = self.view as? SKView {
            if skView.scene == nil {
                let aspectRatio = skView.bounds.size.height / skView.bounds.size.width
                let scene = GameScene(size: CGSizeMake(320, 320 * aspectRatio), delegate: self, gameState: .ShowingStart)
                
                skView.showsFPS = true
                skView.showsNodeCount = true
                skView.showsPhysics = true
                skView.ignoresSiblingOrder = true
                scene.scaleMode = .AspectFill
                skView.presentScene(scene)
            }
        }
    }
    
    func screenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 1.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func shareString(string: String, url: NSURL, image: UIImage) {
        let vc = UIActivityViewController(activityItems: [string, url, image], applicationActivities: nil)
        presentViewController(vc, animated: true, completion: nil)
    }
}
