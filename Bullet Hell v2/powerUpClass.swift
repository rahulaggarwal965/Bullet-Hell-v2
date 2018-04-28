//
//  powerUpClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 2/11/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

let powerUpTypes : [Int: String] = [
    0 : "Default", //Default - Done
    1 : "Homing Bullet", //Replacing, update required - Done
    2 : "Orbitals", //Not Replacing, update required Done
    3 : "Wave", //Repacing, update required - Done
    4 : "Tail Gun", //Not Replacing, no update required
    5 : "Lifesteal", //Add on
    6 : "Armor Pierce", //Add on
    7 : "Shields", //Ship Add On <--- Unique
    8 : "Lasers" //Replacing, ???
]
    
let powerUpFireRates : [Int : CFTimeInterval] = [
    0 : 0.2,
    1 : 0.4,
    2 : 0.2,
    3 : 0.25,
    4 : 0.2,
    5 : 0.2,
    6 : 0.2,
    7 : 0.2,
    8 : 0.2
]
    
let powerUpTextures : [Int : SKTexture] = [
    0 : SKTexture(imageNamed: "playerBulletv2.png"),
    1 : SKTexture(imageNamed: "playerHomingBullet.png"),
    2 : SKTexture(imageNamed: "playerBulletv2.png"),
    3 : SKTexture(imageNamed: "playerWaveBullet.png"),
    4 : SKTexture(imageNamed: "playerBulletv2.png"),
    5 : SKTexture(imageNamed: "playerBulletv2.png"), //Keep
    6 : SKTexture(imageNamed: "playerBulletv2.png"), //Keep
    7 : SKTexture(imageNamed: "playerBulletv2.png"),
    8 : SKTexture(imageNamed: "playerBulletv2.png")
]


class PowerUp : SKSpriteNode {
    
    let powerUpAtlas = SKTextureAtlas(named: "powerUps")
    var powerUpAnimation: [SKTexture] = [SKTexture]()
    var type : Int
    
    init(position: CGPoint, type: Int){
        
        for i in 1 ... powerUpAtlas.textureNames.count {
            self.powerUpAnimation.append(self.powerUpAtlas.textureNamed("power\(i)"))
        }
        self.type = type
        
        super.init(texture: powerUpAnimation[0], color: UIColor.clear, size: powerUpAnimation[0].size())
        
        self.position = position
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = physicsCategory.powerUp
        self.physicsBody?.contactTestBitMask = physicsCategory.player
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.isDynamic = true;
        
        self.run(SKAction.sequence([SKAction.moveTo(y: -self.size.height, duration: 5.0), SKAction.removeFromParent()]))
        self.run(SKAction.repeatForever(SKAction.animate(with: powerUpAnimation, timePerFrame: 0.05, resize: false, restore: true)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
