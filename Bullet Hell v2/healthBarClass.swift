//
//  healthBarClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 12/25/17.
//  Copyright © 2017 DMA. All rights reserved.
//

import SpriteKit

class HealthBar : SKSpriteNode {
    
    init(healthBarWidth : Int, healthBarHeight : Int, hostile : Bool, health: Int, maxHealth : Int) {
        let barSize = CGSize(width: healthBarWidth, height: healthBarHeight)
        let fillColor = hostile ? UIColor(red: 178.0/255, green: 34.0/255, blue: 34.0/255, alpha:1) :  UIColor(red: 113.0/255, green: 202.0/255, blue: 53.0/255, alpha:1)
        let borderColor = UIColor(red: 35.0/255, green: 28.0/255, blue: 40.0/255, alpha:1)
        UIGraphicsBeginImageContextWithOptions(barSize, false, 0);
        let context = UIGraphicsGetCurrentContext();
        borderColor.setStroke();
        let borderRect = CGRect(origin: CGPoint.zero, size: barSize)
        context?.stroke(borderRect, width: hostile ? 1 : 2)
        fillColor.setFill();
        let barWidth = (barSize.width - (hostile ? 2 : 4)) * CGFloat(health/maxHealth)
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.width - (hostile ? 2 : 4))
        context?.fill(barRect)
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        super.init(texture: SKTexture(image: spriteImage!), color: UIColor.clear, size: barSize)
        if (hostile == false){
            self.position = CGPoint(x: 55, y: 10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: TimeInterval, hostile: Bool, position: CGPoint, positionOffset: CGFloat){
        if (hostile == true){
            self.position.x = position.x
            self.position.y = position.y + positionOffset
        }
        
    }
    
}