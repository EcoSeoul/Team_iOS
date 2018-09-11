//
//  HomeUpVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class HomeUpVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var pageControl = UIPageControl(frame: CGRect(x: 146, y: 50, width: 84, height: 12))
    
    //총 4개의 뷰(0:탄소,1:전기,2:수도,3:가스)
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
        return UIView(frame: scrollframe)
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
        self.pageControl.tintColor = UIColor.gray
        self.pageControl.pageIndicatorTintColor = UIColor.gray
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

    
    //탄소배출량 뷰 1개 생성
    func makeCircleView(){
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(1)
            scrollView.addSubview(viewArray[0])
            let circle = CircleGraph(viewArray[0], 0.84)
            circle.animateCircle()
    }
    
    //전기,수도,가스 뷰 3개 생성
    func makeWaveView(){
        for i in 1..<viewArray.count {
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i+1)
            scrollView.addSubview(viewArray[i])
            if i == 1{
                let wave1 = WaveGraph(viewArray[i], 0.7, 0.5)
            }
            if i == 2{
                let wave2 = WaveGraph(viewArray[i], 0.8, 0.4)
            }
            if i == 3{
                let wave3 = WaveGraph(viewArray[i], 0.65, 0.35)
            }
        }
    }

 

}
