//
//  bruteBulletClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/17/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class BruteBullet : Bullet {
    
    var isOffScreen : Bool = false
    var velocity : CGFloat = 30
    var vX : CGFloat = 0
    var vY : CGFloat = 0
    
    init(position: CGPoint, gameScene: SKScene){
        
        super.init(texture: SKTexture(imageNamed: "enemyBullet.png"), damage: 5, gameScene: gameScene)
        
        self.setScale(2)
        self.zRotation = -90 * Deg2Rad
        self.position = position
        self.physicsBody?.categoryBitMask = physicsCategory.bruteBullet
        self.physicsBody?.contactTestBitMask = physicsCategory.player
    }
    
    func update(targetPosition: CGPoint){
        let currentRotation = self.zRotation * Rad2Deg
        let finalRotation = Rad2Deg * pointTowards(self.position.x, y: self.position.y, x1: targetPosition.x, y1: targetPosition.y)
        let rotateDegrees = ((((finalRotation - currentRotation).truncatingRemainder(dividingBy: 360)) + 540 ).truncatingRemainder(dividingBy: 360)) - 180
        self.zRotation += Deg2Rad * (min(abs(rotateDegrees), 10) * sign(rotateDegrees))
        //self.zRotation += Deg2Rad * (abs(rotateDegrees/5) * sign(rotateDegrees))
        
        self.vX = self.velocity * (90 - abs(self.zRotation*Rad2Deg)) / 90
        if (self.zRotation < 0) {
            self.vY = -self.velocity + abs(self.vX)
        } else {
            self.vY = self.velocity - abs(self.vX)
        }
        
        self.position.x += self.vX
        self.position.y += self.vY
        
        if (self.position.x < -self.size.width/2 || self.position.x > super.gameScene.size.width + self.size.width/2 || self.position.y < -self.size.height/2 || self.position.y > super.gameScene.size.height + self.size.height/2) {
            self.removeFromParent()
            self.isOffScreen = true
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
