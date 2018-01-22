//
//  worldClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/21/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class World {
    
    //Scrolling Effect
    let fog1 = SKSpriteNode(imageNamed: "Fog.png");
    let fog2 = SKSpriteNode(imageNamed: "Fog.png");
    let stars1_1 = SKSpriteNode(imageNamed: "normal.png");
    let stars1_2 = SKSpriteNode(imageNamed: "normal.png");
    let stars2_1 = SKSpriteNode(imageNamed: "normal_flipped.png");
    let stars2_2 = SKSpriteNode(imageNamed: "normal_flipped.png");
    
    init(gameScene: SKScene){
        
        let background = SKSpriteNode(imageNamed: "back1.png");
        background.anchorPoint = CGPoint.zero;
        background.position = CGPoint.zero;
        background.zPosition = -30;
        background.size = gameScene.frame.size;
        gameScene.addChild(background);
        
        //Scrolling Effect
        
        //Fog1
        fog1.anchorPoint = CGPoint.zero;
        fog1.position = CGPoint.zero;
        fog1.zPosition = -29;
        fog1.size = gameScene.frame.size;
        fog1.alpha = 0.2;
        gameScene.addChild(fog1);
        
        //Fog2
        fog2.anchorPoint = CGPoint.zero;
        fog2.position = CGPoint(x: 0, y: fog2.size.height + 1)
        fog2.zPosition = -29;
        fog2.size = gameScene.frame.size;
        fog2.alpha = 0.2;
        gameScene.addChild(fog2);
        
        //Stars Layer 1
        
        //Stars1
        stars1_1.anchorPoint = CGPoint.zero;
        stars1_1.position = CGPoint.zero;
        stars1_1.zPosition = -28;
        stars1_1.size = gameScene.frame.size;
        stars1_1.alpha = 0.15;
        gameScene.addChild(stars1_1);
        
        //Stars2
        stars1_2.anchorPoint = CGPoint.zero;
        stars1_2.position = CGPoint.zero;
        stars1_2.zPosition = -28;
        stars1_2.size = gameScene.frame.size;
        stars1_2.alpha = 0.15;
        gameScene.addChild(stars1_2);
        
        //Stars Layer 2
        
        //Stars1
        stars2_1.anchorPoint = CGPoint.zero;
        stars2_1.position = CGPoint.zero;
        stars2_1.zPosition = -27;
        stars2_1.size = gameScene.frame.size;
        stars2_1.alpha = 0.12;
        gameScene.addChild(stars2_1);
        
        //Stars2
        stars2_2.anchorPoint = CGPoint.zero;
        stars2_2.position = CGPoint.zero;
        stars2_2.zPosition = -27;
        stars2_2.size = gameScene.frame.size;
        stars2_2.alpha = 0.12;
        gameScene.addChild(stars2_2)
    }
    
    func update() {
        
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
    }
    
    
}
