//
//  HomeDownVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

//UILabel(BarcodeBar) + ScrollView + TableView로 구성.

class HomeDownVC: UIViewController {
    
    let userIdx = UserDefaults.standard.integer(forKey: "userIdx")
    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var barcodeBar: UILabel!
    @IBOutlet weak var barcodeBtn: UIButton!
    @IBOutlet weak var horizontalScroll: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mileageLabel: UILabel!
    
    //총 3개의 이미지뷰 배열 생성 (배너광고)
    lazy var bannerArray: [UIButton] = {
        let width = self.horizontalScroll.frame.width
        var arr: [UIButton] = []
        for i in 0..<3 {
            arr.append(self.viewInstance(xPostion: width * CGFloat(i)))
        }
        return arr
    }()
    var pageControl = UIPageControl(frame: CGRect(x: 317, y: 200, width: 34, height: 7))


    //TableView Expand/Collapse Flag
    var expandCol : Bool = false
    let cell3Title = ["가맹점 찾기", "친환경 상품 신청하기", "에코마일리지 기부하기", "커뮤니티", "에코마일리지란?"]
    let cell3Explain = ["내 주변 가맹점 및 할인 공공시설을 찾아보세요", "온라인으로 상품을 신청해보세요",
                        "에코마일리지로 기부해보세요", "꿀팁 공유","에코마일리지를 알려드립니다!"]
    
    var barcodeSerial: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalScroll.delegate = self;
        tableView.dataSource = self;
        tableView.delegate = self;
 
        makeBarcodeImage()
        makeBannerView()
        makePageControl()
        pageControl.addTarget(self.horizontalScroll, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        makeBarcodeImage()
    }
    
    func makeBarcodeImage(){
        
        barcodeSerial = userDefault.string(forKey: "userBarcode")
        mileageLabel.text = String(userDefault.integer(forKey: "userMileage"))
        
        guard let serial = barcodeSerial else {
            barcodeBtn.setTitle("카드등록", for: .normal)
            barcodeBtn.setTitleColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1), for: .normal)
            barcodeBtn.titleLabel?.font = UIFont(name: notoSansFont.Regular.rawValue, size: 13)
            return
        }
        
        if let image = generateBarcodeFromString(string: serial){
            barcodeBtn.setBackgroundImage(image, for: .normal)
        }

    }
    
    //바코드 버튼 클릭
    @IBAction func barcodePressed(_ sender: Any) {
        
        //1)바코드가 있는 경우
        if barcodeSerial != nil {
            let barcodeVC = UIStoryboard(name: "HomeSub", bundle: nil).instantiateViewController(withIdentifier: "BarcodeVC")as! BarcodeVC
            barcodeVC.barcodeSerial = self.barcodeSerial
            self.addChildViewController(barcodeVC)
            
            //HomeVC에서 가져온 현재 Vertical 인덱스 위치 확인
            let n = userDefault.integer(forKey: "verticalIdx")
            
            switch n {
                case 0:
                      barcodeVC.view.frame = CGRect(x: 0, y: -592, width: self.view.frame.width, height: self.view.frame.height)
                      break
                case 1:
                      barcodeVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                      break
                default:
                    break
            }
            
            self.view.addSubview(barcodeVC.view)
            barcodeVC.didMove(toParentViewController: self)
        }
            
        //2)바코드가 없는 경우(->카드 등록창으로 유도)
        else {
            print("카드생성 팝업이 뜨게 해줘야합니다!!! 구현하세요!")
        }
    
    }
    
    
    //마이페이지 버튼 클릭
    @IBAction func mypagePressed(_ sender: Any) {
        let myPageVC = UIStoryboard(name: "HomeSub", bundle: nil).instantiateViewController(withIdentifier: "MyPageVC") as! MyPageVC
        self.present(myPageVC, animated: true, completion: nil)
    }
    
    
}

//Horizontal ScrollView를 구성하는 작업
extension HomeDownVC: UIScrollViewDelegate{
    
    private func viewInstance(xPostion: CGFloat) -> UIButton {
        let scrollframe = CGRect(x: xPostion, y: 0, width: self.horizontalScroll.frame.width, height: self.horizontalScroll.frame.height)
        return UIButton(frame: scrollframe)
    }

