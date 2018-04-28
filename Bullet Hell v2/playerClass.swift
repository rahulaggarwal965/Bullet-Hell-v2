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
    var health : Int
    var armor : Int
    var powerUpType : Int = 0
    var playerBullets : [PlayerBullet] = []
    var playerBulletCooldown : CFTimeInterval = 0;
    var powerUpTime : CFTimeInterval = 0;
    
    init(position: CGPoint, gameScene: SKScene, health: Int, armor: Int){
        
        self.health = health
        self.armor = armor
        self.gameScene = gameScene
        for i in 1 ... self.playerAtlas.textureNames.count {
            self.playerAnimation.append(self.playerAtlas.textureNamed("spaceShip\(i)"))
        }
        
        self.healthBar = HealthBar(barWidth: 100, barHeight: 10, hostile: false, health: self.health, maxHealth: self.health)
        
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
    }
    
    func spawnBullets(){
        if (self.health > 0) {
            switch self.powerUpType {
                
            case 0:
                self.playerBullets.append(playerNormalBullet(position: self.position, gameScene: self.gameScene))
                self.gameScene.addChild(playerBullets.last!)
                
            case 1:
                self.playerBullets.append(PlayerHomingBullet(position: self.position, gameScene: self.gameScene))
                self.gameScene.addChild(playerBullets.last!)
                
            case 2:
                for i in 1...3 {
                    self.playerBullets.append(PlayerOrbitals(orbitCenter: self.position, gameScene: self.gameScene, r: 60, angle: CGFloat(i)*2*Pi/3, life: 200))
                    self.gameScene.addChild(playerBullets.last!)
                }
                self.powerUpType = 0
                
            case 3:
                self.playerBullets.append(PlayerWaveBullet(position: self.position, gameScene: self.gameScene))
                self.gameScene.addChild(playerBullets.last!)
                
            default:
                self.playerBullets.append(playerNormalBullet(position: self.position, gameScene: self.gameScene))
                self.gameScene.addChild(playerBullets.last!)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onTouch(location: CGPoint){
        //self.position = location;
        self.position.x += (location.x - self.position.x)/2
        self.position.y += (location.y - self.position.y)/2
    }
    
    func update(currentTime: CFTimeInterval) {
        if (currentTime - self.playerBulletCooldown >= powerUpFireRates[self.powerUpType]!){
            spawnBullets()
            self.playerBulletCooldown = currentTime
        }
        for playerBullet in playerBullets {
            playerBullet.update(currentTime: currentTime)
        }
        
        if (self.powerUpType != 0) {
            if (self.powerUpTime == 0) {
                self.powerUpTime = currentTime
            } else if (currentTime - self.powerUpTime >= 4.8) {
                self.powerUpType = 0
                self.powerUpTime = 0
            }
        }
    }
}
