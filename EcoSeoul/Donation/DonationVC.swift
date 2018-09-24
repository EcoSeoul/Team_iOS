//
//  DonationVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//ScrollView로 횡단 스크롤이 가능
//mainImageView, typeImage, titleLable, explainLable, selectBtn, donateBtn 필요
//pageControl 필요

class DonationVC: UIViewController {
    
    @IBOutlet weak var horizontalScroll: UIScrollView!
    var pageControl = UIPageControl(frame: CGRect(x: 166, y: 620, width: 43, height: 8.57))
    
    //총 3개의 뷰 배열 생성 (3가지 Donation)
    lazy var viewArray: [UIView] = {
        let width = self.horizontalScroll.frame.width
        var arr: [UIView] = []
        for i in 0..<3 {
            arr.append(self.viewInstance(xPostion: width * CGFloat(i)))
        }
        return arr
    }()
    
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
        label.text = "사막화 방지를 위한 나무 기부"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalScroll.delegate = self;
        setNaviBar()
        makePageControl()
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
        viewArray[0].addSubview(mainImage)
        viewArray[0].addSubview(titleLabel)
    }
    
    ////////////Navigation Bar 관련////////////
    var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "arrow-left-black")
        btn.tintColor = UIColor.black
        btn.width = -40
        btn.action = #selector(popSelf)
        return btn
    }()
    
    
    @objc func popSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    func setNaviBar(){
        backBtn.target = self
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        let item: UINavigationItem = self.navigationItem
        
        item.leftBarButtonItem = backBtn
        item.leftBarButtonItem?.imageInsets.left = -15
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
    }
    ///////////////////////////////////////
    
    
}


extension DonationVC: UIScrollViewDelegate{
    
    private func viewInstance(xPostion: CGFloat) -> UIView {
        let scrollframe = CGRect(x: xPostion, y: 0, width: self.horizontalScroll.frame.width, height: self.horizontalScroll.frame.height)
        return UIView(frame: scrollframe)
    }
    
    
    ////Page Control (위에 인덱싱 표시) 구현부 ////
    func makePageControl(){
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.view.addSubview(pageControl)
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * horizontalScroll.frame.width
        horizontalScroll.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print("현재 Horizontal 인덱스 = \(pageControl.currentPage)")
    }
    /////////////////////////////////////
    
    
}








//    //총 4개의 뷰 배열 생성(0:탄소,1:전기,2:수도,3:가스)
//    lazy var viewArray: [UIView] = {
//
//        let width = self.horizontalScroll.frame.width
//        var arr: [UIView] = []
//        for i in 0..<4 {
//            arr.append(self.viewInstance(xPostion: width * CGFloat(i)))
//        }
//        arr[1].accessibilityIdentifier = "electricity"
//        arr[2].accessibilityIdentifier = "water"
//        arr[3].accessibilityIdentifier = "gas"
//
//        return arr
//    }()



//1. 뷰 구성(원형그래프 뷰 + 웨이브 뷰)
//extension HomeUpVC {
//
//    private func viewInstance(xPostion: CGFloat) -> UIView {
//        let scrollframe = CGRect(x: xPostion, y: 0, width: self.horizontalScroll.frame.width, height: self.horizontalScroll.frame.height)
//
//        if xPostion == 0 {
//            return CircleView(frame: scrollframe)
//        }
//        else {
//            return WaveView(frame: scrollframe)
//        }
//    }
//
//    //탄소배출량 뷰 1개 생성(index:0)
//    func makeCircleView(){
//        horizontalScroll.contentSize.width = horizontalScroll.frame.width * CGFloat(1)
//        horizontalScroll.addSubview(viewArray[0])
//        viewArray[0] = CircleView(self.horizontalScroll, co2Value)
//    }
//
//    //전기,수도,가스 뷰 3개 생성(indx:1~3)
//    func makeWaveView(){
//        for i in 1..<viewArray.count {
//            horizontalScroll.contentSize.width = horizontalScroll.frame.width * CGFloat(i+1)
//            horizontalScroll.addSubview(viewArray[i])
//            viewArray[i] = WaveView(self.horizontalScroll, preValue[i-1], curVlaue[i-1])
//        }
//    }
//
//}

//2. 페이지 컨트롤 구성(인덱싱)



