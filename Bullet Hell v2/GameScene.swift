//
//  GameScene.swift
//  Bullet Hell v2
//
//  Created by Student on 7/6/16.
//  Copyright (c) 2016 Rahul Aggarwal. All rights reserved.
//

import Foundation
import SpriteKit

//World
var world : World!

//Player
var player : Player!

//EnemyFactory
var enemyFactory : EnemyFactory!

//Physics Delegate
var physicsDelegate : PhysicsDelegate!

//Math
let Pi = CGFloat.pi;
let Deg2Rad = Pi / 180;
let Rad2Deg = 180 / Pi;

//Random Function
func random(low: Int, high: Int) -> Int {
    return Int(arc4random_uniform(UInt32(high + 1 - low))) + low
}

//Sign Function
func sign(_ num : CGFloat) -> CGFloat{
    if (num < 0) {
        return -1;
    } else if (num > 0) {
        return 1;
    } else {
        return 0;
    }
}

//Point Towards Something
func pointTowards(_ x: CGFloat, y: CGFloat, x1: CGFloat, y1: CGFloat) -> CGFloat{
    let deltaX = x1 - x;
    let deltaY = y1 - y;
    let angle = atan2(deltaY, deltaX);
    return angle;
}

//Distance
func distanceTowards(_ x: CGFloat, y: CGFloat, x1: CGFloat, y1: CGFloat) -> CGFloat{
    let deltaX = x1 - x;
    let deltaY = y1 - y;
    let distance = sqrt(deltaX*deltaX + deltaY*deltaY);
    return distance;
}

//Map Function
func map(val: CGFloat, low1: CGFloat, high1: CGFloat, low2: CGFloat, high2: CGFloat) -> CGFloat{
    return (val - low1) / (high1 - low1) * (high2 - low2) + low2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        //VERY IMPORTANT FOR PHYSICS TO WORK
        physicsWorld.contactDelegate = self;
    
        world = World(gameScene: self)
        
        physicsDelegate = PhysicsDelegate(gameScene: self)
        
        player = Player(position: CGPoint(x: self.size.width/2, y: self.size.height/7), gameScene: self, health: 100, armor: 0)
        self.addChild(player)
        
        enemyFactory = EnemyFactory(gameScene: self);

    }
    
    //Physics and Contact
    func didBegin(_ contact: SKPhysicsContact) {
        
        physicsDelegate.didBegin(contact: contact)
        
//        //Designating First Body and Second Body
//        let firstBody : SKPhysicsBody = contact.bodyA;
//        let secondBody : SKPhysicsBody = contact.bodyB;
//
//        //Make sure contact nodes still exist
//        if((firstBody.node?.parent == nil) || (secondBody.node?.parent == nil)){
//            return;
//        }
        
        //Enemy - Type One Collision with Player Bullet
//        if ((firstBody.categoryBitMask == physicsCategory.enemyT1) && (secondBody.categoryBitMask == physicsCategory.playerBullet)) {
//        enemyT1CollisionWithPlayerBullet(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode);
//        } else if ((firstBody.categoryBitMask == physicsCategory.playerBullet) && (secondBody.categoryBitMask == physicsCategory.enemyT1)){
//        enemyT1CollisionWithPlayerBullet(secondBody.node as! SKSpriteNode, firstBody.node as! SKSpriteNode);
//        }
        
        //Enemy - Type Two Collision with Player Bullet
//        if((firstBody.categoryBitMask == physicsCategory.enemyT2) && (secondBody.categoryBitMask == physicsCategory.playerBullet)) {
//            enemyT2CollisionWithPlayerBullet(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode);
//        } else if((firstBody.categoryBitMask == physicsCategory.playerBullet) && (secondBody.categoryBitMask == physicsCategory.enemyT2)) {
//           enemyT2CollisionWithPlayerBullet(secondBody.node as! SKSpriteNode, firstBody.node as! SKSpriteNode);
//        }
        
        //Enemy - Type One Collision with Player
//        if((firstBody.categoryBitMask == physicsCategory.enemyT1) && (secondBody.categoryBitMask == physicsCategory.player)) {
//            enemyT1CollisionWithPlayer(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode);
//        } else if((firstBody.categoryBitMask == physicsCategory.player) && (secondBody.categoryBitMask == physicsCategory.enemyT1)){
//            enemyT1CollisionWithPlayer(secondBody.node as! SKSpriteNode, firstBody.node as! SKSpriteNode);
//        }
    }
    
    //Collisions
    
    //Enemy - Type One and Player Bullet
//    func enemyT1CollisionWithPlayerBullet(_ enemyT1: SKSpriteNode, _ playerBullet: SKSpriteNode){
//        let indexOfEnemy = enemyT1Sprites.index(of: enemyT1);
//        enemyT1Healths[indexOfEnemy!] -= Int(arc4random_uniform(11) + 30);
//        updateEnemyHealthBars(enemyT1HealthBars[indexOfEnemy!], withHealthPoints: enemyT1Healths[indexOfEnemy!], withMaxHP: t1MaxHealth);
//        playerBullet.removeFromParent();
//        if(enemyT1Healths[indexOfEnemy!] <= 0){
//            enemyT1.removeFromParent();
//            enemyT1Sprites.remove(at: indexOfEnemy!);
//            enemyT1HealthBars[indexOfEnemy!].removeFromParent();
//            enemyT1HealthBars.remove(at: indexOfEnemy!);
//            enemyT1Healths.remove(at: indexOfEnemy!);
//        }
//    }
    
    //Enemy - Type Two and Player Bullet
