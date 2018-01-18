//
//  playerClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/14/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class Player : SKSpriteNode {
    
    let playerAtlas = SKTextureAtlas(named: "playerImagesv1")
    var playerAnimation : [SKTexture] = [SKTexture]()
    var healthBar : HealthBar
    var gameScene : SKScene
    
    init(position: CGPoint, gameScene: SKScene){
        
        self.gameScene = gameScene
        for i in 1 ... self.playerAtlas.textureNames.count {
            self.playerAnimation.append(self.playerAtlas.textureNamed("spaceShip\(i)"))
        }
        
        self.healthBar = HealthBar(healthBarWidth: 100, healthBarHeight: 10, hostile: false, health: 100, maxHealth: 100)
        
        super.init(texture: playerAnimation[0], color: UIColor.clear, size: playerAnimation[0].size())
        
        self.position = position
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.categoryBitMask = physicsCategory.player;
        self.physicsBody?.contactTestBitMask = (physicsCategory.soldier | physicsCategory.brute | physicsCategory.bruteBullet)
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.isDynamic = false;
        
        self.gameScene.addChild(self.healthBar)

        self.run(SKAction.repeatForever(SKAction.animate(with: playerAnimation, timePerFrame: 0.05, resize: false, restore: true)))
        
        let playerBulletTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(self.spawnBullets), userInfo: nil, repeats: true)
    }
    
    @objc func spawnBullets(){
        self.gameScene.addChild(PlayerBullet(position: self.position, gameScene: self.gameScene))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(location: CGPoint){
        self.position = location;
    }
}
