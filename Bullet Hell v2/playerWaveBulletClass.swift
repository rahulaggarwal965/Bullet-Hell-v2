//
//  playerWaveBulletClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 4/1/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerWaveBullet : PlayerBullet {
    
    var velocity : CGFloat = 8
    var life : CGFloat = 0
    
    init(position: CGPoint, gameScene: SKScene) {
        super.init(texture: SKTexture(imageNamed: "playerWaveBullet.png"), position: position, gameScene: gameScene)
        
        self.life = CGFloat(random(low: 250, high: 350))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        self.position.y += self.velocity
        self.position.x += sin(self.life * 25) * 2.5
        self.life -= 1
        
        if (self.position.x < -self.size.width/2 || self.position.x > self.gameScene.size.width + self.size.width/2 || self.position.y < -self.size.height/2 || self.position.y > self.gameScene.size.height + self.size.height/2) {
            self.removeFromParent()
            player.playerBullets.remove(at: player.playerBullets.index(of: self)!)
        }
    }
}
