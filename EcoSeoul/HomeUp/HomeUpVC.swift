//
//  HomeUpVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//ScrollView로 횡단 스크롤이 가능
//자식뷰로 CircleView(Index:0),WaveView(Index:1~3)을 추가
//pageControl과 HomeAllBtn 필요 

class HomeUpVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var co2Value: Double = 0.85                 //탄소배출 저감률
    var preValue: [Double] = [0.7, 0.8, 0.65]   //작년 데이터(전기,수도,가스)
    var curVlaue: [Double] = [0.5, 0.6, 0.45]   //올해 데이터(전기,수도,가스)
    
    var pageControl = UIPageControl(frame: CGRect(x: 146, y: 50, width: 84, height: 12))
    
    //총 4개의 뷰 배열 생성(0:탄소,1:전기,2:수도,3:가스)
    lazy var viewArray: [UIView] = {
        
        let width = self.scrollView.frame.width
        var arr: [UIView] = []
        for i in 0..<4 {
            arr.append(self.viewInstance(xPostion: width * CGFloat(i)))
        }
        arr[1].accessibilityIdentifier = "electricity"
        arr[2].accessibilityIdentifier = "water"
        arr[3].accessibilityIdentifier = "gas"
        
        return arr
    }()
    
    private func viewInstance(xPostion: CGFloat) -> UIView {
        
        let scrollframe = CGRect(x: xPostion, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
        
        if xPostion == 0 {
            return CircleView(frame: scrollframe)
        }
        else {
            return WaveView(frame: scrollframe)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self;
        
        configurePageControl()
        makeCircleView()
        makeWaveView()
        
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func configurePageControl(){
        self.pageControl.numberOfPages = viewArray.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.lightGray
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }

    
    //탄소배출량 뷰 1개 생성(index:0)
    func makeCircleView(){
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(1)
            scrollView.addSubview(viewArray[0])
            viewArray[0] = CircleView(self.scrollView, co2Value)
    }
    
    //전기,수도,가스 뷰 3개 생성(indx:1~3)
    func makeWaveView(){
        for i in 1..<viewArray.count {
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i+1)
            scrollView.addSubview(viewArray[i])
            viewArray[i] = WaveView(self.scrollView, preValue[i-1], curVlaue[i-1])
        }
    }

 

}
