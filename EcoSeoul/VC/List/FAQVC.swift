//
//  FAQVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 23..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class FAQVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    //TableView Expand/Collapse Flag
    var expandCol: Bool = false
    var selectedIndx = -1
    var selectTag: Int?
    
    var sections = ["회원가입은 어떻게 하나요?", "현금 전환, 지방세 납부, 카드 포인트 적립 등은 어떻게 하나요?", "거주지 이전 시 주소변경 관련",
                    "마일리지로 상품 신청시 배송일정 안내","에코마일리지 인센티브 선정절차는 어떻게 되나요?",
                    "에코마일리지 계산법궁금해요",  "에코마일리지 카드가입은 어떻게 하나요?"]
    
    var cells = ["주소 및 아파트 등록 문제로 애플리케이션 내에서는 회원가입이 어렵습니다. 서울시 에코마일리지 홈페이지에서 회원가입이 가능합니다. ", "문의하신 사용 방법들은 에코마일리지 홈페이지가 아닌 E-Tax 등의 홈페이지 방문이 필요하여 앱 내에서는 사용이 어렵습니다.", " ",
                 "배송일정은 서울시 에코마일리지 웹 홈페이지의 [알림터 -> 공지사항 -> 인센티브 신청상품 배송안내]를 참고해주세요."," ",
//                 "인센티브 지급기준\n - 평가대상기간 : 가입월 다음월 부터 시작(8월가입자는 9월 부터 6개월씩)\n- 기준사용량 : 전년+전전년의 기간 사용량의 평균\nex) 2014년 4월가입자 기준\n평가대상기간은 2014년 5월 ~ 10월, 11월~ 2015년5월….이며\n- 절감량은 탄소배출량으로 환산한 후 계산됩니다.\nex) 전기사용량 : 100kw, 가스사용량 : 10m3, 수도물 : 10m3\n=> 100*0.424 =42.4, 가스 10*2.24=22.4, 수도물 10*0.332\3.32\n※ 탄소환산계수 : 전기(0.424/kw), 가스(2.24/m3), 수도물(0.332/m3)\n질문하신 310Kw -> 257Kw, 수도34.2 -> 30\n(수도사용량은 임의로 30를 설정했습니다.)\n전기 절감량 : 257*0.424-310*0.424 = -22.472\n수도절감량 : 30*0.332-34.2*0.332 = -1.3944\n총절감량 : -23.8664\n전기수도기준사용량 : 310*0.424+34.2*0.332 = 142.794\n절감율 : 총절감량 / 기준사용량 -16.71% "
        "에코마일리지 멤버십 카드 신청은  에코머니 홈페이지(http://ecomoney.co.kr/)에 접속 → 카드소개/신청→멤버십카드 메뉴를 이용하여 신청해주시면 됩니다.\n에코마일리지 신용 및 체크카드 신청은  가까운 은행 영업점에 가서 직접 신청하시면 됩니다."]
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.reloadData()
        
        tableview.tableFooterView = UIView(frame: .zero)
   

    }

    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



extension FAQVC: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandCol == true {
            return 2
        }
        else {
            return 1
            
        }
    }
    


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == selectedIndx && expandCol{
            if indexPath.row == 0 { return 48 }
            else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTVC2") as! FAQTVC2
//                var height = CGFloat(cell.answerLabel.topAnchor) - CGFloat(cell.answerLabel.bottomAnchor)
                return 300}
        }else{
            if indexPath.row == 0 { return 48 }
            else {return 0}
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "FAQTVC1") as! FAQTVC1
            cell.selectionStyle = .none
            cell.questionLabel.text = sections[indexPath.section]
            return cell
        }
        else{
            let cell = tableview.dequeueReusableCell(withIdentifier: "FAQTVC2") as! FAQTVC2
            cell.answerLabel.text = cells[indexPath.section]
            cell.selectionStyle = .none
           return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: indexPath.section)) as! FAQTVC1
  
        //셀 클릭이후 남아있는 gray color 없애기
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedIndx != indexPath.section{
            expandCol = true
            selectedIndx = indexPath.section
            cell.questionLabel.textColor = #colorLiteral(red: 0.1296959221, green: 0.8359363675, blue: 0.5591831207, alpha: 1)
            cell.showBtn.image = #imageLiteral(resourceName: "arrow-up-black")

        }
            
        else{
            expandCol = false
            selectedIndx = -1
            cell.questionLabel.textColor = #colorLiteral(red: 0.2651461363, green: 0.2651531994, blue: 0.2651493847, alpha: 1)
            cell.showBtn.image = #imageLiteral(resourceName: "arrow-down-black")

        }
        tableview.reloadData()

    }
    
}


extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
        
    }
}











