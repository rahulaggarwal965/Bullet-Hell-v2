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
//let enemyHealthBarWidths: [String : Int] = ["Soldier" : 40, "Brute" : 40]
//let enemyHealthBarHeights: [String : Int] = ["Soldier" : 4, "Brute" : 4]

class Enemy : SKSpriteNode {

    var type : String;
    var health : Int;
    var armor : Int;
    var healthBar : HealthBar;

    init(type: String, position: CGPoint, texture : SKTexture, color: UIColor, size: CGSize){
        self.type = type;
        self.health = enemyHealths[self.type]!
        self.armor = enemyArmors[self.type]!
        self.healthBar = HealthBar(healthBarWidth: 40, healthBarHeight: 4, hostile: true, health: self.health, maxHealth: self.health, position: CGPoint(x: 0, y: 0))
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

    func update(currentTime: TimeInterval){

    }
}

