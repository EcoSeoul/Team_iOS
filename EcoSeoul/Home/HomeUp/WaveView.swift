//
//  WaveViewElements.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//WaveGraph가 있는 뷰
//monthLabel, titleLabel, dataLbel
//updownImage, percentLbel, nothingLabel, WaveGraph, contentLabel로 구성
//Animation: updownImage(Hovering)

class WaveView: UIView{
    
    //이니셜라이저 변수
    var parentView: UIScrollView?
    var prePercent: Double? //전년도 퍼센트(회색물결)
    var curPercent: Double? //이번년도 퍼센트(색상물결)
    
    var waveGraph: WaveGraph!
    
    var percent: Int = 0
    
    //월 표시 레이블
    var monthLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 173, y: 92, width: 40, height: 29))
        label.textAlignment = .center
        label.font = UIFont(name: notoSansFont.Regular.rawValue, size: 20)
        return label
    }()
    
    //제목 레이블
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 120, y: 128, width: 136, height: 41))
        label.textAlignment = .center
        label.font = UIFont(name: notoSansFont.Regular.rawValue, size: 28)
        
        return label
    }()
    
    //데이터 레이블
    var dataLbel: UILabel = {
        let label = UILabel(frame: CGRect(x: 101, y: 164, width: 180, height: 59))
        label.textAlignment = .center
        label.font = UIFont(name: notoSansFont.Medium.rawValue, size: 40)
        
        return label
    }()
    
    // //업다운 이미지
    //  var updownImage: UIImage = {
    //
    //
    //
    //  }()

    //퍼센트 레이블
    var percentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:152, y:232, width:41, height: 29))
        label.textAlignment = .center
        label.font = UIFont(name: notoSansFont.Regular.rawValue, size: 20)
        label.textColor = #colorLiteral(red: 0.1490196078, green: 0.8156862745, blue: 0.4862745098, alpha: 1)
        return label
    }()
    
    //작년대비 레이블
    var nothingLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:197, y:238, width:70, height: 22))
        label.textAlignment = .center
        label.text = "작년대비"
        label.font = UIFont(name: notoSansFont.Light.rawValue, size: 15)
        label.textColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        return label
    }()
    
    //내용 레이블
    var contentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 23, y: 430, width: 287, height: 82))
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        label.font = UIFont(name: notoSansFont.Regular.rawValue, size: 27)
        label.textColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        return label
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(_ parentView: UIScrollView,_ prePercent: Double, _ curPercent: Double){
        super.init(frame: parentView.frame)
        
        self.parentView = parentView
        self.prePercent = prePercent
        self.curPercent = curPercent

        makeWaveGraph()
        identifyViews()
        

        parentView.subviews.last?.addSubview(monthLabel)
        parentView.subviews.last?.addSubview(titleLabel)
        parentView.subviews.last?.addSubview(dataLbel)
        parentView.subviews.last?.addSubview(percentLabel)
        parentView.subviews.last?.addSubview(percentLabel)
        parentView.subviews.last?.addSubview(contentLabel)
        parentView.subviews.last?.addSubview(nothingLabel)
    
    }
    
    func identifyViews(){
        
        monthLabel.text = "8월"
        dataLbel.text = "1000kWh"
        contentLabel.text = "작년보다 10%를 \n절약한 당신! 최고에요!"
        percentLabel.text = "10%"
        
        
        if parentView?.subviews.last?.accessibilityIdentifier == "electricity" {
            titleLabel.text = "전기 사용량"
        }
        if parentView?.subviews.last?.accessibilityIdentifier ==  "water" {
            titleLabel.text = "수도 사용량"
        }
        if parentView?.subviews.last?.accessibilityIdentifier ==  "gas" {
            titleLabel.text = "가스 사용량"
        }
    }
    
    
    func makeWaveGraph(){
        waveGraph = WaveGraph((parentView?.subviews.last)!, prePercent!, curPercent!)
        waveGraph.animateWave()
    }
    
    func animateView(){
        waveGraph.animateWave()
        
    }
    
    
}
