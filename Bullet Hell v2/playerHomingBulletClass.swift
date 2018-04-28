//
//  playerHomingBulletClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 4/2/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerHomingBullet : PlayerBullet {
    
    var velocity: CGFloat = 8
    var vX : CGFloat = 0
    var vY : CGFloat = 0
    
    init(position: CGPoint, gameScene: SKScene) {
        super.init(texture: SKTexture(imageNamed: "playerHomingBullet.png"), position: position, gameScene: gameScene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTargetPosition(maxDistance: CGFloat) -> CGPoint{
        var nearDist = maxDistance
        var targetPosition : CGPoint = CGPoint(x: self.position.x + self.vX, y: self.position.y + self.vY)
        for soldier in enemyFactory.soldiers {
            let dist = distanceTowards(self.position.x, y: self.position.y, x1: soldier.position.x, y1: soldier.position.y)
            if (dist < nearDist){
                nearDist = dist
                targetPosition = soldier.position
            }
        }
        for brute in enemyFactory.brutes {
            let dist = distanceTowards(self.position.x, y: self.position.y, x1: brute.position.x, y1: brute.position.y)
            if (dist < nearDist){
                nearDist = dist
                targetPosition = brute.position
            }
        }
        return targetPosition
    }
    
    override func update(currentTime: CFTimeInterval) {
        let currentRotation = self.zRotation * Rad2Deg
        let targetPosition = getTargetPosition(maxDistance: 200)
        let finalRotation = Rad2Deg * pointTowards(self.position.x, y: self.position.y, x1: targetPosition.x, y1: targetPosition.y)
        let rotateDegrees = ((((finalRotation - currentRotation).truncatingRemainder(dividingBy: 360)) + 540 ).truncatingRemainder(dividingBy: 360)) - 180
        if( abs(rotateDegrees) < 75) {
            self.zRotation += Deg2Rad * (min(abs(rotateDegrees), 4) * sign(rotateDegrees))
        }
        
        self.vX = self.velocity * cos(self.zRotation)
        self.vY = self.velocity * sin(self.zRotation)
        
        self.position.x += self.vX
        self.position.y += self.vY
        
        if (self.position.x < -self.size.width/2 || self.position.x > self.gameScene.size.width + self.size.width/2 || self.position.y < -self.size.height/2 || self.position.y > self.gameScene.size.height + self.size.height/2) {
            self.removeFromParent()
            player.playerBullets.remove(at: player.playerBullets.index(of: self)!)
        }
    }
}
