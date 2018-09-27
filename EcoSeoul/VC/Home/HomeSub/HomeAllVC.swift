//
//  HomeAllVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 14..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class HomeAllVC: UIViewController {

    @IBOutlet weak var Tableview: UITableView!
    @IBOutlet weak var periodLB: UILabel!
    @IBOutlet weak var carbonLB: UILabel!
    @IBOutlet weak var upDownImg: UIImageView!
    @IBOutlet weak var percentLB: UILabel!

    
    let elecData = Percent(updown: UserDefaults.standard.integer(forKey: "elecUpDown"), percent: UserDefaults.standard.integer(forKey: "elecPercent"), past: UserDefaults.standard.integer(forKey: "elecPast"), present: UserDefaults.standard.integer(forKey: "elecPresent"))
    let waterData = Percent(updown: UserDefaults.standard.integer(forKey: "waterUpDown"), percent: UserDefaults.standard.integer(forKey: "waterPercent"), past: UserDefaults.standard.integer(forKey: "waterPast"), present: UserDefaults.standard.integer(forKey: "waterPresent"))
    let gasData = Percent(updown: UserDefaults.standard.integer(forKey: "gasUpDown"), percent: UserDefaults.standard.integer(forKey: "gasPercent"), past: UserDefaults.standard.integer(forKey: "gasPast"), present: UserDefaults.standard.integer(forKey: "gasPresent"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Tableview.delegate = self;
        self.Tableview.dataSource = self;
    }

    @IBAction func dismissPressed(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
}

extension HomeAllVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeAllTVC") as! HomeAllTVC
        let carbon = UserDefaults.standard.integer(forKey: "totalCarbon")
        let pastCarbon = UserDefaults.standard.integer(forKey: "pastTotalCarbon")
        let termStart = UserDefaults.standard.integer(forKey: "termStart")
        let carbonUpDown = UserDefaults.standard.integer(forKey: "carbonUpDown")
        
        cell.monthLB.text = "8"
        self.carbonLB.text = "\(carbon)"
        self.periodLB.text = "2018.\(termStart).14 ~ 2018.08.13"
        
        if pastCarbon >= carbon {
            self.percentLB.text = "\(Int((pastCarbon - carbon) * 100 / pastCarbon))"
        }
        else{
            self.percentLB.text = "\(Int(-(pastCarbon - carbon) * 100 / pastCarbon))"
        }
        
        switch carbonUpDown {
            case 0 :
                upDownImg.image = UIImage()
                break
            case 1:
                upDownImg.image = #imageLiteral(resourceName: "percentage-down")
                break
            case 2:
                upDownImg.image = #imageLiteral(resourceName: "percentage-up")
                break
            default:
                break
        }
        

        
        func setData(_ data: Percent){
            
            cell.useageLB.text = "\(data.present)"
            cell.percentLB.text = "\(data.percent)"
            
            switch data.updown {
                case 0:
                    cell.explainLB.text = "작년과 사용량이 같은 당신!\n좀 더 분발하세요! ^^"
                    cell.upDownImg.image = UIImage()
                    break
                case 1:
                    cell.explainLB.text = "작년보다 \(data.percent)%를 절약한 당신!\n최고에요! :)"
                    cell.upDownImg.image = #imageLiteral(resourceName: "percentage-down")
                    break
                case 2:
                    cell.explainLB.text = "작년보다 \(data.percent)%를 과소비!!!\n 노력하세요! :("
                    cell.upDownImg.image = #imageLiteral(resourceName: "percentage-up")
                    break
                default:
                    break
            }
        }
        
        if indexPath.row == 0{
            cell.itemLB.text = "전기"
            cell.itemIMG.image = #imageLiteral(resourceName: "home-all-electric")
            setData(elecData)
        
        }else if indexPath.row == 1{
            
            cell.itemLB.text = "수도"
            cell.itemIMG.image = #imageLiteral(resourceName: "home-all-water")
            setData(waterData)
        }else {
            cell.itemLB.text = "도시가스"
            cell.itemIMG.image = #imageLiteral(resourceName: "home-all-gas")
            setData(gasData)
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
