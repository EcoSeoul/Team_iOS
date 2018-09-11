//
//  WaveGraph.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class WaveGraph{
    
    //이니셜라이저 변수
    var parentView: UIView?
    var prePercent: Double? //전년도 퍼센트(회색물결)
    var curPercent: Double? //이번년도 퍼센트(색상물결)
    
    //두개의 레이어(배경테두리,색상테두리)
    let grayLayer = CAShapeLayer()
    let colorLayer = CAShapeLayer()
    
    init(_ parentView: UIView,_ prePercent: Double, _ curPercent: Double){
        
        self.parentView = parentView
        self.prePercent = prePercent
        self.curPercent = curPercent
        
        makeWaveLayer()
    }
    
    func makeWaveLayer(){
        
        let grayCenterY = (self.parentView?.frame.height)! * CGFloat(1 - prePercent!)
        let colorCenterY = (self.parentView?.frame.height)! * CGFloat(1 - curPercent!)
        
        let graysteps = 90
        let graystepX = (self.parentView?.frame.width)! / CGFloat(graysteps)
        
        let colorsteps = 53
        let colorstepX = (self.parentView?.frame.width)! / CGFloat(colorsteps)
        
        let grayLayerPath = UIBezierPath()
        let colorLayerPath = UIBezierPath()
        
        //gray Layer
        grayLayerPath.move(to: CGPoint(x: 0, y: (self.parentView?.frame.height)!))
        grayLayerPath.addLine(to: CGPoint(x: 0, y: grayCenterY))
    
            print(cos(Double(Double.pi/2)))
            print(cos(Double(Double.pi)))
        
        for i in 0...graysteps {
            let x = CGFloat(i) * graystepX 
            let y = (0.65*cos(Double(graysteps-i) * 0.1) * 40) + Double(grayCenterY)

            //cos 0 = 1
            //cos pi/2 = 0
            grayLayerPath.addLine(to: CGPoint(x: x, y: CGFloat(y)))
        }
        
        grayLayerPath.addLine(to: CGPoint(x: (self.parentView?.frame.width)!, y: (self.parentView?.frame.height)!) )  // Draw down to the lower right
        grayLayerPath.close()
        grayLayer.path = grayLayerPath.cgPath
        
        grayLayer.fillColor = CGColor.color(from: "C7C7CC")
        
        parentView?.layer.addSublayer(grayLayer)
        
        //color Layer
        colorLayerPath.move(to: CGPoint(x: 0, y: (self.parentView?.frame.height)!))
        colorLayerPath.addLine(to: CGPoint(x: 0, y: colorCenterY))
        
        for i in 0...colorsteps {
            let x = CGFloat(i) * colorstepX
            let y = (0.75 * sin(Double(colorsteps-i) * 0.1) * 40) + Double(colorCenterY)
            
            colorLayerPath.addLine(to: CGPoint(x: x, y: CGFloat(y)))
        }
        
        colorLayerPath.addLine(to: CGPoint(x: (self.parentView?.frame.width)!, y: (self.parentView?.frame.height)!) )  // Draw down to the lower right
        colorLayerPath.close()
        colorLayer.path = colorLayerPath.cgPath
        
        //Identify views
        if parentView?.accessibilityIdentifier == "electricity"{
            colorLayer.fillColor = CGColor.color(from: "FFF471")
        }
        if parentView?.accessibilityIdentifier == "water"{
             colorLayer.fillColor = CGColor.color(from: "71D9FF")
        }
        if parentView?.accessibilityIdentifier == "gas"{
             colorLayer.fillColor = CGColor.color(from: "FF9D60")
        }
       
        colorLayer.strokeStart = 0
        colorLayer.strokeEnd = 0
        
        parentView?.layer.addSublayer(colorLayer)
        
        
    }
    
    
    
    func animateWave(){
        let waveAnimation = CABasicAnimation(keyPath: "strokeEnd")
        waveAnimation.fromValue = 0
        waveAnimation.toValue = 1
        waveAnimation.duration = 3
        colorLayer.add(waveAnimation, forKey: "strokeEnd")
        
    }
    
    
    
}
