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
    
    @IBOutlet weak var barcodeBar: UILabel!
    @IBOutlet weak var barcodeBtn: UIButton!
    
    @IBOutlet weak var horizontalScroll: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    //총 3개의 이미지뷰 배열 생성 (배너광고)
    lazy var bannerArray: [UIImageView] = {
        let width = self.horizontalScroll.frame.width
        var arr: [UIImageView] = []
        for i in 0..<3 {
            arr.append(self.viewInstance(xPostion: width * CGFloat(i)))
        }
        return arr
    }()
    
    //인덱싱을 저장하기 위한 공간
    let userDefault = UserDefaults.standard
    
    //TableView Expand/Collapse Flag
    var expandCol : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        horizontalScroll.delegate = self;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        if let image = generateBarcodeFromString(string: "8 0101254 257810"){
            barcodeBtn.setBackgroundImage(image, for: .normal)
        }
       
        makeBannerView()
    }
    
    func makeBannerView(){
        for i in 0..<bannerArray.count {
            horizontalScroll.contentSize.width = horizontalScroll.frame.width * CGFloat(i+1)
            if i  % 2 == 0 { bannerArray[i].image = #imageLiteral(resourceName: "main-banner-1") }
            else { bannerArray[i].image = #imageLiteral(resourceName: "main-banner-99")}
            horizontalScroll.addSubview(bannerArray[i])
        }
    }
    
    
    func generateBarcodeFromString(string: String)-> UIImage?{
        
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform.init(scaleX: 10, y: 10)
        let output = filter?.outputImage?.transformed(by: transform)
        
        if(output != nil){
            return UIImage(ciImage: output!)
        }
        return nil
        
    }

    //바코드 버튼 클릭
    @IBAction func barcodePressed(_ sender: Any) {
        let barcodeVC = UIStoryboard(name: "HomeSub", bundle: nil).instantiateViewController(withIdentifier: "BarcodeVC")as! BarcodeVC
        
        self.addChildViewController(barcodeVC)
        
        //HomeVC에서 가져온 값
        let n = userDefault.integer(forKey: "verticalIdx")
        
        if n == 0{
            barcodeVC.view.frame = CGRect(x: 0, y: -592, width: self.view.frame.width, height: self.view.frame.height)
        }
        else{
            barcodeVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }
        
        self.view.addSubview(barcodeVC.view)
        barcodeVC.didMove(toParentViewController: self)
    }
    
    
}

//Horizontal ScrollView를 구성하는 작업
extension HomeDownVC: UIScrollViewDelegate{
    
    private func viewInstance(xPostion: CGFloat) -> UIImageView {
        let scrollframe = CGRect(x: xPostion, y: 0, width: self.horizontalScroll.frame.width, height: self.horizontalScroll.frame.height)
        return UIImageView(frame: scrollframe)
    }
    
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
        
        if indexPath.section == 0 {
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
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if expandCol{
            if indexPath.section == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PointHeaderTVC") as! PointHeaderTVC
                cell.headerLB.text = "에코머니 가맹점 온라인 몰 둘러보기"
                
                return cell
                
            }else if indexPath.section == 1{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PointTVC1") as! PointTVC1
                cell.titleLB.text = "TOP쇼핑"
                cell.explainLB.text = "*에코머니 포인트로 결제하실 때는 \n 결제화면에서 에코머니 비밀번호를 입력하셔야 합니다."
                
                return cell
                
                
            }else if indexPath.section == 2{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PointTVC2") as! PointTVC2
                
                
                if indexPath.row == 0{
                    cell.titleLB.text = "엔진닥터큐(엘더블유티㈜)"
                }
                else{
                    cell.titleLB.text = "정직한친구들"
                }
                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTVC") as! MenuTVC
                if indexPath.row == 0 {
                    cell.titleLB.text = "가맹점 찾기"
                    cell.explainLB.text = "내 주변 가맹점 및 할인 공공시설을 찾아보세요"
                }
                if indexPath.row == 1 {
                    cell.titleLB.text = "친환경 상품 신청하기"
                    cell.explainLB.text = "온라인으로 상품을 신청해보세요"
                }
                if indexPath.row == 2 {
                    cell.titleLB.text = "에코마일리지 기부하기"
                    cell.explainLB.text = "에코마일리지로 기부해보세요"
                }
                if indexPath.row == 3 {
                    cell.titleLB.text = "커뮤니티"
                    cell.explainLB.text = "꿀팁 공유"
                }
                if indexPath.row == 4 {
                    cell.titleLB.text = "에코마일리지란?"
                    cell.explainLB.text = "에코마일리지를 알려드립니다!"
                }
                
                return cell
            }
        }
        else {
            if indexPath.section == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PointHeaderTVC") as! PointHeaderTVC
                cell.headerLB.text = "에코머니 가맹점 온라인 몰 둘러보기"
                
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTVC") as! MenuTVC
                if indexPath.row == 0 {
                    cell.titleLB.text = "가맹점 찾기"
                    cell.explainLB.text = "내 주변 가맹점 및 할인 공공시설을 찾아보세요"
                }
                if indexPath.row == 1 {
                    cell.titleLB.text = "친환경 상품 신청하기"
                    cell.explainLB.text = "온라인으로 상품을 신청해보세요"
                }
                if indexPath.row == 2 {
                    cell.titleLB.text = "에코마일리지 기부하기"
                    cell.explainLB.text = "에코마일리지로 기부해보세요"
                }
                if indexPath.row == 3 {
                    cell.titleLB.text = "커뮤니티"
                    cell.explainLB.text = "꿀팁 공유"
                }
                if indexPath.row == 4 {
                    cell.titleLB.text = "에코마일리지란?"
                    cell.explainLB.text = "에코마일리지를 알려드립니다!"
                }
                
                return cell
                
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
        
        if section == 1 {
            
            headerLabel.text = "포인트 전환 / 결제"
            headerLabel.sizeToFit()
            headerView.addSubview(headerLabel)
            
            return headerView
            
        }else if (section == 2) {
            headerLabel.text = "포인트 적립 / 할인"
            headerLabel.sizeToFit()
            headerView.addSubview(headerLabel)
            
            return headerView
        }else {
            headerLabel.isHidden = true
            return nil
        }
        
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