    func makeBannerView(){
  
        for i in 0..<bannerArray.count {
            horizontalScroll.contentSize.width = horizontalScroll.frame.width * CGFloat(i+1)
            
            switch i {
                case 0:
                    bannerArray[i].setBackgroundImage(#imageLiteral(resourceName: "main-banner-1"), for: .normal)
                    break
                case 1:
                    bannerArray[i].setBackgroundImage(#imageLiteral(resourceName: "main_banner_2"), for: .normal)
                    break
                case 2:
                    bannerArray[i].setBackgroundImage(#imageLiteral(resourceName: "main-banner-3"), for: .normal)
                    break
                default: break
            }
   
            horizontalScroll.addSubview(bannerArray[i])
        }
        bannerArray[0].addTarget(self, action: #selector(enterContent1VC), for: .touchUpInside)
        bannerArray[1].addTarget(self, action: #selector(enterContent2VC), for: .touchUpInside)
        bannerArray[2].addTarget(self, action: #selector(enterContent3VC), for: .touchUpInside)
        
    }
    
    @objc func enterContent1VC(){
        let ContentVC1 = UIStoryboard(name: "HomeDown", bundle: nil).instantiateViewController(withIdentifier: "Content1VC")as! Content1VC
        self.present(ContentVC1, animated: true, completion: nil)
    }
    
    @objc func enterContent2VC(){
        let ContentVC2 = UIStoryboard(name: "HomeDown", bundle: nil).instantiateViewController(withIdentifier: "Content2VC")as! Content2VC
        self.present(ContentVC2, animated: true, completion: nil)
        
    }
    
    @objc func enterContent3VC(){
        let ContentVC3 = UIStoryboard(name: "HomeDown", bundle: nil).instantiateViewController(withIdentifier: "Content3VC")as! Content3VC
        self.present(ContentVC3, animated: true, completion: nil)
    }
    
    ////Page Control (위에 인덱싱 표시) 구현부 ////
    func makePageControl(){
        self.pageControl.numberOfPages = bannerArray.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        self.pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        self.pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.tableView.addSubview(pageControl)
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * horizontalScroll.frame.width
        horizontalScroll.setContentOffset(CGPoint(x:x, y:0), animated: true)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    /////////////////////////////////////
    
}

//TableView를 구성하는 작업
extension HomeDownVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if expandCol { return 4 }
        else { return 2 }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if expandCol {
            if section == 2 { return 2 }
            else if section == 3{ return 5 }
            else { return 1 }
        }
        else {
            if section == 0 { return 1 }
            else { return 5 }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        
        //셀 클릭이후 남아있는 gray color 없애기
        tableView.deselectRow(at: indexPath, animated: true)
        
        if section == 0 {
            
            self.tableView.beginUpdates()
            if expandCol == true {
                self.tableView.deleteSections([1, 2], with: .bottom)
            }
            else{
                self.tableView.insertSections([1, 2], with: .automatic)
            }
            expandCol = !expandCol
            
            self.tableView.endUpdates()
            self.tableView.reloadData()
            
        }
        
        //1)Section이 펼쳐진 경우
        if expandCol{
            
            if section == 1{
                //포인트 전환/결제 관련 뷰 전환 구현부
                let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
                webVC.address = "http://topshop.bccard.com/app/topmall/m/main/main"
                self.present(webVC, animated: true, completion: nil)
              
            }
                
            else if section == 2{
                //포인트 적립/할인 관련 뷰 전환 구현부
                let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
                if row == 0{
                    webVC.address = "https://www.facebook.com/EngineDoctorQ"
                }else if row == 1{
                    webVC.address = "https://www.honest79.co.kr/?NaPm=ct%3Djmg9y1xo%7Cci%3Dcheckout%7Ctr%3Dds%7Ctrx%3D%7Chk%3Dbacd7b5c5fd5e888ce084b1072028c6563584fa9"
                }
            
                self.present(webVC, animated: true, completion: nil)
              
            }
                
            else if section == 3{
                
                switch row {
                    case 0:
                        let affiliationVC = UIStoryboard(name: "Affiliation", bundle: nil).instantiateViewController(withIdentifier: "AffiliationVC")as! AffiliationVC
                        self.navigationController?.pushViewController(affiliationVC, animated: true)
                    case 1:
                        //친환경 상품신청하기 push 작업 구현부
                        let shopVC = UIStoryboard(name: "Shop", bundle: nil).instantiateViewController(withIdentifier: "ShopCVC")as! ShopCVC
                        self.navigationController?.pushViewController(shopVC, animated: true)
                        break
                    case 2:
                        //에코마일리지 기부하기 push 작업 구현부
                        let donationVC = UIStoryboard(name: "Donation", bundle: nil).instantiateViewController(withIdentifier: "DonationVC") as! DonationVC
                        self.navigationController?.pushViewController(donationVC, animated: true)
                        break
                    case 3:
                        //커뮤니티 push 작업 구현부
                        let commnunityVC = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityVC")as! CommunityVC
                        self.navigationController?.pushViewController(commnunityVC, animated: true)
                        break
                    case 4:
                        //에코마일리지란? push 작업 구현부
                        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
                        webVC.address = "http://ecomileage.seoul.go.kr/home/infomation/whatIsEco.do?menuNo=1"
                        self.present(webVC, animated: true, completion: nil)
                        break
                    default: break
                }
                
            }
            
        }
            
            
            //2)Section이 닫혀진 경우
        else {
            
            if section == 1 {
                switch row {
                    case 0:
                        let affiliationVC = UIStoryboard(name: "Affiliation", bundle: nil).instantiateViewController(withIdentifier: "AffiliationVC")as! AffiliationVC
                        self.navigationController?.pushViewController(affiliationVC, animated: true)
                    case 1:
                        //친환경 상품신청하기 push 작업 구현부
                        let shopVC = UIStoryboard(name: "Shop", bundle: nil).instantiateViewController(withIdentifier: "ShopCVC")as! ShopCVC
                        self.navigationController?.pushViewController(shopVC, animated: true)
                        break
                    case 2:
                        //에코마일리지 기부하기 push 작업 구현부
                        let donationVC = UIStoryboard(name: "Donation", bundle: nil).instantiateViewController(withIdentifier: "DonationVC") as! DonationVC
                        self.navigationController?.pushViewController(donationVC, animated: true)
                        break
                    case 3:
                        //커뮤니티 push 작업 구현부
                        let commnunityVC = UIStoryboard(name: "Community", bundle: nil).instantiateViewController(withIdentifier: "CommunityVC")as! CommunityVC
                        self.navigationController?.pushViewController(commnunityVC, animated: true)
                        break
                    case 4:
                        //에코마일리지란? push 작업 구현부
                        let webVC = UIStoryboard(name: "Web", bundle: nil).instantiateViewController(withIdentifier: "WebVC")as! WebVC
                        webVC.address = "http://ecomileage.seoul.go.kr/home/infomation/whatIsEco.do?menuNo=1"
                        self.present(webVC, animated: true, completion: nil)
                        break
                    default: break
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let row = indexPath.row
        
        let cell0 = tableView.dequeueReusableCell(withIdentifier: "PointHeaderTVC") as! PointHeaderTVC
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "PointTVC1") as! PointTVC1
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "PointTVC2") as! PointTVC2
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "MenuTVC") as! MenuTVC
        cell0.selectionStyle = .none
        cell1.selectionStyle = .none
        cell2.selectionStyle = .none
        cell3.selectionStyle = .none
        //1)Section이 펼쳐진 경우
        if expandCol{
            if section == 0 {
                cell0.headerLB.text = "에코머니 가맹점 온라인 몰 둘러보기"
                return cell0
            }
            else if section == 1{
                cell1.titleLB.text = "TOP쇼핑"
                cell1.explainLB.text = "*에코머니 포인트로 결제하실 때는 \n 결제화면에서 에코머니 비밀번호를 입력하셔야 합니다."
                return cell1
            }
            else if section == 2{
                if row == 0{
                    cell2.titleLB.text = "엔진닥터큐(엘더블유티㈜)"
                }
                else{
                    cell2.titleLB.text = "정직한친구들"
                }
                return cell2
            }
            else{
                cell3.titleLB.text = cell3Title[row]
                cell3.explainLB.text = cell3Explain[row]
                return cell3
            }
        }
            
            //2)Section이 닫혀진 경우
        else {
            if section == 0 {
                cell0.headerLB.text = "에코머니 가맹점 온라인 몰 둘러보기"
                return cell0
            }
            else{
                cell3.titleLB.text = cell3Title[row]
                cell3.explainLB.text = cell3Explain[row]
                return cell3
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 44
        }else if indexPath.section == 1{
            return 85
        }else if indexPath.section == 2{
            return 50
        }else {
            return 100
        }
        
    }
    
    ////////////////header 관련////////////////
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 5, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: notoSansFont.Medium.rawValue, size: 15)
        headerLabel.textColor = #colorLiteral(red: 0.2039215686, green: 0.2039215686, blue: 0.2039215686, alpha: 1)
        if expandCol {
            if section == 1 {
                
                headerLabel.text = "포인트 전환 / 결제"
                headerLabel.sizeToFit()
                headerView.addSubview(headerLabel)
                
                
            }else if (section == 2) {
                headerLabel.text = "포인트 적립 / 할인"
                headerLabel.sizeToFit()
                headerView.addSubview(headerLabel)
                
            }else {
                headerLabel.isHidden = true
                return nil
            }
        }else{
            headerLabel.text = ""
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if expandCol {
            if (section == 1) || (section == 2) {
                return 30
            }else {
                return 0.1
            }
            
        }else { return 0.1 }
        
    }
    
    ////////////////////////////////////////
    
}
