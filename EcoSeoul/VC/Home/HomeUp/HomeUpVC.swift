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

class HomeUpVC: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var horizontalScroll: UIScrollView!
    var pageControl = UIPageControl(frame: CGRect(x: 146, y: 30, width: 84, height: 12))
    @IBOutlet weak var homeAllBtn: UIButton!
    
    //CO2 VALUE(Circle)
    var co2Percent: Double = 0.0
    var totalCarbon: Int = 0
    var pastTotalCarbon: Int = 0
    
    //ELEC,WATER,GAS VALUE(Wave)
    var preValue: [Double] = [0.55, 0.6, 0.7]   //작년 데이터(전기,수도,가스)
    var curVlaue: [Double] = [0.47, 0.5, 0.45]  //올해 데이터(전기,수도,가스)
    
     
    //총 4개의 뷰 배열 생성(0:탄소,1:전기,2:수도,3:가스)
    lazy var viewArray: [UIView] = {
        
        let width = self.horizontalScroll.frame.width
        var arr: [UIView] = []
        for i in 0..<4 {
            arr.append(self.viewInstance(xPostion: width * CGFloat(i)))
        }
        arr[1].accessibilityIdentifier = "electricity"
        arr[2].accessibilityIdentifier = "water"
        arr[3].accessibilityIdentifier = "gas"
        
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalScroll.delegate = self;
        initValue()
        makeCircleView()
        makeWaveView()
        makePageControl()
        
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(homeAllBtn)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


    //서버에서 받은 현재 탄소배출량, 과거 탄소 배출량, 절약률을 계산
    func initValue(){
        totalCarbon = UserDefaults.standard.integer(forKey: "totalCarbon")
        pastTotalCarbon = UserDefaults.standard.integer(forKey: "pastTotalCarbon")
        co2Percent = Double(pastTotalCarbon - totalCarbon) / Double(pastTotalCarbon)
    }
    
    //홈 모아보기 버튼 클릭
    @IBAction func homeAllPressed(_ sender: Any) {
        let homeSubStoryboard = UIStoryboard.init(name: "HomeSub", bundle: nil)
        let homeallVC = homeSubStoryboard.instantiateViewController(withIdentifier: "HomeAllVC") as? HomeAllVC
        self.present(homeallVC!, animated: true, completion: nil)
    }
    

}



//1. 뷰 구성(원형그래프 뷰 + 웨이브 뷰)
extension HomeUpVC {
    
    private func viewInstance(xPostion: CGFloat) -> UIView {
        let scrollframe = CGRect(x: xPostion, y: 0, width: self.horizontalScroll.frame.width, height: self.horizontalScroll.frame.height)
        
        if xPostion == 0 {
            return CircleView(frame: scrollframe)
        }
        else {
            return WaveView(frame: scrollframe)
        }
    }
    
    //탄소배출량 뷰 1개 생성(index:0)
    func makeCircleView(){
        horizontalScroll.contentSize.width = horizontalScroll.frame.width * CGFloat(1)
        horizontalScroll.addSubview(viewArray[0])
        viewArray[0] = CircleView(self.horizontalScroll, co2Percent)
    }
    
    //전기,수도,가스 뷰 3개 생성(indx:1~3)
    func makeWaveView(){
        for i in 1..<viewArray.count {
            horizontalScroll.contentSize.width = horizontalScroll.frame.width * CGFloat(i+1)
            horizontalScroll.addSubview(viewArray[i])
            viewArray[i] = WaveView(self.horizontalScroll, preValue[i-1], curVlaue[i-1])
        }
    }
    
}

//2. 페이지 컨트롤 구성(인덱싱)

extension HomeUpVC {
    
    ////Page Control (위에 인덱싱 표시) 구현부 ////
    func makePageControl(){
        self.pageControl.numberOfPages = 4
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


