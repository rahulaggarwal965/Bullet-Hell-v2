//
//  bruteEnemyClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/10/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class Brute : Enemy {
    
    let bruteAtlas = SKTextureAtlas(named: "enemyT2Images")
    var bruteAnimation : [SKTexture] = [SKTexture]()
    
    init(position: CGPoint) {
        
        for i in 1 ... self.bruteAtlas.textureNames.count {
            self.bruteAnimation.append(self.bruteAtlas.textureNamed("brute\(i)"))
        }
        
        super.init(type: "Brute", position: position, texture: bruteAnimation[0], color: UIColor.clear, size: bruteAnimation[0].size())
        
        //self.physicsBody?.categoryBitMask = physicsCategory.enemyT2
        //self.physicsBody?.contactTestBitMask = physicsCategory.player | physicsCategory.playerBullet
        self.run(SKAction.sequence([SKAction.moveTo(y: -self.size.height, duration: 7.0), SKAction.removeFromParent()]))
        self.run(SKAction.repeatForever(SKAction.animate(with: bruteAnimation, timePerFrame: 0.05, resize: false, restore: true)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: TimeInterval) {
        super.healthBar.update(currentTime: currentTime, hostile: true, position: self.position, positionOffset: 17)
    }
    
}
