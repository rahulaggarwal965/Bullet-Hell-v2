//
//  GameScene.swift
//  Bullet Hell v2
//
//  Created by Student on 7/6/16.
//  Copyright (c) 2016 Rahul Aggarwal. All rights reserved.
//

import SpriteKit

//Player and Enemy Animations
var player  : SKSpriteNode!;
var playerFlyingFrames : [SKTexture]!;
var enemyT1 : SKSpriteNode!;
var enemyT1FlyingFrames : [SKTexture]!;
var enemyT2 : SKSpriteNode!;
var enemyT2FlyingFrames : [SKTexture]!;

//Health Bars
let playerMaxHealth = 100;
let t1MaxHealth = 40;
let t2MaxHealth = 120;
let playerHealthBarWidth : CGFloat = 100;
let playerHealthBarHeight : CGFloat = 10;
let enemyHealthBarWidth : CGFloat = 40;
let enemyHealthBarHeight : CGFloat = 4;
var t1HealthBar : SKSpriteNode!;
var t2HealthBar : SKSpriteNode!;

//PHYSICS
struct physicsCategory {
    
    //Enemies
    static let enemyT1 : UInt32 = 1;
    static let enemyT2 : UInt32 = 2;
    
    //Bullets
    static let playerBullet : UInt32 = 3;
    static let enemyT2Bullet: UInt32 = 5;
    
    //Player
    static let player : UInt32 = 4;
    
}

