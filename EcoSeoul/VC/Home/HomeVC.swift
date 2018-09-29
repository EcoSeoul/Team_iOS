//
//  HomeVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.

//HomeUpVC 와 HomeDownVC 를 관리하는 ScrollView(Vertical)
//downBtn을 이곳에서 추가(VC1에서 VC2로 내려가는 제어가 필요해서)
//Animation: downBtn(Hovering)


import UIKit

class HomeVC: UIViewController, APIService {
    
    let userDefault = UserDefaults.standard
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    
    //HomeVC Elements
    @IBOutlet weak var verticalScroll: UIScrollView!
    var homeUpVC: HomeUpVC?
    var homeDownVC: HomeDownVC?
    
    var downBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 162, y: 512, width: 50 , height: 50))
        button.setImage(#imageLiteral(resourceName: "arrow-down-black"), for: .normal)
        button.addTarget(self, action: #selector(downBtnTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        verticalScroll.delegate = self;
        setVC()
        network()
        self.view.subviews[0].addSubview(downBtn)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         network()
         downBtnAnimate()
    }

    
    func network(){
         mainDataInit(url : url("/home/\(userIdx)"))
    }
    
    func mainDataInit(url : String){
        MainService.shareInstance.getMain(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let data):
                self.setDB(data as! MainData)
                break
            case .networkFail :
                self.simpleAlert(title: "network", message: "네트워크상태를 확인해주세요 :)")
                break
            default :
                break
            }
        })
        
    }
    
    func setDB(_ data: MainData){
        //CircleView(Carbon)
        self.userDefault.set(data.term[0], forKey: "termStart")
        self.userDefault.set(data.usageData.carbonData.present, forKey: "totalCarbon")
        self.userDefault.set(data.usageData.carbonData.past, forKey: "pastTotalCarbon")
        self.userDefault.set(data.usageData.carbonData.updown, forKey: "carbonUpDown")
        
        //WaveView(Elec,Water,Gas)
        let elecData = data.usageData.elecData
        let waterData = data.usageData.waterData
        let gasData = data.usageData.gasData
        
        self.userDefault.set(elecData.past, forKey: "elecPast")
        self.userDefault.set(elecData.present, forKey: "elecPresent")
        self.userDefault.set(elecData.percent, forKey: "elecPercent")
        self.userDefault.set(elecData.updown, forKey: "elecUpDown")
        
        self.userDefault.set(waterData.past, forKey: "waterPast")
        self.userDefault.set(waterData.present, forKey: "waterPresent")
        self.userDefault.set(waterData.percent, forKey: "waterPercent")
        self.userDefault.set(waterData.updown, forKey: "waterUpDown")
        
        self.userDefault.set(gasData.past, forKey: "gasPast")
        self.userDefault.set(gasData.present, forKey: "gasPresent")
        self.userDefault.set(gasData.percent, forKey: "gasPercent")
        self.userDefault.set(gasData.updown, forKey: "gasUpDown")

    }
    

    
}

//Vertical Index 감지
extension HomeVC : UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.y / scrollView.frame.size.height)
        print("현재 Vertical 인덱스 = \(Int(pageNumber))")
        userDefault.set(Int(pageNumber), forKey: "verticalIdx")
    }

}


//다운버튼 관련
extension HomeVC {
    
    //다운버튼 클릭시 화면전환(Paging 효과로)
    @objc func downBtnTapped() {
        var contentOffset = verticalScroll.contentOffset
        contentOffset.y = self.view.bounds.height - 75
        verticalScroll.setContentOffset(contentOffset, animated: true)
    }
    
    //다운버튼의 오토레이아웃 & 애니메이션
    func downBtnAnimate(){
        
        let v1 = self.view.subviews[0]
        let buttonConstraint = downBtn.topAnchor.constraint(equalTo: v1.topAnchor, constant: 512)
        downBtn.translatesAutoresizingMaskIntoConstraints = false
        
        //1)다운버튼의 AutoLayOut
        NSLayoutConstraint.activate([
            buttonConstraint,
            downBtn.leadingAnchor.constraint(equalTo: v1.leadingAnchor, constant: 162),
            downBtn.centerXAnchor.constraint(equalTo: v1.safeAreaLayoutGuide.centerXAnchor)
            ])
        //2)다운버튼의 Hovering(위아래움직임) 효과
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction], animations: {
            buttonConstraint.constant += 30
            self.view.layoutIfNeeded()
        }, completion:nil)
        
    }

}

//HomeVC의 HomeUpVC & HomeDownVC 통합
extension HomeVC {
    
    ///상단 Navigation Bar 숨기기///
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNaviBar(self)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        setNaviBar(self)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }


    func setVC(){
        
        //HomeDown(테이블뷰 부분)을 다른 스토리보드로 분리하겠음
        let homeDownStoryboard = UIStoryboard.init(name: "HomeDown", bundle: nil)
        
        if let vc1 = storyboard?.instantiateViewController(withIdentifier: "HomeUpVC") as? HomeUpVC,
            let vc2 = homeDownStoryboard.instantiateViewController(withIdentifier: "HomeDownVC") as? HomeDownVC {
            
            guard let v1 = vc1.view, let v2 = vc2.view else { return }
            
            self.addChildViewController(vc1)
            self.addChildViewController(vc2)
            
            v1.translatesAutoresizingMaskIntoConstraints = false
            v2.translatesAutoresizingMaskIntoConstraints = false
            
            verticalScroll.addSubview(v1)
            verticalScroll.addSubview(v2)
            
            NSLayoutConstraint.activate([
                v1.topAnchor.constraint(equalTo: verticalScroll.topAnchor, constant: 0),
                v1.leadingAnchor.constraint(equalTo: verticalScroll.leadingAnchor, constant: 0),
                v1.trailingAnchor.constraint(equalTo: verticalScroll.trailingAnchor, constant: 0),
                v1.widthAnchor.constraint(equalTo: verticalScroll.widthAnchor, constant: 0),
                // constrain v1 height to height of scrollView MINUS 55 (the height of your barcode view in v2)
                v1.heightAnchor.constraint(equalTo: verticalScroll.heightAnchor, constant: -55),
                
                v2.topAnchor.constraint(equalTo: v1.bottomAnchor, constant: 0),
                v2.leadingAnchor.constraint(equalTo: verticalScroll.leadingAnchor, constant: 0),
                v2.trailingAnchor.constraint(equalTo: verticalScroll.trailingAnchor, constant: 0),
                v2.heightAnchor.constraint(equalTo: verticalScroll.heightAnchor, constant: 0),
                v2.widthAnchor.constraint(equalTo: verticalScroll.widthAnchor, constant: 0),
                v2.bottomAnchor.constraint(equalTo: verticalScroll.bottomAnchor, constant: 0),
                ])
            
            homeUpVC = vc1
            homeDownVC = vc2
        }
        
    }
}







