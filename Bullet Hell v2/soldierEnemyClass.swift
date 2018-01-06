//
//  soldierEnemyClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 12/29/17.
//  Copyright © 2017 DMA. All rights reserved.
//

import SpriteKit

class soldier : Enemy {
    
    let soldierAtlas = SKTextureAtlas(named: "soldier")
    
    init(position: CGPoint){
        super.init(type: "soldier", position: position, texture: <#T##SKTexture#>, color: <#T##UIColor#>, size: <#T##CGSize#>)
        
        self.physicsBody?.categoryBitMask = physicsCategory.soldier
        self.physicsBody?.contactTestBitMask = physicsCategory.player | physicsCategory.playerBullet
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: TimeInterval) {
        super.healthBar.update(currentTime: currentTime, hostile: true, position: self.position, positionOffset: 17)
    }
    
}
