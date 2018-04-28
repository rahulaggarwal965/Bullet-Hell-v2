////
////  barClass.swift
////  Bullet Hell v2
////
////  Created by Rahul Aggarwal on 1/28/18.
////  Copyright © 2018 DMA. All rights reserved.
////
//
//import Foundation
//import SpriteKit
//
//class Bar : SKSpriteNode {
//    
//    var maxResource : Int
//    var barSize : CGSize
//    var fillColor : UIColor
//    var borderColor : UIColor
//    var borderRect : CGRect
//    
//    init(barWidth : Int, barHeight : Int, resource: Int, maxResource : Int, fillColor: UIColor, borderColor: UIColor) {
//        
//        self.maxResource = maxResource
//        self.barSize = CGSize(width: barWidth, height: barHeight)
//        self.fillColor = fillColor
//        self.borderColor = borderColor
//        UIGraphicsBeginImageContextWithOptions(barSize, false, 0);
//        let context = UIGraphicsGetCurrentContext();
//        self.borderColor.setStroke();
//        self.borderRect = CGRect(origin: CGPoint.zero, size: barSize)
//        context?.stroke(borderRect, width: hostile ? 1 : 2)
//        self.fillColor.setFill();
//        let barWidth = (barSize.width - (hostile ? 2 : 4)) * CGFloat(resource) / CGFloat(maxResource)
//        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.width - (hostile ? 2 : 4))
//        context?.fill(barRect)
//        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        super.init(texture: SKTexture(image: spriteImage!), color: UIColor.clear, size: barSize)
//        if (hostile == false){
//            self.position = CGPoint(x: 55, y: 10)
//        } else {
//            self.position = CGPoint(x: 0, y: 37)
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func update(resource: Int) {
//        UIGraphicsBeginImageContextWithOptions(barSize, false, 0);
//        let context = UIGraphicsGetCurrentContext();
//        borderColor.setStroke()
//        context?.stroke(borderRect, width: self.hostile ? 1 : 2)
//        fillColor.setFill()
//        let barWidth = (barSize.width - (self.hostile ? 2 : 4)) * CGFloat(resource) / CGFloat(self.maxResource)
//        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.width - (self.hostile ? 2 : 4))
//        context?.fill(barRect)
//        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        self.texture = SKTexture(image: spriteImage!)
//    }
//}

