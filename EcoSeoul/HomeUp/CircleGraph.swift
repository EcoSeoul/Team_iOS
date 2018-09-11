//
//  CircleGraph.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//
// 1) Progress Circular Graph 만드는 법
// https://www.youtube.com/watch?v=O3ltwjDJaMk
// 2) 빡빡이가 알려주는 그래프 애니메이션을 감지하여 Label 수치도 같이 움직이게 하는 법
// https://stackoverflow.com/questions/50423624/how-to-set-the-label-to-count-to-the-given-percentage-on-custom-progress-bar

import UIKit

class CircleGraph{
    
    //이니셜라이저 변수
    var parentView: UIView?
    var percentage: Double?
    
    var loadingDisplayLink: CADisplayLink?
    
    //두개의 레이어(배경테두리,색상테두리)
    let grayLayer = CAShapeLayer()
    let colorLayer = CAShapeLayer()
    
    //에니메이션 변수
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    //퍼센트 레이블
    var percentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    init(_  parentView: UIView, _ percentage: Double){
        
        self.parentView = parentView;
        self.percentage = percentage;
        
        makePercentageLabel()
        makeLoadingLayer()
        
    }
    
    //퍼센트 레이블 만들기
    func makePercentageLabel(){
        parentView?.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x:0, y:0, width:150, height: 100)
        percentageLabel.center = CGPoint(x:(parentView?.layer.bounds.midX)!, y:(parentView?.layer.bounds.midY)!)
        
    }
    
    func updateValue(_ percent: Double){
        self.percentage = percent
        animateCircle()
    }
    
    func makeLoadingLayer(){
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 142, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let centerPoint =  CGPoint(x:(parentView?.layer.bounds.midX)!, y:(parentView?.layer.bounds.midY)!)
        
        
        //1)create loading b.g. layer(color gray)
        grayLayer.path = circularPath.cgPath
        grayLayer.strokeColor = CGColor.color(from: "C7C7CC")
        grayLayer.lineWidth = 10
        grayLayer.fillColor = UIColor.clear.cgColor
        grayLayer.lineCap = kCALineCapRound //바가 조금더 라운디드 하게 만들어줌
        
        grayLayer.position = centerPoint
        
        parentView?.layer.addSublayer(grayLayer)
        
        //2)create loading layer(color red)
        colorLayer.path = circularPath.cgPath
        colorLayer.strokeColor = UIColor.red.cgColor
        colorLayer.lineWidth = 10
        colorLayer.fillColor = UIColor.clear.cgColor
        colorLayer.lineCap = kCALineCapRound
        colorLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        colorLayer.position = centerPoint
        
        colorLayer.strokeEnd = 0
        
        parentView?.layer.addSublayer(colorLayer)
    }
    
    
    //animate Effect
    func animateCircle() {
        
        guard let percent = percentage else {return}
        basicAnimation.toValue = percent
        basicAnimation.duration = percent * 1.5 // 속도 조절
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        colorLayer.add(basicAnimation, forKey: "urSoBasic")
        
        //stackOverflow 빡빡이의 도움 (항시 인지)
        let displaylink = CADisplayLink(target: self, selector: #selector(updateLabel))
        displaylink.add(to: .current, forMode: .defaultRunLoopMode)
        loadingDisplayLink = displaylink
        
        
    }
    
    
    @objc func updateLabel(displayLink: CADisplayLink){
        
        let percent: CGFloat = colorLayer.presentation()?.value(forKeyPath: "strokeEnd") as? CGFloat ?? 0.0
        percentageLabel.text = String(format: "% .f%%", percent * 100)
        
        if percent <= 0.25 {
            colorLayer.strokeColor = CGColor.color(from: "FF9D60")
        }
            
        else if percent <= 0.5 {
            colorLayer.strokeColor = CGColor.color(from: "71D9FF")
        }
            
        else if percent >= 0.75 {
            colorLayer.strokeColor = CGColor.color(from: "FFF471")
        }
        
        if percent > 1 {
            displayLink.invalidate()
            loadingDisplayLink = nil
        }
        
    }
}


