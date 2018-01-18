//
//  bulletClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/14/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class Bullet : SKSpriteNode {

    var gameScene : SKScene
    var damage : Int

    init(texture: SKTexture, damage : Int, gameScene: SKScene){
        
        self.gameScene = gameScene
        self.damage = damage
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        self.zPosition = -5;
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.isDynamic = false;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

