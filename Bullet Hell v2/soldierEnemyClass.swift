//
//  soldierEnemyClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/8/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class soldier : Enemy {

    let soldierAtlas = SKTextureAtlas(named: "enemyT1Images")
    var soldierAnimation : [SKTexture] = [SKTexture]()

    init(position: CGPoint){

        for i in 1 ... self.soldierAtlas.textureNames.count {
            self.soldierAnimation.append(self.soldierAtlas.textureNamed("soldier\(i)"))
        }

        super.init(type: "soldier", position: position, texture: soldierAnimation[0], color: UIColor.clear, size: soldierAnimation[0].size())

        self.physicsBody?.categoryBitMask = physicsCategory.enemyT1
        self.physicsBody?.contactTestBitMask = physicsCategory.player | physicsCategory.playerBullet
        self.run(SKAction.sequence([SKAction.moveTo(y: -self.size.height, duration: 3.0), SKAction.removeFromParent()]))
        self.run(SKAction.repeatForever(SKAction.animate(with: soldierAnimation, timePerFrame: 0.05, resize: false, restore: true)))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(currentTime: TimeInterval) {
        super.healthBar.update(currentTime: currentTime, hostile: true, position: self.position, positionOffset: 17)
    }

}

