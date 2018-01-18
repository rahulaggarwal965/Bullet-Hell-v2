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
    var bruteBulletCooldown : CFTimeInterval = 0
    var bruteBullets : [BruteBullet] = []
    
    init(position: CGPoint, gameScene: SKScene) {
        
        for i in 1 ... self.bruteAtlas.textureNames.count {
            self.bruteAnimation.append(self.bruteAtlas.textureNamed("brute\(i)"))
        }
        
        super.init(type: "Brute", position: position, texture: bruteAnimation[0], color: UIColor.clear, size: bruteAnimation[0].size(), gameScene: gameScene)
        
        self.physicsBody?.categoryBitMask = physicsCategory.brute
        self.physicsBody?.contactTestBitMask = physicsCategory.player | physicsCategory.playerBullet
        self.run(SKAction.sequence([SKAction.moveTo(y: -self.size.height, duration: 7.0), SKAction.removeFromParent(), SKAction.perform(#selector(self.offScreen), onTarget: self)]))
        self.run(SKAction.repeatForever(SKAction.animate(with: bruteAnimation, timePerFrame: 0.05, resize: false, restore: true)))
        
    }
    
    @objc override func offScreen(){
        if(self.position.y < -self.size.height/2 && bruteBullets.count <= 0){
            self.isOffScreen = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: TimeInterval, playerPosition: CGPoint) {
        if (currentTime - bruteBulletCooldown >= 3){
            bruteBullets.append(BruteBullet(position: self.position, gameScene: super.gameScene))
            super.gameScene.addChild(bruteBullets.last!)
            self.bruteBulletCooldown = currentTime
        }
        
        for bruteBullet in bruteBullets {
            bruteBullet.update(targetPosition: playerPosition)
        }
        
    }
    
}
