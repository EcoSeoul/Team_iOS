//
//  WaveViewElements.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//WaveGraph가 있는 뷰
//monthLabel, titleLabel, dataLbel, updownImage, percentLbel, 작년대비Label, WaveGraph, contentLabel로 구성
//Animation: updownImage(Hovering)

class WaveView: UIView{
    
    //이니셜라이저 변수
    var parentView: UIScrollView?
    var prePercent: Double? //전년도 퍼센트(회색물결)
    var curPercent: Double? //이번년도 퍼센트(색상물결)
    
    var waveGraph: WaveGraph?
    
    
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
    
    }
    
    func makeWaveGraph(){
        waveGraph = WaveGraph((parentView?.subviews.last)!, prePercent!, curPercent!)
    }
    
    
    
}
