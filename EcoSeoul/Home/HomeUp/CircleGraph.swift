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

//CircleGraph의 클래스
//CircleLayer(grayLayer,colorLayer로 구성), durationLabel, percentageLabel, co2ValueLabel로 구성
//Animation: CircleLayer, co2ValueLabel

class CircleGraph{
    
    //이니셜라이저 변수
    var parentView: UIView?
    var percentage: Double?
    
    //감시자역할(원형의 로딩에 따라 퍼센트레이블 증가)
    var loadingDisplayLink: CADisplayLink?
    
    //두개의 레이어(배경테두리,색상테두리)
    let grayLayer = CAShapeLayer()
    let colorLayer = CAShapeLayer()
    let small1 = CAShapeLayer()
    let small2 = CAShapeLayer()
    let small3 = CAShapeLayer()
    
    //에니메이션 변수
    let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    //기간 레이블
    var durationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:0, y:0, width:196, height: 64))
        label.textAlignment = .center
        label.text = "4월 ~ 8월"
        label.font = UIFont(name: "NotoSansCJKkr-Regular", size: 20)
        label.textColor = UIColor(hexString: "#55595D")
        return label
    }()
    

    //퍼센트 레이블
    var percentageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:0, y:0, width:196, height: 64))
        label.textAlignment = .center
        label.font = UIFont(name: "NotoSansCJKkr-Medium", size: 38)
        label.textColor = UIColor(hexString: "#343434")
        return label
    }()
    
    
    
    init(_  parentView: UIView, _ percentage: Double){
        
        self.parentView = parentView;
        self.percentage = percentage;
        
        makeCircleLayer()
        
        durationLabel.center = CGPoint(x: parentView.layer.bounds.midX, y: 211.5)
        percentageLabel.center = CGPoint(x: parentView.layer.bounds.midX, y: 269.5)
        
        parentView.addSubview(durationLabel)
        parentView.addSubview(percentageLabel)
        
    }
    
    
    func updateValue(_ percent: Double){
        self.percentage = percent
        animateCircle()
    }
    
    func makeCircleLayer(){
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 132.5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let centerPoint =  CGPoint(x:(parentView?.layer.bounds.midX)!, y: 269.5)
        
        
        //1)create loading b.g. layer(color gray)
        grayLayer.path = circularPath.cgPath
        grayLayer.strokeColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
        grayLayer.lineWidth = 5
        grayLayer.fillColor = UIColor.clear.cgColor
        grayLayer.lineCap = kCALineCapRound //바가 조금더 라운디드 하게 만들어줌
        
        grayLayer.position = centerPoint
        
        parentView?.layer.addSublayer(grayLayer)
        
        //2)create loading layer(color red)
        colorLayer.path = circularPath.cgPath
        colorLayer.lineWidth = 5
        colorLayer.fillColor = UIColor.clear.cgColor
        colorLayer.lineCap = kCALineCapRound
        colorLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        colorLayer.position = centerPoint
        
        colorLayer.strokeEnd = 0
        
        parentView?.layer.addSublayer(colorLayer)
        
        //3)create small circles
    
        small1.path = UIBezierPath(arcCenter: .zero, radius: 8, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        small1.fillColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
        
        small2.path = UIBezierPath(arcCenter: .zero, radius: 8, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        small2.fillColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
        
        small3.path = UIBezierPath(arcCenter: .zero, radius: 8, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true).cgPath
        small3.fillColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.8, alpha: 1)
        
        small1.position = CGPoint(x:56.5 , y: 271.5)
        small2.position = CGPoint(x:187.5 , y:404)
        small3.position = CGPoint(x:318.5, y:271.5)
        
        parentView?.layer.addSublayer(small1)
        parentView?.layer.addSublayer(small2)
        parentView?.layer.addSublayer(small3)
        
    }
    
    
    //animate Effect
    func animateCircle() {
        
        guard let percent = percentage else {return}
        circleAnimation.toValue = percent
        circleAnimation.duration = percent * 1.5 // 속도 조절
        circleAnimation.fillMode = kCAFillModeForwards
        circleAnimation.isRemovedOnCompletion = false
        
        colorLayer.add(circleAnimation, forKey: "urSoBasic")
        
        //stackOverflow 빡빡이의 도움 (항시 인지)
        let displaylink = CADisplayLink(target: self, selector: #selector(updateLabel))
        displaylink.add(to: .current, forMode: .defaultRunLoopMode)
        loadingDisplayLink = displaylink
        
        
    }
    
    
    @objc func updateLabel(displayLink: CADisplayLink){
        
        let percent: CGFloat = colorLayer.presentation()?.value(forKeyPath: "strokeEnd") as? CGFloat ?? 0.0
        percentageLabel.text = String(format: "% .fkgCO2%", percent * 100)
        
            colorLayer.strokeColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.5764705882, alpha: 1)
         if percent >= 0.25 {small3.fillColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.5764705882, alpha: 1)}
         if percent >= 0.5  {small2.fillColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.5764705882, alpha: 1)}
         if percent >= 0.75 {small1.fillColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.5764705882, alpha: 1)}
        
//        if percent <= 0.25 {
//            colorLayer.strokeColor = #colorLiteral(red: 1, green: 0.6156862745, blue: 0.3764705882, alpha: 1)
//        }
//
//        else if percent <= 0.5 {
//            colorLayer.strokeColor = #colorLiteral(red: 0.4431372549, green: 0.8509803922, blue: 1, alpha: 1)
//        }
//
//        else if percent >= 0.75 {
//            colorLayer.strokeColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.5764705882, alpha: 1)
//        }
        
        if percent > 1 {
            displayLink.invalidate()
            loadingDisplayLink = nil
        }
        
    }
}


