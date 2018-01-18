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

    init(position: CGPoint, gameScene: SKScene){
        
        super.init(texture: SKTexture(imageNamed: "playerBulletv2.png"), damage: 30, gameScene: gameScene)
        
        self.position = position
        self.physicsBody?.categoryBitMask = physicsCategory.playerBullet
        self.physicsBody?.contactTestBitMask = physicsCategory.soldier | physicsCategory.brute
        self.run(SKAction.sequence([SKAction.moveTo(y: gameScene.size.height + self.size.height, duration: 1.3), SKAction.removeFromParent()]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
