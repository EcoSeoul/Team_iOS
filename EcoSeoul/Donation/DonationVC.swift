//
//  DonationVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//ScrollView로 횡단 스크롤이 가능
//pageControl 필요

class DonationVC: UIViewController {
    
    @IBOutlet weak var horizontalScroll: UIScrollView!
    var pageControl = UIPageControl(frame: CGRect(x: 166, y: 635, width: 43, height: 8.57))
    
    var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "arrow-left-black")
        btn.tintColor = UIColor.black
        btn.width = -40
        btn.action = #selector(popSelf)
        return btn
    }()
    
    
    //총 3개의 뷰 배열 생성 (3가지 Donation)
    lazy var viewArray: [UIView] = {
        let width = self.horizontalScroll.frame.width
        var arr: [UIView] = []
        for i in 0..<3 {
            arr.append(self.viewInstance(xPostion: width * CGFloat(i)))
        }
        arr[0].accessibilityIdentifier = "asia"
        arr[1].accessibilityIdentifier = "forest"
        arr[2].accessibilityIdentifier = "energy"
        
        return arr
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalScroll.delegate = self;
        setNaviBar()
        makePageControl()
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
        makeDonationView()
    }

    
}

extension DonationVC{
    
    ////////////Navigation Bar 관련////////////
 
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
    
    ////////////뷰 구성(도네이션 뷰) ////////////
    
    private func viewInstance(xPostion: CGFloat) -> UIView {
        let scrollframe = CGRect(x: xPostion, y: 0, width: self.horizontalScroll.frame.width, height: self.horizontalScroll.frame.height)
        return DonationView(frame: scrollframe)
    }
    
    //3개의 View 생성(아시아,미래 숲,에너지)
    func  makeDonationView(){
        for i in 0..<viewArray.count {
            horizontalScroll.contentSize.width = horizontalScroll.frame.width * CGFloat(i+1)
            horizontalScroll.addSubview(viewArray[i])
            viewArray[i] = DonationView(self.horizontalScroll)
        }
    }
    
    ////////////////////////////////////
    
    
    ////Page Control (위에 인덱싱 표시) 구현부 ////
    
    func makePageControl(){
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
//        self.pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
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






