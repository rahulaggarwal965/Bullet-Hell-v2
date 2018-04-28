//
//  playerBulletClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/16/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerBullet : Bullet {

    init(texture: SKTexture, position: CGPoint, gameScene: SKScene){
        super.init(texture: texture, damage: 12, gameScene: gameScene)
        
        self.position = position
        self.zRotation = 90 * Deg2Rad
        self.physicsBody?.categoryBitMask = physicsCategory.playerBullet
        self.physicsBody?.contactTestBitMask = physicsCategory.soldier | physicsCategory.brute
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: CFTimeInterval) {
        /*if (self.position.x < -self.size.width/2 || self.position.x > self.gameScene.size.width + self.size.width/2 || self.position.y < -self.size.height/2 || self.position.y > self.gameScene.size.height + self.size.height/2) {
         self.removeFromParent()
         player.playerBullets.remove(at: player.playerBullets.index(of: self)!)
         }*/
    }
    
}
