//
//  enemyFactory.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/14/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyFactory {

    var soldiers : [Soldier] = []
    var brutes : [Brute] = []
    var gameScene : SKScene

    init(gameScene: SKScene) {
        self.gameScene = gameScene;
        let soldierTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.spawnSoldier), userInfo: nil, repeats: true);
        let bruteTimer = Timer.scheduledTimer(timeInterval: 5.3, target: self, selector: #selector(self.spawnBrute), userInfo: nil, repeats: true);


        }

    @objc func spawnSoldier(){
        soldiers.append(Soldier(position: CGPoint(x: CGFloat(random(low: 24, high: Int(self.gameScene.size.width))), y: CGFloat(self.gameScene.size.height)), gameScene: self.gameScene))
        self.gameScene.addChild(soldiers.last!)
    }
    
    @objc func spawnBrute(){
        brutes.append(Brute(position: CGPoint(x: CGFloat(random(low: 34, high: Int(self.gameScene.size.width))), y: CGFloat(self.gameScene.size.height)), gameScene: self.gameScene))
        self.gameScene.addChild(brutes.last!)
    }

    func update(currentTime: TimeInterval, playerPosition: CGPoint) {
        for soldier in soldiers {
            if(soldier.isOffScreen == true || soldier.isDestroyed  == true){
                soldiers.remove(at: soldiers.index(of: soldier)!)
            }
        }
        
        for brute in brutes {
            brute.update(currentTime: currentTime, playerPosition: playerPosition)
            if(brute.isOffScreen == true || brute.isDestroyed == true){
                brutes.remove(at: brutes.index(of: brute)!)
            }
        }
        
    }

}

