//
//  DonationView.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//mainImageView, typeImage, titleLable
//explainLable, selectBtn, donateBtn 로 구성
//monthLabel, titleLabel, dataLbel

class DonationView: UIView{
    
    //이니셜라이저 변수
    var parentView: UIScrollView?
    
    //메인 이미지뷰
    var mainImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 305))
        imageView.image = #imageLiteral(resourceName: "donation-banner-1")
        return imageView
    }()
    
    //타이틀 레이블
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 59, y: 320, width: 203, height: 25))
        label.textAlignment = .left
        label.font = UIFont(name: notoSansFont.Medium.rawValue, size: 17)
        label.textColor = #colorLiteral(red: 0.2651461363, green: 0.2651531994, blue: 0.2651493847, alpha: 1)
        return label
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(_ parentView: UIScrollView){
        super.init(frame: parentView.frame)
        self.parentView = parentView

        identifyViews()
        
        parentView.subviews.last?.addSubview(mainImage)
        parentView.subviews.last?.addSubview(titleLabel)
  
        
    }
    
    func identifyViews(){
        
        if parentView?.subviews.last?.accessibilityIdentifier == "asia" {
            mainImage.image = #imageLiteral(resourceName: "donation-banner-1")
            titleLabel.text = "사막화 방지를 위한 나무 기부"
        }
        if parentView?.subviews.last?.accessibilityIdentifier ==  "forest" {
            mainImage.image = #imageLiteral(resourceName: "donation-banner-2")
            titleLabel.text = "사막화 방지를 위한 나무 기부"
        }
        if parentView?.subviews.last?.accessibilityIdentifier ==  "energy" {
            mainImage.image = #imageLiteral(resourceName: "donation-banner-3")
            titleLabel.text = "에너지 빈곤층을 위한 기부"
        }
    }
    
    
}
