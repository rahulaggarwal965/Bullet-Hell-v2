//
//  GameScene.swift
//  Bullet Hell v2
//
//  Created by Student on 7/6/16.
//  Copyright (c) 2016 DMA. All rights reserved.
//

import SpriteKit

var player  : SKSpriteNode!;
var playerFlyingFrames : [SKTexture]!;
var enemyT1 : SKSpriteNode!;
var enemyT1FlyingFrames : [SKTexture]!;

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let bulletTimer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(spawnBullets), userInfo: nil, repeats: true);
        let enemyT1Timer = NSTimer.scheduledTimerWithTimeInterval(2.0 /* Maybe Change? */, target: self, selector: #selector(spawnEnemyT1), userInfo: nil, repeats: true)
        
        let playerAnimatedAtlas = SKTextureAtlas(named: "playerImagesv1");
        var playerFlyFrames = [SKTexture]();
        let playerNumImages = playerAnimatedAtlas.textureNames.count;
        for var i=1; i<=playerNumImages; i += 1 {
            let playerTextureName = "spaceShip\(i)";
            playerFlyFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName));
        }
        playerFlyingFrames = playerFlyFrames;
        let playerFirstFrame = playerFlyingFrames[0];
        player = SKSpriteNode(texture: playerFirstFrame);
        player.position = CGPointMake(self.size.width/2, self.size.height/7);
        self.addChild(player);
        flyingPlayer();
       
    }
    
    func flyingPlayer(){
        player.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(playerFlyingFrames, timePerFrame: 0.05, resize: false, restore: true)), withKey: "flyingPlayer");
    }
    
    func spawnBullets(){
        let Bullet = SKSpriteNode(imageNamed: "playerBulletv2.png");
        Bullet.zPosition = -5;
        Bullet.position = CGPointMake(player.position.x, player.position.y);
        let action = SKAction.moveToY(self.size.height + 30, duration: 0.9);
        Bullet.runAction(SKAction.repeatActionForever(action));
        self.addChild(Bullet);
    }
    
    func spawnEnemyT1(){
        let enemyT1AnimatedAtlas = SKTextureAtlas(named: "enemyT1Images")
        var enemyT1FlyFrames = [SKTexture]();
        let enemyT1NumImages = enemyT1AnimatedAtlas.textureNames.count;
        for var i=1; i<=enemyT1NumImages; i += 1 {
            let enemyT1TextureName = "soldier\(i)";
            enemyT1FlyFrames.append(enemyT1AnimatedAtlas.textureNamed(enemyT1TextureName));
        }
        enemyT1FlyingFrames = enemyT1FlyFrames;
        let enemyT1FirstFrame = enemyT1FlyingFrames[0];
        enemyT1 = SKSpriteNode(texture: enemyT1FirstFrame);
//        let type = arc4random_uniform(4);
//        print(type);
//        if (type == 3) {
//            let T1threeMinValue = self.size.width / 5;
//            let T1threeMaxValue = self.size.width - 40;
//            let T1threeSpawnPoint = UInt32(T1threeMaxValue - T1threeMinValue);
//            let T1threeSetSpawnPoint = arc4random_uniform(T1threeSpawnPoint)
//            enemyT1.position = CGPointMake(CGFloat(T1threeSetSpawnPoint - 15), self.size.height + 20);
//            let action = SKAction.moveToY(-30, duration: 3.0);
//            enemyT1.runAction(SKAction.repeatActionForever(action));
//            self.addChild(enemyT1);
//            flyingEnemyT1()
//            enemyT1.position = CGPointMake(CGFloat(T1threeSetSpawnPoint + 15), self.size.height + 20);
//            enemyT1.runAction(SKAction.repeatActionForever(action));
//            self.addChild(enemyT1);
//            flyingEnemyT1()
//            enemyT1.position = CGPointMake(CGFloat(T1threeSetSpawnPoint), self.size.height - 10);
//            enemyT1.runAction(SKAction.repeatActionForever(action));
//            self.addChild(enemyT1);
//            flyingEnemyT1()
//        } else {
            let T1minValue = self.size.width / 8;
            let T1maxValue = self.size.width - 20
            let T1spawnPoint = UInt32(T1maxValue - T1minValue);
            enemyT1.position = CGPointMake(CGFloat(arc4random_uniform(T1spawnPoint)), self.size.height);
            let action = SKAction.moveToY(-30, duration: 3.0);
            enemyT1.runAction(SKAction.repeatActionForever(action));
            self.addChild(enemyT1);
            flyingEnemyT1()
       // }
    }
    
    func flyingEnemyT1(){
        enemyT1.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(enemyT1FlyingFrames, timePerFrame: 0.05, resize: false, restore: true)), withKey: "flyingEnemyT1");
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self);
            
            player.position.x = location.x;
            player.position.y = location.y;
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self);
            
            player.position.x = location.x;
            player.position.y = location.y;
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
