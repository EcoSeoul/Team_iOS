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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = Tableview.dequeueReusableCell(withIdentifier: "PointTVC") as! PointTVC
            cell.categoryLB.text = "포인트 전환/삭제"
            cell.titleLB.text = "TOP쇼핑"
            cell.explainLB.text = "*에코머니 포인트로 결제하실 때는 결제화면에서 에코머니 비밀번호를 입력하셔야 합니다."
            
            
            return cell
        }else {
            let cell = Tableview.dequeueReusableCell(withIdentifier: "MenuTVC") as! MenuTVC
            cell.titleLB.text = "가맹점 찾기"
            cell.explainLB.text = "내 주변 가맹점 및 할인 공공시설을 찾아보세요"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "에코머니 가맹점 온라인 몰 둘러보기"
        //label.textColor.cgColor = "#707070"
        if section == 0 {
            return label
        }else {
            label.isHidden = true
            return label
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
