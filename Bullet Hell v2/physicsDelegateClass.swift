//
//  physicsDelegateClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/19/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

struct physicsCategory {
    
    //Enemies
    static let soldier : UInt32 = 1;
    static let brute : UInt32 = 2;
    
    //Bullets
    static let playerBullet : UInt32 = 3;
    static let bruteBullet: UInt32 = 5;
    
    //Player
    static let player : UInt32 = 4;
    
}

class PhysicsDelegate {
    
    init(){
        
    }
    
    func didBegin(contact: SKPhysicsContact) {
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
        if((firstBody.node?.parent == nil) || (secondBody.node?.parent == nil)){
            return;
        }
        
        //Collisions
        if ((firstBody.categoryBitMask == physicsCategory.soldier) && (secondBody.categoryBitMask == physicsCategory.playerBullet)) {
            soldierPlayerBulletCollision(soldier: firstBody.node as! Soldier, playerBullet: secondBody.node as! PlayerBullet)
        } else if ((firstBody.categoryBitMask == physicsCategory.playerBullet) && (secondBody.categoryBitMask == physicsCategory.soldier)){
            soldierPlayerBulletCollision(soldier: secondBody.node as! Soldier, playerBullet: firstBody.node as! PlayerBullet)
        }
        
        if ((firstBody.categoryBitMask == physicsCategory.brute) && (secondBody.categoryBitMask == physicsCategory.playerBullet)) {
            brutePlayerBulletCollision(brute: firstBody.node as! Brute, playerBullet: secondBody.node as! PlayerBullet)
        } else if ((firstBody.categoryBitMask == physicsCategory.playerBullet) && (secondBody.categoryBitMask == physicsCategory.brute)){
            brutePlayerBulletCollision(brute: secondBody.node as! Brute, playerBullet: firstBody.node as! PlayerBullet)
        }
        
        if ((firstBody.categoryBitMask == physicsCategory.soldier) && (secondBody.categoryBitMask == physicsCategory.player)) {
            soldierPlayerCollision(soldier: firstBody.node as! Soldier, player: secondBody.node as! Player)
        } else if ((firstBody.categoryBitMask == physicsCategory.player) && (secondBody.categoryBitMask == physicsCategory.soldier)) {
            soldierPlayerCollision(soldier: secondBody.node as! Soldier, player: firstBody.node as! Player)
        }
        
        if ((firstBody.categoryBitMask == physicsCategory.bruteBullet) && (secondBody.categoryBitMask == physicsCategory.player)) {
            bruteBulletPlayerCollision(bruteBullet: firstBody.node as! BruteBullet, player: secondBody.node as! Player)
        } else if ((firstBody.categoryBitMask == physicsCategory.player) && (secondBody.categoryBitMask == physicsCategory.bruteBullet)) {
            bruteBulletPlayerCollision(bruteBullet: secondBody.node as! BruteBullet, player: firstBody.node as! Player)
        }

    }
    
    //Collision of a Soldier Enemy with a Player Bullet
    func soldierPlayerBulletCollision(soldier: Soldier, playerBullet: PlayerBullet) {
        soldier.health -= playerBullet.damage + random(low: 0, high: 3)
        soldier.healthBar.update(health: soldier.health)
        playerBullet.removeFromParent()
        if (soldier.health <= 0){
            soldier.health = 0
            soldier.removeFromParent()
            soldier.healthBar.removeFromParent()
            soldier.isDestroyed = true;
        }
    }
    
    //Collision of a Brute Enemy with a Player Bullet
    func brutePlayerBulletCollision(brute: Brute, playerBullet: PlayerBullet){
        brute.health -= 20 //something
        brute.healthBar.update(health: brute.health)
        playerBullet.removeFromParent()
        if(brute.health <= 0){
            brute.health = 0
            brute.removeFromParent()
            brute.healthBar.removeFromParent()
            if (brute.bruteBullets.count <= 0){
                brute.isDestroyed = true
            }
        }
    }
    
    func soldierPlayerCollision(soldier: Soldier, player: Player) {
        player.health -= random(low: 12, high: 15)
        player.healthBar.update(health: player.health)
        if(player.health <= 0) {
            player.health = 0
            player.removeFromParent()
            //TO DO GAME OVER
        }
    }
    
    func bruteBulletPlayerCollision(bruteBullet: BruteBullet, player: Player) {
        
    }
    
    
    
    
    
}
