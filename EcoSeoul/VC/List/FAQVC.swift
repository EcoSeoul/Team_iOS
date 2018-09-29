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
    
    var sections = ["에코머니는 무엇인가요?", "기획자의 이름은 무엇인가요?", "디자이너는 몇 명 인가요?",
                    "개발은 파트가 어떻게?","iOS파트의 장단점은 무엇인가요?",
                    "안드로이드의 장단점은 무엇인가요?",  "서버의 장단점은 무엇인가요?"]
    
    var cells = ["에코머니는 무엇인가요? 음 제생에는 에코와 머니가 합쳐진거 같아요~_~", "기획자의 이름은 무엇인가요? 김주희입니다. 별명은 희카소고요 기획파트원입니다. 23살ㅇ?일거에요 ㅎㅎ", "디자이너는 몇 명 인가요? 2명입니다. 배선영과 최윤정입니다. 둘은 갓자이너입니다 ^&^",
                 "개발은 파트가 어떻게 나뉘어져있나요? 아 이제 귀찮아요 나머지는 알아서 찾아봐요","iOS파트의 장단점은 무엇인가요?",
                 "안드로이드의 장단점은 무엇인가요?",  "서버의 장단점은 무엇인가요?"]
    
 
    
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
            else {return 104}
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











