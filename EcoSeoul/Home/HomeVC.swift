//
//  HomeVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 14..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//
//
//  HomePageVC.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 11..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

//HomeUpVC 와 HomeDownVC 를 관리하는 ScrollView

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var verticalScroll: UIScrollView!
    
    var homeUpVC: HomeUpVC?
    var homeDownVC: HomeDownVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVC()
        
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
                
                // constrain v1 width to width of scrollView
                v1.widthAnchor.constraint(equalTo: verticalScroll.widthAnchor, constant: 0),
                // constrain v1 height to height of scrollView MINUS 67 (the height of your barcode view in v2)
                v1.heightAnchor.constraint(equalTo: verticalScroll.heightAnchor, constant: -67),
                
                // constrain v2 topAnchor to BOTTOM of v1
                v2.topAnchor.constraint(equalTo: v1.bottomAnchor, constant: 0),
                // constrain v2 leading and trailing to leading and trailing of scrollView
                v2.leadingAnchor.constraint(equalTo: verticalScroll.leadingAnchor, constant: 0),
                v2.trailingAnchor.constraint(equalTo: verticalScroll.trailingAnchor, constant: 0),
                // constrain v2 height and width to height and width of scrollView
                v2.heightAnchor.constraint(equalTo: verticalScroll.heightAnchor, constant: 0),
                v2.widthAnchor.constraint(equalTo: verticalScroll.widthAnchor, constant: 0),
                // constrain v2 bottomAnchor to bottomAnchor of scrollView
                v2.bottomAnchor.constraint(equalTo: verticalScroll.bottomAnchor, constant: 0),
                ])
            
            homeUpVC = vc1
            homeDownVC = vc2
        }
        
    }
    

    
}







