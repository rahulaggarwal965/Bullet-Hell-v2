//
//  healthBarClass.swift
//  Bullet Hell v2
//
//  Created by Rahul Aggarwal on 1/8/18.
//  Copyright © 2018 DMA. All rights reserved.
//

import Foundation
import SpriteKit

class HealthBar : SKSpriteNode {
    
    var healthBarWidth : Int
    var healthBarHeight: Int
    var hostile: Bool
    var maxHealth : Int
    
    var barSize : CGSize
    var fillColor : UIColor
    var borderColor : UIColor
    var borderRect : CGRect

    init(healthBarWidth : Int, healthBarHeight : Int, hostile : Bool, health: Int, maxHealth : Int) {
        self.healthBarWidth = healthBarWidth
        self.healthBarHeight = healthBarHeight
        self.hostile = hostile
        self.maxHealth = maxHealth
        
        self.barSize = CGSize(width: healthBarWidth, height: healthBarHeight)
        self.fillColor = hostile ? UIColor(red: 178.0/255, green: 34.0/255, blue: 34.0/255, alpha:1) :  UIColor(red: 113.0/255, green: 202.0/255, blue: 53.0/255, alpha:1)
        self.borderColor = UIColor(red: 35.0/255, green: 28.0/255, blue: 40.0/255, alpha:1)
        UIGraphicsBeginImageContextWithOptions(barSize, false, 0);
        let context = UIGraphicsGetCurrentContext();
        borderColor.setStroke();
        self.borderRect = CGRect(origin: CGPoint.zero, size: barSize)
        context?.stroke(borderRect, width: hostile ? 1 : 2)
        fillColor.setFill();
        let barWidth = (barSize.width - (hostile ? 2 : 4)) * CGFloat(health) / CGFloat(maxHealth)
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.width - (hostile ? 2 : 4))
        context?.fill(barRect)
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        super.init(texture: SKTexture(image: spriteImage!), color: UIColor.clear, size: barSize)
        if (hostile == false){
            self.position = CGPoint(x: 55, y: 10)
        } else {
            self.position = CGPoint(x: 0, y: 37)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(health: Int) {
        UIGraphicsBeginImageContextWithOptions(barSize, false, 0);
        let context = UIGraphicsGetCurrentContext();
        borderColor.setStroke()
        context?.stroke(borderRect, width: self.hostile ? 1 : 2)
        fillColor.setFill()
        let barWidth = (barSize.width - (self.hostile ? 2 : 4)) * CGFloat(health) / CGFloat(self.maxHealth)
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.width - (self.hostile ? 2 : 4))
        context?.fill(barRect)
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.texture = SKTexture(image: spriteImage!)
    }
}

