//
//  GameScene.swift
//  Bullet Hell v2
//
//  Created by Student on 7/6/16.
//  Copyright (c) 2016 Rahul Aggarwal. All rights reserved.
//

import Foundation
import SpriteKit

//Player
var player : Player!

//EnemyFactory
var enemyFactory : EnemyFactory!

//Physics Delegate
var physicsDelegate : PhysicsDelegate = PhysicsDelegate()

//Math
let Pi = CGFloat.pi;
let Deg2Rad = Pi / 180;
let Rad2Deg = 180 / Pi;

//Random Function
func random(low: Int, high: Int) -> Int {
    return Int(arc4random_uniform(UInt32(high - low))) + low
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

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Scrolling Effect
    let fog1 = SKSpriteNode(imageNamed: "Fog.png");
    let fog2 = SKSpriteNode(imageNamed: "Fog.png");
    let stars1_1 = SKSpriteNode(imageNamed: "normal.png");
    let stars1_2 = SKSpriteNode(imageNamed: "normal.png");
    let stars2_1 = SKSpriteNode(imageNamed: "normal_flipped.png");
    let stars2_2 = SKSpriteNode(imageNamed: "normal_flipped.png");
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        //VERY IMPORTANT FOR PHYSICS TO WORK
        physicsWorld.contactDelegate = self;
        
        //Background
        let background = SKSpriteNode(imageNamed: "back1.png");
        background.anchorPoint = CGPoint.zero;
        background.position = CGPoint.zero;
        background.zPosition = -30;
        background.size = self.frame.size;
        addChild(background);
        
        //Scrolling Effect
        
        //Fog1
        fog1.anchorPoint = CGPoint.zero;
        fog1.position = CGPoint.zero;
        fog1.zPosition = -29;
        fog1.size = self.frame.size;
        fog1.alpha = 0.2;
        addChild(fog1);
        
        //Fog2
        fog2.anchorPoint = CGPoint.zero;
        fog2.position = CGPoint(x: 0, y: fog2.size.height + 1)
        fog2.zPosition = -29;
        fog2.size = self.frame.size;
        fog2.alpha = 0.2;
        addChild(fog2);
        
        //Stars Layer 1
        
        //Stars1
        stars1_1.anchorPoint = CGPoint.zero;
        stars1_1.position = CGPoint.zero;
        stars1_1.zPosition = -28;
        stars1_1.size = self.frame.size;
        stars1_1.alpha = 0.15;
        addChild(stars1_1);
        
        //Stars2
        stars1_2.anchorPoint = CGPoint.zero;
        stars1_2.position = CGPoint.zero;
        stars1_2.zPosition = -28;
        stars1_2.size = self.frame.size;
        stars1_2.alpha = 0.15;
        addChild(stars1_2);
        
        //Stars Layer 2
        
        //Stars1
        stars2_1.anchorPoint = CGPoint.zero;
        stars2_1.position = CGPoint.zero;
        stars2_1.zPosition = -27;
        stars2_1.size = self.frame.size;
        stars2_1.alpha = 0.12;
        addChild(stars2_1);
        
        //Stars2
        stars2_2.anchorPoint = CGPoint.zero;
        stars2_2.position = CGPoint.zero;
        stars2_2.zPosition = -27;
        stars2_2.size = self.frame.size;
        stars2_2.alpha = 0.12;
        addChild(stars2_2);
        
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
            
            player.update(location: location)
        }
    }
    
    //Function for TOUCH AND DRAG
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
        
            player.update(location: location)
        }
    }
   
    
    //Update Function
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        //Fog Scrolling
        fog1.position = CGPoint(x: fog1.position.x, y: fog1.position.y - 4);
        fog2.position = CGPoint(x: fog2.position.x, y: fog2.position.y - 4);
        if (fog1.position.y < -fog1.size.height){
            fog1.position = CGPoint(x: fog1.position.x, y: fog2.position.y + fog2.size.height)
        }
        if (fog2.position.y < -fog2.size.height){
            fog2.position = CGPoint(x: fog2.position.x, y: fog1.position.y + fog1.size.height)
        }
        
        //Stars Layer 1 Scrolling
        stars1_1.position = CGPoint(x: stars1_1.position.x, y: stars1_1.position.y - 12);
        stars1_2.position = CGPoint(x: stars1_2.position.x, y: stars1_2.position.y - 12);
        if (stars1_1.position.y < -stars1_1.size.height){
            stars1_1.position = CGPoint(x: stars1_1.position.x, y: stars1_2.position.y + stars1_2.size.height)
        }
        if (stars1_2.position.y < -stars1_2.size.height){
            stars1_2.position = CGPoint(x: stars1_2.position.x, y: stars1_1.position.y + stars1_1.size.height)
        }
        
        //Stars Layer 2 Scrolling
        stars2_1.position = CGPoint(x: stars2_1.position.x, y: stars2_1.position.y - 6);
        stars2_2.position = CGPoint(x: stars2_2.position.x, y: stars2_2.position.y - 6);
        if (stars2_1.position.y < -stars2_1.size.height){
            stars2_1.position = CGPoint(x: stars2_1.position.x, y: stars2_2.position.y + stars2_2.size.height)
        }
        if (stars2_2.position.y < -stars2_2.size.height){
            stars2_2.position = CGPoint(x: stars2_2.position.x, y: stars2_1.position.y + stars2_1.size.height)
        }
        
        enemyFactory.update(currentTime: currentTime, playerPosition: player.position)
    
    }
}
