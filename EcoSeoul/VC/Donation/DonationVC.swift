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

class DonationVC: UIViewController, UITextFieldDelegate, APIService {
    
    @IBOutlet weak var horizontalScroll: UIScrollView!
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    
    let pickerview = UIPickerView()
    let mileageArray = [10000, 20000]
    
    var goDetailBtn = [UIButton(),UIButton(),UIButton()]
    var selectTF = [UITextField(),UITextField(),UITextField()]
    var donateBtn = [UIButton(),UIButton(),UIButton()]
    
    var pageControl = UIPageControl(frame: CGRect(x: 166, y: 635, width: 43, height: 8.57))
    
    var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "arrow-left-black")
        btn.tintColor = UIColor.black
        btn.width = -40
        btn.action = #selector(popSelf)
        return btn
    }()
    
    var myPageBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = #imageLiteral(resourceName: "ic-mypage")
        btn.tintColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        btn.action = #selector(myPage)
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
        setDonNaviBar()
        makePageControl()
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: .valueChanged)
        
        makeDonationView()
        initPicker()
        selectTF[0].delegate = self;
        selectTF[1].delegate = self;
        selectTF[2].delegate = self;
    }
    
    
    
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
            
            goDetailBtn[i] = horizontalScroll.subviews[i].subviews[1] as! UIButton
            selectTF[i] = horizontalScroll.subviews[i].subviews[6] as! UITextField
            donateBtn[i] = horizontalScroll.subviews[i].subviews[7] as! UIButton
            
            goDetailBtn[i].addTarget(self, action: #selector(goDetailBtnPressed), for: .touchUpInside)
            //            selectTF[i].addTarget(self, action: #selector(selectTFPressed), for: .touchUpInside)
            donateBtn[i].addTarget(self, action: #selector(donateBtnPressed), for: .touchUpInside)
            
        }
        
        
    }
    
    
    @objc func goDetailBtnPressed(){
        
        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
        webVC.address = "http://ecomileage.seoul.go.kr/home/incentives/donation.do?menuNo=6"
        self.present(webVC, animated: true, completion: nil)
    }
    
    @objc func donateBtnPressed(_ sender: UIButton){
        
        //이곳에서 버튼 클릭시 나오는 창을 만들어주기
        
        let params: [String:Any] = [
            "org_idx" : UserDefaults.standard.integer(forKey: "orgIdx"),
            "org_name" : UserDefaults.standard.string(forKey: "orgName")!,
            "user_idx" : userIdx,
            "donation_mileage" : UserDefaults.standard.integer(forKey: "donateMileage")
        ]
        
        DonationService.shareInstance.donate(url: url("/donation"), params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let data):
                
                print(data)
                //기부를 했습니다. 창 띄우기
                print("\(UserDefaults.standard.integer(forKey: "donateMileage")) M 기부완료!!!")
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "마일리지가 부족해요 ㅠㅠ")
            default :
                break
            }
        })
        
    }
    
    ////////////////////////////////////
    
    
    ////Page Control (위에 인덱싱 표시) 구현부 ////
    
    func makePageControl(){
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.view.addSubview(pageControl)
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * horizontalScroll.frame.width
        horizontalScroll.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
        let pageIdx = pageControl.currentPage + 1
        print("현재 Horizontal 인덱스 = \(pageControl.currentPage)")
        UserDefaults.standard.set(pageIdx, forKey: "orgIdx")
        
        switch pageIdx {
        case 0:
            UserDefaults.standard.set("푸른아시아", forKey: "orgName")
            break
        case 1:
            UserDefaults.standard.set("미래숲", forKey: "orgName")
            break
        case 2:
            UserDefaults.standard.set("서울에너지복지시민기금", forKey: "orgName")
            break
        default: break
        }
    }
    
    /////////////////////////////////////
    
    
}



extension DonationVC: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mileageArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(mileageArray[row]) M"
    }
    
    
    
    func initPicker() {
        self.pickerview.delegate = self;
        self.pickerview.dataSource = self;
        
        let bar = UIToolbar()
        bar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(selectedPicker))
        
        bar.setItems([doneButton], animated: true)
        
        for i in 0..<3{
            selectTF[i].inputAccessoryView = bar
            selectTF[i].inputView  = pickerview
        }
    }
    
    
    @objc func selectedPicker(){
        let row = pickerview.selectedRow(inComponent: 0)
        
        // 선택된 항목 textField에 넣기.
        for i in 0..<3{
            let centeredParagraphStyle = NSMutableParagraphStyle()
            centeredParagraphStyle.alignment = .center
            
            selectTF[i].attributedPlaceholder = NSAttributedString(string: "\(mileageArray[row]) M", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.1296959221, green: 0.8359363675, blue: 0.5591831207, alpha: 1), NSAttributedStringKey.paragraphStyle: centeredParagraphStyle ])
        }
        
        UserDefaults.standard.set(mileageArray[row], forKey: "donateMileage")
        
        
        
        
        view.endEditing(true)
    }
    
    
    
    
}


extension DonationVC{
    
    ////////////Navigation Bar 관련////////////
    
    @objc func popSelf() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func myPage(){
        let myPageVC = UIStoryboard(name: "HomeSub", bundle: nil).instantiateViewController(withIdentifier: "MyPageVC") as! MyPageVC
        self.present(myPageVC, animated: true, completion: nil)
    }
    
    
    func setDonNaviBar(){
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        let item: UINavigationItem = self.navigationItem
        
        backBtn.target = self;
        myPageBtn.target = self;
        
        item.leftBarButtonItem = backBtn
        item.leftBarButtonItem?.imageInsets.left = -15
        item.rightBarButtonItem = myPageBtn
        item.rightBarButtonItem?.imageInsets.right = -15
        item.title = "기부하기"
        bar.setBackgroundImage(UIImage(), for: .default)
        bar.shadowImage = UIImage()
    }
    
    //상태 표시줄 흰색 만들기
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    ///////////////////////////////////////
}