//Math
let Pi = CGFloat.pi;
let Deg2Rad = Pi / 180;
let Rad2Deg = 180 / Pi;

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Tracking Enemies
    var enemyT1Sprites: [SKSpriteNode] = [];
    var enemyT2Sprites: [SKSpriteNode] = [];
    
    //Tracking Bullets and Bullet Attributes
    var enemyT2BulletCooldown : [CFTimeInterval] = [];
    var enemyT2BulletSpeed : [CGFloat] = [];
    var enemyT2BulletEase : CGFloat = 5;
    var enemyT2Bullets: [SKSpriteNode] = [];
    var enemyT2BulletVX: [CGFloat] = [];
    var enemyT2BulletVY: [CGFloat] = []
    
    //Tracking Health and Health Bars for Enemies
    var enemyT1HealthBars: [SKSpriteNode] = [];
    var enemyT2HealthBars: [SKSpriteNode] = [];
    var enemyT1Healths: [Int] = [];
    var enemyT2Healths: [Int] = [];
    
    //Health Bars
    let playerHealthBar = SKSpriteNode();
    var playerHP = playerMaxHealth;
    var t1HP = t1MaxHealth;
    var t2HP = t2MaxHealth;
    
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
        
        //Animation and Position Info
        
        //Enemy - Type One
        

        //let enemyT1PositionInfo : NSDictionary = ["xStart": CGFloat(arc4random_uniform(UInt32(self.size.width - enemyT1.size.width) - UInt32(enemyT1.size.width)) + UInt32(enemyT1.size.width)), "yStart": CGFloat(self.size.height)]
        
        //Spawners and Timers
        let playerBulletTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(spawnPlayerBullets), userInfo: nil, repeats: true);
        let enemyT1Timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(spawnEnemyT1), userInfo: nil, repeats: true);
        let enemyT2Timer = Timer.scheduledTimer(timeInterval: 5.3, target: self, selector: #selector(spawnEnemyT2), userInfo: nil, repeats: true);
        //let enemyT1GroupTimer = NSTimer.scheduledTimerWithTimeInterval(8.0, target:  self, selector: #selector(), userInfo: nil, repeats:  true);
        
        //Player Animation
        let playerAnimatedAtlas = SKTextureAtlas(named: "playerImagesv1");
        var playerFlyFrames = [SKTexture]();
        let playerNumImages = playerAnimatedAtlas.textureNames.count;
        for i in 1 ... playerNumImages {
            let playerTextureName = "spaceShip\(i)";
            playerFlyFrames.append(playerAnimatedAtlas.textureNamed(playerTextureName));
        }
        playerFlyingFrames = playerFlyFrames;
        let playerFirstFrame = playerFlyingFrames[0];
        player = SKSpriteNode(texture: playerFirstFrame);
        
        //Player Position, Physics, and Spawning
        player.position = CGPoint(x: self.size.width/2, y: self.size.height/7);
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size);
        player.physicsBody?.affectedByGravity = false;
        player.physicsBody?.categoryBitMask = physicsCategory.player;
        player.physicsBody?.contactTestBitMask = physicsCategory.enemyT1 | physicsCategory.enemyT2;
        player.physicsBody?.collisionBitMask = 0;
        player.physicsBody?.isDynamic = false;
        self.addChild(player);
        flyingPlayer();
        
        //Player Health Bar
        playerHealthBar.position = CGPoint(x: 0, y: 10);
        self.addChild(playerHealthBar);
        updatePlayerHealthBar(playerHealthBar, withHealthPoints: playerHP, withMaxHP: playerMaxHealth);
    }
    
    //Physics and Contact
    func didBegin(_ contact: SKPhysicsContact) {
        
        //Designating First Body and Second Body
        let firstBody : SKPhysicsBody = contact.bodyA;
        let secondBody : SKPhysicsBody = contact.bodyB;
        
        //Make sure contact nodes still exist
        if((firstBody.node?.parent == nil) || (secondBody.node?.parent == nil)){
            return;
        }
        
        //Enemy - Type One Collision with Player Bullet
        if ((firstBody.categoryBitMask == physicsCategory.enemyT1) && (secondBody.categoryBitMask == physicsCategory.playerBullet)) {
        enemyT1CollisionWithPlayerBullet(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode);
        } else if ((firstBody.categoryBitMask == physicsCategory.playerBullet) && (secondBody.categoryBitMask == physicsCategory.enemyT1)){
        enemyT1CollisionWithPlayerBullet(secondBody.node as! SKSpriteNode, firstBody.node as! SKSpriteNode);
        }
        
        //Enemy - Type Two Collision with Player Bullet
        if((firstBody.categoryBitMask == physicsCategory.enemyT2) && (secondBody.categoryBitMask == physicsCategory.playerBullet)) {
            enemyT2CollisionWithPlayerBullet(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode);
        } else if((firstBody.categoryBitMask == physicsCategory.playerBullet) && (secondBody.categoryBitMask == physicsCategory.enemyT2)) {
           enemyT2CollisionWithPlayerBullet(secondBody.node as! SKSpriteNode, firstBody.node as! SKSpriteNode);
        }
        
        //Enemy - Type One Collision with Player
        if((firstBody.categoryBitMask == physicsCategory.enemyT1) && (secondBody.categoryBitMask == physicsCategory.player)) {
            enemyT1CollisionWithPlayer(firstBody.node as! SKSpriteNode, secondBody.node as! SKSpriteNode);
        } else if((firstBody.categoryBitMask == physicsCategory.player) && (secondBody.categoryBitMask == physicsCategory.enemyT1)){
            enemyT1CollisionWithPlayer(secondBody.node as! SKSpriteNode, firstBody.node as! SKSpriteNode);
        }
    }
    
    //Collisions
    
    //Enemy - Type One and Player Bullet
    func enemyT1CollisionWithPlayerBullet(_ enemyT1: SKSpriteNode, _ playerBullet: SKSpriteNode){
        let indexOfEnemy = enemyT1Sprites.index(of: enemyT1);
        enemyT1Healths[indexOfEnemy!] -= Int(arc4random_uniform(11) + 30);
        updateEnemyHealthBars(enemyT1HealthBars[indexOfEnemy!], withHealthPoints: enemyT1Healths[indexOfEnemy!], withMaxHP: t1MaxHealth);
        playerBullet.removeFromParent();
        if(enemyT1Healths[indexOfEnemy!] <= 0){
            enemyT1.removeFromParent();
            enemyT1Sprites.remove(at: indexOfEnemy!);
            enemyT1HealthBars[indexOfEnemy!].removeFromParent();
            enemyT1HealthBars.remove(at: indexOfEnemy!);
            enemyT1Healths.remove(at: indexOfEnemy!);
        }
    }
    
    //Enemy - Type Two and Player Bullet
    func enemyT2CollisionWithPlayerBullet(_ enemyT2: SKSpriteNode, _ playerBullet: SKSpriteNode){
        let indexOfEnemy = enemyT2Sprites.index(of: enemyT2);
        enemyT2Healths[indexOfEnemy!] -= Int(arc4random_uniform(11) + 30);
        updateEnemyHealthBars(enemyT2HealthBars[indexOfEnemy!], withHealthPoints: enemyT2Healths[indexOfEnemy!], withMaxHP: t2MaxHealth);
        playerBullet.removeFromParent();
        if(enemyT2Healths[indexOfEnemy!] <= 0){
            enemyT2.removeFromParent();
            enemyT2Sprites.remove(at: indexOfEnemy!);
            enemyT2HealthBars[indexOfEnemy!].removeFromParent();
            enemyT2HealthBars.remove(at: indexOfEnemy!);
            enemyT2Healths.remove(at: indexOfEnemy!);
        } else {
            let hit = SKAction.sequence([
                SKAction.colorize(with: UIColor.white, colorBlendFactor: 1.0, duration: 0.15),
                SKAction.wait(forDuration: 0.1),
                SKAction.colorize(withColorBlendFactor: 0.0, duration: 0.15),
                ])
            enemyT2.run(hit);
        }
    }
    
    //Enemy - Type One and Player
    func enemyT1CollisionWithPlayer(_ enemyT1: SKSpriteNode, _ player: SKSpriteNode){
        playerHP -= Int(arc4random_uniform(6) + 12);
        updatePlayerHealthBar(playerHealthBar, withHealthPoints: playerHP, withMaxHP: playerMaxHealth);
        if(playerHP <= 0){
            playerHP = 0;
            updatePlayerHealthBar(playerHealthBar, withHealthPoints: playerHP, withMaxHP: playerMaxHealth);
            player.removeFromParent();
            //TO DO: GAME OVER
        }
    }
    
    
    
    //Player Animation Function
    func flyingPlayer(){
        player.run(SKAction.repeatForever(SKAction.animate(with: playerFlyingFrames, timePerFrame: 0.05, resize: false, restore: true)), withKey: "flyingPlayer");
    }
    
    //Spawning Player Bullets
    @objc func spawnPlayerBullets(){
        
        if (playerHP > 0){
            
            //Bullet Texture
            let bullet = SKSpriteNode(imageNamed: "playerBulletv2.png");
        
            //Bullet Position, Physics, and Spawning
            bullet.zPosition = -5;
            bullet.position = CGPoint(x: player.position.x, y: player.position.y);
            let action = SKAction.moveTo(y: self.size.height + player.position.y, duration: 1.3);
            let actionDone = SKAction.removeFromParent();
            bullet.run(SKAction.sequence([action, actionDone]));
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bullet.physicsBody?.categoryBitMask = physicsCategory.playerBullet;
            bullet.physicsBody?.contactTestBitMask = physicsCategory.enemyT1 | physicsCategory.enemyT2;
            bullet.physicsBody?.collisionBitMask = 0;
            bullet.physicsBody?.affectedByGravity = false;
            bullet.physicsBody?.isDynamic = false;
        
            self.addChild(bullet);
        }
    }
    
    //Spawning Enemy - Type Two Bullets
    func spawnEnemyT2Bulets(_ enemy : SKSpriteNode){
            
        //When To Spawn Bullets
        if(enemy.position.y > 0){
            
            //Bullet Texture
            let bullet = SKSpriteNode(imageNamed: "enemyBullet.png");
            bullet.setScale(2);
            
            //Bullet Heat Seeking Attributes
            enemyT2Bullets.append(bullet);
            enemyT2BulletVX.append(0);
            enemyT2BulletVY.append(0);
            enemyT2BulletSpeed.append(30);
        
            //Bullet Position, Physics, and Spawning
            bullet.zPosition = -5;
            bullet.zRotation = -90 * Deg2Rad;
            bullet.position = CGPoint(x: enemy.position.x, y: enemy.position.y);
            bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size);
            bullet.physicsBody?.categoryBitMask = physicsCategory.enemyT2Bullet;
            bullet.physicsBody?.contactTestBitMask = physicsCategory.player;
            bullet.physicsBody?.collisionBitMask = 0;
            bullet.physicsBody?.affectedByGravity = false;
            bullet.physicsBody?.isDynamic = false;
            self.addChild(bullet);
        }
    }
    
    
    //Spawning Enemy - Type One
    @objc func spawnEnemyT1(_ timer: Timer){
        
        let enemyT1AnimatedAtlas = SKTextureAtlas(named: "enemyT1Images")
        var enemyT1FlyFrames = [SKTexture]();
        let enemyT1NumImages = enemyT1AnimatedAtlas.textureNames.count;
        for i in 1 ... enemyT1NumImages {
            let enemyT1TextureName = "soldier\(i)";
            enemyT1FlyFrames.append(enemyT1AnimatedAtlas.textureNamed(enemyT1TextureName));
        }
        enemyT1FlyingFrames = enemyT1FlyFrames;
        let enemyT1FirstFrame = enemyT1FlyingFrames[0];
        enemyT1 = SKSpriteNode(texture: enemyT1FirstFrame);
        enemyT1Sprites.append(enemyT1);
        
        //Enemy - Type One Position, Physics, and Spawnin
        //let positionInfo = timer.userInfo;
        //print(timer.userInfo, terminator: "");
        //print(positionInfo["xStart"]);
        //print(positionInfo["yStart"]);
        enemyT1.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(self.size.width - enemyT1.size.width) - UInt32(enemyT1.size.width)) + UInt32(enemyT1.size.width)), y: CGFloat(self.size.height));
        enemyT1.physicsBody = SKPhysicsBody(rectangleOf: enemyT1.size);
        enemyT1.physicsBody?.categoryBitMask = physicsCategory.enemyT1;
        enemyT1.physicsBody?.contactTestBitMask = physicsCategory.player | physicsCategory.playerBullet;
        enemyT1.physicsBody?.affectedByGravity = false;
        enemyT1.physicsBody?.collisionBitMask = 0;
        enemyT1.physicsBody?.isDynamic = true;
        let action = SKAction.moveTo(y: -enemyT1.size.height, duration: 3.0);
        let actionDone = SKAction.removeFromParent();
        enemyT1.run(SKAction.sequence([action, actionDone]));
        self.addChild(enemyT1);
        flyingEnemyT1();
        
        //Health and Health Bars
        t1HealthBar = SKSpriteNode();
        updateEnemyHealthBars(t1HealthBar, withHealthPoints: t1HP, withMaxHP: t1MaxHealth);
        enemyT1HealthBars.append(t1HealthBar);
        enemyT1Healths.append(t1HP);
        t1HealthBar.position = CGPoint(x: enemyT1.position.x,y:  enemyT1.position.y + 17);
        self.addChild(t1HealthBar);

    }
    
    //Enemy - Type One Animation Function
    func flyingEnemyT1(){
        enemyT1.run(SKAction.repeatForever(SKAction.animate(with: enemyT1FlyingFrames, timePerFrame: 0.05, resize: false, restore: true)), withKey: "flyingEnemyT1");
    }
    
    //Spawning Enemy - Type Two
    @objc func spawnEnemyT2(){
        
        //Enemy - Type Two Animation
        let enemyT2AnimatedAtlas = SKTextureAtlas(named: "enemyT2Images");
        var enemyT2FlyFrames = [SKTexture]();
        let enemyT2NumImages = enemyT2AnimatedAtlas.textureNames.count;
        for i in 1 ... enemyT2NumImages {
            let enemyT2TextureName = "brute\(i)";
            enemyT2FlyFrames.append(enemyT2AnimatedAtlas.textureNamed(enemyT2TextureName));
        }
        enemyT2FlyingFrames = enemyT2FlyFrames;
        let enemyT2FirstFrame = enemyT2FlyingFrames[0];
        enemyT2 = SKSpriteNode(texture: enemyT2FirstFrame);
        enemyT2Sprites.append(enemyT2);
        
        //Bullet
        enemyT2BulletCooldown.append(0);
        
        //Enemy - Type Two Position, Physics, and Spawning
        let minValue = UInt32(enemyT2.size.width);
        let maxValue = UInt32(self.size.width - enemyT2.size.width);
        enemyT2.position = CGPoint(x: CGFloat(arc4random_uniform(maxValue - minValue) + minValue), y: self.size.height);
        enemyT2.physicsBody = SKPhysicsBody(rectangleOf: enemyT2.size);
        enemyT2.physicsBody?.categoryBitMask = physicsCategory.enemyT2;
        enemyT2.physicsBody?.contactTestBitMask = physicsCategory.player | physicsCategory.playerBullet;
        enemyT2.physicsBody?.affectedByGravity = false;
        enemyT2.physicsBody?.collisionBitMask = 0;
        enemyT2.physicsBody?.isDynamic = true;
        let action = SKAction.moveTo(y: -enemyT2.size.height, duration: 7.0);
        let actionDone = SKAction.removeFromParent();
        enemyT2.run(SKAction.sequence([action, actionDone]));
        self.addChild(enemyT2);
        flyingEnemyT2();
        
        //Health and Health Bars
        t2HealthBar = SKSpriteNode();
        updateEnemyHealthBars(t2HealthBar, withHealthPoints: t2HP, withMaxHP: t2MaxHealth);
        enemyT2HealthBars.append(t2HealthBar);
        enemyT2Healths.append(t2HP);
        t2HealthBar.position = CGPoint(x: enemyT2.position.x,y: enemyT2.position.y + 27);
        self.addChild(t2HealthBar);
    }
    
    //Enemy - Type Two Animation Function
    func flyingEnemyT2(){
        enemyT2.run(SKAction.repeatForever(SKAction.animate(with: enemyT2FlyingFrames, timePerFrame: 0.05, resize: false, restore: true)), withKey: "flyingEnemyT2");
    }
    
    //Update Enemy Health Bars Positions
    func updateEnemyHealthBarPositions(){
        
        //Enemy - Type One Health Bar
        for enemy in enemyT1Sprites {
            let indexOfEnemy = enemyT1Sprites.index(of: enemy);
            enemyT1HealthBars[indexOfEnemy!].position  = CGPoint(x: enemy.position.x,y:  enemy.position.y + 17);
        }
        
        //Enemy - Type Two Health Bar
        for enemy in enemyT2Sprites {
            let indexOfEnemy = enemyT2Sprites.index(of: enemy);
            enemyT2HealthBars[indexOfEnemy!].position  = CGPoint(x: enemy.position.x,y:  enemy.position.y + 27);
        }
    }
    
    //Update Player Health Bar
    func updatePlayerHealthBar(_ node: SKSpriteNode, withHealthPoints hp: Int, withMaxHP maxHP: Int){
        let barSize = CGSize(width: playerHealthBarWidth, height: playerHealthBarHeight);
        let fillColor = UIColor(red: 113.0/255, green: 202.0/255, blue: 53.0/255, alpha:1);
        let borderColor = UIColor(red: 35.0/255, green: 28.0/255, blue: 40.0/255, alpha:1);
        UIGraphicsBeginImageContextWithOptions(barSize, false, 0);
        let context = UIGraphicsGetCurrentContext();
        borderColor.setStroke();
        let borderRect = CGRect(origin: CGPoint.zero, size: barSize);
        context?.stroke(borderRect, width: 2);
        fillColor.setFill();
        let barWidth = (barSize.width - 2) * CGFloat(hp) / CGFloat(maxHP);
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.height - 2);
        context?.fill(barRect);
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        node.texture = SKTexture(image: spriteImage!)
        node.size = barSize;
        node.position = CGPoint(x: 55,y: 10);
    }
    
    //Update Enemy Health Bars
    func updateEnemyHealthBars(_ node: SKSpriteNode, withHealthPoints hp: Int, withMaxHP maxHP: Int){
        let barSize = CGSize(width: enemyHealthBarWidth, height: enemyHealthBarHeight);
        let fillColor = UIColor(red: 178.0/255, green: 34.0/255, blue: 34.0/255, alpha:1);
        let borderColor = UIColor(red: 35.0/255, green: 28.0/255, blue: 40.0/255, alpha:1);
        UIGraphicsBeginImageContextWithOptions(barSize, false, 0);
        let context = UIGraphicsGetCurrentContext();
        borderColor.setStroke();
        let borderRect = CGRect(origin: CGPoint.zero, size: barSize);
        context?.stroke(borderRect, width: 1);
        fillColor.setFill();
        let barWidth = (barSize.width - 1) * CGFloat(hp) / CGFloat(maxHP);
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.height - 1);
        context?.fill(barRect);
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        node.texture = SKTexture(image: spriteImage!)
        node.size = barSize;
    }
    
    //Update Enemy - Type Two Bullet Position, Rotation, Speed, Timer
    func updateEnemyT2Bullets(){
        for bullet in enemyT2Bullets{
            let indexOfBullet = enemyT2Bullets.index(of: bullet);
            let bulletRotation = Rad2Deg * pointTowards(bullet.position.x, y: bullet.position.y, x1: player.position.x, y1: player.position.y);
            let currentDegreesRotation = bullet.zRotation * Rad2Deg;
            let rotateDegrees = ((((bulletRotation - currentDegreesRotation).truncatingRemainder(dividingBy: 360)) + 540 ).truncatingRemainder(dividingBy: 360)) - 180;
            bullet.zRotation += Deg2Rad * (min(abs(rotateDegrees), 10) * sign(rotateDegrees));
            
            enemyT2BulletVX[indexOfBullet!] = enemyT2BulletSpeed[indexOfBullet!] * (90 - abs(bullet.zRotation*Rad2Deg)) / 90;
            if (bullet.zRotation < 0) {
                enemyT2BulletVY[indexOfBullet!] = -enemyT2BulletSpeed[indexOfBullet!] + abs(enemyT2BulletVX[indexOfBullet!]);
            } else {
                enemyT2BulletVY[indexOfBullet!] = enemyT2BulletSpeed[indexOfBullet!] - abs(enemyT2BulletVX[indexOfBullet!]);
            }

            bullet.position.x += enemyT2BulletVX[indexOfBullet!];
            bullet.position.y += enemyT2BulletVY[indexOfBullet!];
            
            enemyT2BulletSpeed[indexOfBullet!] *= 1.01;
            
            if (bullet.position.x < -bullet.size.width/2.0 || bullet.position.x > self.size.width+bullet.size.width/2.0 || bullet.position.y < -bullet.size.height/2.0 || bullet.position.y > self.size.height+bullet.size.height/2) {
                bullet.removeFromParent();
                enemyT2Bullets.remove(at: indexOfBullet!);
                enemyT2BulletVX.remove(at: indexOfBullet!);
                enemyT2BulletVY.remove(at: indexOfBullet!);
                enemyT2BulletSpeed.remove(at: indexOfBullet!);
            }
        }
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
    
    //Function for SINGLE TOUCH
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.location(in: self);
            
            //Player Position
            player.position.x = location.x;
            player.position.y = location.y;
        }
    }
    
    //Function for TOUCH AND DRAG
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self);
            
            //Player Position
            player.position.x = location.x;
            player.position.y = location.y;
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
        
        //Enemy - Type Two Bullets
        for enemy in enemyT2Sprites {
            let indexOfBullet = enemyT2Sprites.index(of: enemy);
            if (currentTime - enemyT2BulletCooldown[indexOfBullet!] >= 3) {
                spawnEnemyT2Bulets(enemy);
                enemyT2BulletCooldown[indexOfBullet!] = currentTime;
            }
        }
        
        
        //Enemy Health Bars
        updateEnemyHealthBarPositions();
        
        //Enemy - Type Two Bullets
        updateEnemyT2Bullets();
    
    }
}