//    func enemyT2CollisionWithPlayerBullet(_ enemyT2: SKSpriteNode, _ playerBullet: SKSpriteNode){
//        let indexOfEnemy = enemyT2Sprites.index(of: enemyT2);
//        enemyT2Healths[indexOfEnemy!] -= Int(arc4random_uniform(11) + 30);
//        updateEnemyHealthBars(enemyT2HealthBars[indexOfEnemy!], withHealthPoints: enemyT2Healths[indexOfEnemy!], withMaxHP: t2MaxHealth);
//        playerBullet.removeFromParent();
//        if(enemyT2Healths[indexOfEnemy!] <= 0){
//            enemyT2.removeFromParent();
//            enemyT2Sprites.remove(at: indexOfEnemy!);
//            enemyT2HealthBars[indexOfEnemy!].removeFromParent();
//            enemyT2HealthBars.remove(at: indexOfEnemy!);
//            enemyT2Healths.remove(at: indexOfEnemy!);
//        } else {
//            let hit = SKAction.sequence([
//                SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0.15),
//                SKAction.wait(forDuration: 0.1),
//                SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.15),
//                ])
//            enemyT2.run(hit);
//        }
//    }
    
    //Enemy - Type One and Player
//    func enemyT1CollisionWithPlayer(_ enemyT1: SKSpriteNode, _ player: SKSpriteNode){
//        playerHP -= Int(arc4random_uniform(6) + 12);
//        updatePlayerHealthBar(playerHealthBar, withHealthPoints: playerHP, withMaxHP: playerMaxHealth);
//        if(playerHP <= 0){
//            playerHP = 0;
//            updatePlayerHealthBar(playerHealthBar, withHealthPoints: playerHP, withMaxHP: playerMaxHealth);
//            player.removeFromParent();
//            //TO DO: GAME OVER
//        }
//    }
    
    //Update Enemy - Type Two Bullet Position, Rotation, Speed, Timer
//    func updateEnemyT2Bullets(){
//        for bullet in enemyT2Bullets{
//            let indexOfBullet = enemyT2Bullets.index(of: bullet);
//            let bulletRotation = Rad2Deg * pointTowards(bullet.position.x, y: bullet.position.y, x1: player.position.x, y1: player.position.y);
//            let currentDegreesRotation = bullet.zRotation * Rad2Deg;
//            let rotateDegrees = ((((bulletRotation - currentDegreesRotation).truncatingRemainder(dividingBy: 360)) + 540 ).truncatingRemainder(dividingBy: 360)) - 180;
//            bullet.zRotation += Deg2Rad * (min(abs(rotateDegrees), 10) * sign(rotateDegrees));
//
//            enemyT2BulletVX[indexOfBullet!] = enemyT2BulletSpeed[indexOfBullet!] * (90 - abs(bullet.zRotation*Rad2Deg)) / 90;
//            if (bullet.zRotation < 0) {
//                enemyT2BulletVY[indexOfBullet!] = -enemyT2BulletSpeed[indexOfBullet!] + abs(enemyT2BulletVX[indexOfBullet!]);
//            } else {
//                enemyT2BulletVY[indexOfBullet!] = enemyT2BulletSpeed[indexOfBullet!] - abs(enemyT2BulletVX[indexOfBullet!]);
//            }
//
//            bullet.position.x += enemyT2BulletVX[indexOfBullet!];
//            bullet.position.y += enemyT2BulletVY[indexOfBullet!];
//
//            enemyT2BulletSpeed[indexOfBullet!] *= 1.01;
//
//            if (bullet.position.x < -bullet.size.width/2.0 || bullet.position.x > self.size.width+bullet.size.width/2.0 || bullet.position.y < -bullet.size.height/2.0 || bullet.position.y > self.size.height+bullet.size.height/2) {
//                bullet.removeFromParent();
//                enemyT2Bullets.remove(at: indexOfBullet!);
//                enemyT2BulletVX.remove(at: indexOfBullet!);
//                enemyT2BulletVY.remove(at: indexOfBullet!);
//                enemyT2BulletSpeed.remove(at: indexOfBullet!);
//            }
//        }
//    }
    
    //Function for SINGLE TOUCH
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.location(in: self);
            
            player.onTouch(location: location)
        }
    }
    
    //Function for TOUCH AND DRAG
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
        
            player.onTouch(location: location)
        }
    }
   
    
    //Update Function
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        world.update()
        player.update(currentTime: currentTime)
        enemyFactory.update(currentTime: currentTime, playerPosition: player.position)
    
    }
}
