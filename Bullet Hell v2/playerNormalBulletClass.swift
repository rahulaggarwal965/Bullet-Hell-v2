//
//  playerNormalBulletClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 4/2/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class playerNormalBullet : PlayerBullet {
    
    init(position: CGPoint, gameScene: SKScene) {
        super.init(texture: SKTexture(imageNamed: "playerBulletv2.png"), position: position, gameScene: gameScene)
        
        self.run(SKAction.sequence([SKAction.moveTo(y: gameScene.size.height + self.size.height + self.position.y, duration: 1.3), SKAction.removeFromParent()]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        
    }
    
}
