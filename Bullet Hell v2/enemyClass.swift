//
//  enemyClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/8/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

let enemyHealths : [String : Int] = ["Soldier" : 40, "Brute" : 120]
let enemyArmors : [String : Int] = ["Soldier" : 0, "Brute" : 30]


class Enemy : SKSpriteNode {
    
    var type : String;
    var health : Int;
    var armor : Int;
    var healthBar : HealthBar;
    var isRemoved : Bool = false;
    var gameScene : SKScene

    init(type: String, position: CGPoint, texture : SKTexture, color: UIColor, size: CGSize, gameScene: SKScene){
        self.gameScene = gameScene
        self.type = type;
        self.health = enemyHealths[self.type]!
        self.armor = enemyArmors[self.type]!
        self.healthBar = HealthBar(barWidth: 40, barHeight: 4, hostile: true, health: self.health, maxHealth: self.health)
        super.init(texture: texture, color: color, size: size)

        self.position = position;
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.isDynamic = true;
        
        self.addChild(self.healthBar)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        if (self.position.y < -self.size.height/2){
            self.isRemoved = true
        }
    }
}

