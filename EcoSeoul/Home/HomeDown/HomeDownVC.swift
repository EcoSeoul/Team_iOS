//
//  HomeDownVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class HomeDownVC: UIViewController {
    

    @IBOutlet weak var barcodeView: UILabel!
    
    @IBOutlet weak var Tableview: UITableView!
    
    @IBOutlet weak var barcodeBtn: UIButton!
    
    var expandCol : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = generateBarcodeFromString(string: "lcs921125")
        barcodeBtn.setImage(image, for: .normal)
        
        self.Tableview.dataSource = self
        self.Tableview.delegate = self

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
        let homeSubStoryboard = UIStoryboard.init(name: "HomeSub", bundle: nil)
        let barcodeVC = homeSubStoryboard.instantiateViewController(withIdentifier: "BarcodeVC") as? BarcodeVC
        self.present(barcodeVC!, animated: true, completion: nil)
    }
    
    
}

extension HomeDownVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 2){
            return 2
        }else if(section == 3){
            return 5
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = Tableview.dequeueReusableCell(withIdentifier: "PointHeaderTVC") as! PointHeaderTVC
            cell.headerLB.text = "에코머니 가맹점 온라인 몰 둘러보기"
            
            return cell
            
        }else if indexPath.section == 1{
            
            let cell = Tableview.dequeueReusableCell(withIdentifier: "PointTVC1") as! PointTVC1
            cell.titleLB.text = "TOP쇼핑"
            cell.explainLB.text = "*에코머니 포인트로 결제하실 때는 \n 결제화면에서 에코머니 비밀번호를 입력하셔야 합니다."
            
            return cell
            
            
        }else if indexPath.section == 2{
            
            let cell = Tableview.dequeueReusableCell(withIdentifier: "PointTVC2") as! PointTVC2
            cell.titleLB.text = "엔진닥터큐(엘더블유티㈜)"
            
            return cell
        }else {
            let cell = Tableview.dequeueReusableCell(withIdentifier: "MenuTVC") as! MenuTVC
            cell.titleLB.text = "가맹점 찾기"
            cell.explainLB.text = "내 주변 가맹점 및 할인 공공시설을 찾아보세요"
            return cell
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        self.Tableview.beginUpdates()
        
        let indexSet = NSMutableIndexSet()
        indexSet.add(indexPath.section + 1)
        indexSet.add(indexPath.section + 2)
        print("000")
        if indexPath.section == 0 {
            if expandCol == true {
                expandCol = false
                self.Tableview.deleteSections(indexSet as IndexSet, with: UITableViewRowAnimation.automatic)
                print("111")

            }else {
                print("222")
//                self.Tableview.insertSections(NSIndexSet(index: 1) as IndexSet, with: UITableViewRowAnimation.automatic)
//                self.Tableview.insertSections(NSIndexSet(index: 2) as IndexSet, with: UITableViewRowAnimation.automatic)
                expandCol = true
                self.Tableview.insertSections(indexSet as IndexSet, with: UITableViewRowAnimation.automatic)
            }

        }
//        self.Tableview.reloadSections(indexSet as IndexSet, with: UITableViewRowAnimation.automatic)
        self.Tableview.reloadData()
        self.Tableview.endUpdates()
        print("333 ")
    }
    

    ////////////////header 관련////////////////
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        //headerView.backgroundColor = UIColor.init(red: 239.0, green: 239.0, blue: 239.0, alpha: 1.0)
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 5, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = UIFont(name: "Noto Sans CJK KR", size: 15)
        //headerLabel.textColor = UIColor.init(red: 52.0, green: 52.0, blue: 52.0, alpha: 1.0)
        
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
        if (section == 1) || (section == 2) {
            return 30
        }else {
            return 0.1
        }
    }
    
}
