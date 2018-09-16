//
//  WaveGraph.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//WaveLayer(grayLayer,colorLayer로 구성) 
//Animation: WaveLayer(grayLayer,colorLayer) - 물결흐르는 에니메이션 + 밑에서 위로 올라가는 에니메이션(예정)

class WaveGraph{
    
    //이니셜라이저 변수
    var parentView: UIView?
    var prePercent: Double? //전년도 퍼센트(회색물결)
    var curPercent: Double? //이번년도 퍼센트(색상물결)
    
    //두개의 레이어(배경테두리,색상테두리)
    let grayLayer = CAShapeLayer()
    let colorLayer = CAShapeLayer()
    
    //에니메이션 변수(아직 미적용)
    let waveAnimation = CABasicAnimation(keyPath: "StrokeEnd")
    
    init(_ parentView: UIView,_ prePercent: Double, _ curPercent: Double){
        
        self.parentView = parentView
        self.prePercent = prePercent
        self.curPercent = curPercent
        
        makeWaveLayer()
    }
    
    func makeWaveLayer(){
        
        let grayCenterY = (self.parentView?.frame.height)! * CGFloat(1 - prePercent!)
        let colorCenterY = (self.parentView?.frame.height)! * CGFloat(1 - curPercent!)
        
        let graysteps = 62
        let graystepX = (self.parentView?.frame.width)! / CGFloat(graysteps)
        
        let colorsteps = 53
        let colorstepX = (self.parentView?.frame.width)! / CGFloat(colorsteps)
        
        let grayLayerPath = UIBezierPath()
        let colorLayerPath = UIBezierPath()
        
        ////////////////gray Layer////////////////
        grayLayerPath.move(to: CGPoint(x: 0, y: (self.parentView?.frame.height)!))
        grayLayerPath.addLine(to: CGPoint(x: 0, y: grayCenterY))

        for i in 0...graysteps {
            let x = CGFloat(i) * graystepX 
            let y = (0.65*cos(Double(i+graysteps*3/2) * 0.1) * 40) + Double(grayCenterY)
            grayLayerPath.addLine(to: CGPoint(x: x, y: CGFloat(y)))
        }
        
        grayLayerPath.addLine(to: CGPoint(x: (self.parentView?.frame.width)!, y: (self.parentView?.frame.height)!) )
        grayLayerPath.close()
        
        grayLayer.path = grayLayerPath.cgPath
        grayLayer.fillColor = CGColor.color(hexString: "#C7C7CC")
        parentView?.layer.addSublayer(grayLayer)
        //////////////////////////////////////////
        
        //////////////color Layer////////////////
        colorLayerPath.move(to: CGPoint(x: 0, y: (self.parentView?.frame.height)!))
        colorLayerPath.addLine(to: CGPoint(x: 0, y: colorCenterY))

        for i in 0...colorsteps {
            let x = CGFloat(i) * colorstepX
            let y = (0.75 * sin(Double(colorsteps-i) * 0.1) * 40) + Double(colorCenterY)
            colorLayerPath.addLine(to: CGPoint(x: x, y: CGFloat(y)))
        }
        
        colorLayerPath.addLine(to: CGPoint(x: (self.parentView?.frame.width)!, y: (self.parentView?.frame.height)!) )
        colorLayerPath.close()
        colorLayer.path = colorLayerPath.cgPath
        
        //Identify views
        if parentView?.accessibilityIdentifier == "electricity"{
            colorLayer.fillColor = #colorLiteral(red: 0.9803921569, green: 0.8705882353, blue: 0.262745098, alpha: 1)
        }
        if parentView?.accessibilityIdentifier == "water"{
            colorLayer.fillColor = #colorLiteral(red: 0.2666666667, green: 0.5254901961, blue: 0.9411764706, alpha: 1)
        }
        if parentView?.accessibilityIdentifier == "gas"{
            colorLayer.fillColor = #colorLiteral(red: 0.8352941176, green: 0.6941176471, blue: 1, alpha: 1)
        }
       
        colorLayer.strokeStart = 0
        colorLayer.strokeEnd = 0
        parentView?.layer.addSublayer(colorLayer)
        //////////////////////////////////////////
    }
    
    func animateWave(){
    
        waveAnimation.fromValue = 0
        waveAnimation.toValue = 1
        waveAnimation.duration = 3
        colorLayer.add(waveAnimation, forKey: "strokeEnd")
        
    }
    
    
    
}
