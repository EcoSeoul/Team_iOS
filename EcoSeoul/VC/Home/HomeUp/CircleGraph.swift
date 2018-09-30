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
//CircleLayer(grayLayer,colorLayer로 구성)
//durationLabel, percentageLabel, co2ValueLabel로 구성
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
    
    //CO2 VALUE
    let totalCarbon = UserDefaults.standard.integer(forKey: "totalCarbon")
    let pastTotalCarbon = UserDefaults.standard.integer(forKey: "pastTotalCarbon")
    
    //에니메이션 변수
    let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
    //기간 레이블
    var durationLabel: UILabel = {
        let termStart = UserDefaults.standard.integer(forKey: "termStart")
        let label = UILabel(frame: CGRect(x:0, y:0, width:196, height: 74))
        label.textAlignment = .center
        label.text = "\(termStart)월 ~ 8월"
        label.font = UIFont(name: notoSansFont.Regular.rawValue, size: 20)
        label.textColor = #colorLiteral(red: 0.3333333333, green: 0.3490196078, blue: 0.3647058824, alpha: 1)
        return label
    }()
    
    //CO2 전체 배출량 레이블
    var co2Label: UILabel = {
        let totalCarbon = UserDefaults.standard.integer(forKey: "totalCarbon")
        let label = UILabel(frame: CGRect(x:0, y:0, width:196, height: 64))
        label.textAlignment = .center
        label.font = UIFont(name: notoSansFont.Medium.rawValue, size: 38)
        label.text = "\(totalCarbon)kgCO2"
        label.sizeToFit()
        label.textColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        return label
    }()
    
    //업다운 이미지
    var updownImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:30, height: 20))
        return imageView
    }()


    //퍼센트 레이블
    var percentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:0, y:0, width:158, height: 320))
        label.textAlignment = .center
        label.font = UIFont(name: notoSansFont.Regular.rawValue, size: 20)
        return label
    }()
    
    //작년대비 레이블
    var nothingLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:0, y:0, width:60, height: 22))
        label.textAlignment = .center
        label.text = "작년대비"
        label.font = UIFont(name: notoSansFont.Light.rawValue, size: 15)
        label.textColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        return label
    }()
    
    
    init(_  parentView: UIView, _ percentage: Double){
        
        self.parentView = parentView;
        self.percentage = percentage;
        
        makeCircleLayer()
        
        durationLabel.center = CGPoint(x: parentView.layer.bounds.midX, y: 217)
        co2Label.center = CGPoint(x: parentView.layer.bounds.midX, y: 269.5)
        percentLabel.center = CGPoint(x: 166.5 , y: 326)
        updownImage.center = CGPoint(x: 133.5 , y: 326)
        nothingLabel.center = CGPoint(x: 220, y: 328)
        
        parentView.addSubview(durationLabel)
        parentView.addSubview(co2Label)
        parentView.addSubview(percentLabel)
        parentView.addSubview(updownImage)
        parentView.addSubview(nothingLabel)
        
    }

    
    func updateValue(_ percent: Double){
        self.percentage = percent
        animateCircle()
    }
    
    func makeCircleLayer(){
    
        guard let percent = percentage else {return}
        
        if percent > 0 {
            updownImage.image = #imageLiteral(resourceName: "percentage-down")
            percentLabel.textColor = #colorLiteral(red: 0.1490196078, green: 0.8156862745, blue: 0.4862745098, alpha: 1)
            colorLayer.strokeColor = #colorLiteral(red: 0.1490196078, green: 0.8156862745, blue: 0.4862745098, alpha: 1)
        }
        else {
            updownImage.image = #imageLiteral(resourceName: "percentage-up")
            percentLabel.textColor = #colorLiteral(red: 1, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
            colorLayer.strokeColor = #colorLiteral(red: 1, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
        }
        
        
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
      
        if percent < 0 {
            circleAnimation.toValue = -percent * 5
            circleAnimation.duration = -percent * 2 //* 5
        }
        else {
            circleAnimation.toValue = percent * 5
            circleAnimation.duration = percent * 2 //* 5
        }
    
        circleAnimation.fillMode = kCAFillModeForwards
        circleAnimation.isRemovedOnCompletion = false
        
        colorLayer.add(circleAnimation, forKey: "urSoBasic")
        
        //stackOverflow 빡빡이의 도움 (항시 인지)
        let displaylink = CADisplayLink(target: self, selector: #selector(updateLabel))
        displaylink.add(to: .current, forMode: .defaultRunLoopMode)
        loadingDisplayLink = displaylink
        
        
    }
    
    let small1 = CAShapeLayer()
    let small2 = CAShapeLayer()
    let small3 = CAShapeLayer()
    
    @objc func updateLabel(displayLink: CADisplayLink){
        
        let percent: CGFloat = colorLayer.presentation()?.value(forKeyPath: "strokeEnd") as? CGFloat ?? 0.0
        percentLabel.text = String(format: "% .f%%", percent * 100)
        
        if percent > 1 {
            displayLink.invalidate()
            loadingDisplayLink = nil
        }
       
        guard let per = percentage else {return}
        
        if per >= 0 {
            if percent >= 0.25 {small3.fillColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.5764705882, alpha: 1)}
            if percent >= 0.5  {small2.fillColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.5764705882, alpha: 1)}
            if percent >= 0.75 {small1.fillColor = #colorLiteral(red: 0, green: 0.8392156863, blue: 0.5764705882, alpha: 1)}
        }
        if per < 0 {
            if percent >= 0.25 {small3.fillColor = #colorLiteral(red: 1, green: 0.5333333333, blue: 0.5333333333, alpha: 1)}
            if percent >= 0.5  {small2.fillColor = #colorLiteral(red: 1, green: 0.5333333333, blue: 0.5333333333, alpha: 1)}
            if percent >= 0.75 {small1.fillColor = #colorLiteral(red: 1, green: 0.5333333333, blue: 0.5333333333, alpha: 1)}
        }
        
   
        
    }
}


