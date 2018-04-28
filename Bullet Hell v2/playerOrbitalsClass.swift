//
//  playerOrbitalsClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 4/1/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerOrbitals : PlayerBullet {
    
    var life : CGFloat //maybe
    var orbitRadius : CGFloat
    var angle : CGFloat
    
    init(orbitCenter: CGPoint, gameScene: SKScene, r: CGFloat, angle: CGFloat, life: CGFloat) {
        self.orbitRadius = r
        self.angle = angle
        self.life = life
        super.init(texture: SKTexture(imageNamed: "playerWaveBullet.png"), position: CGPoint(x: orbitCenter.x + self.orbitRadius * cos(self.angle), y: orbitCenter.y + self.orbitRadius * sin(self.angle)), gameScene: gameScene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        self.position.x = player.position.x + self.orbitRadius * CGFloat(cos(self.angle + CGFloat(currentTime*8)))
        self.position.y = player.position.y + self.orbitRadius * CGFloat(sin(self.angle + CGFloat(currentTime*8)))
    }
}
