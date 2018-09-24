//
//  CommunityViewVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CommunityViewVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableview.dataSource = self
        self.tableview.delegate = self
        
        self.tableview.tableFooterView = UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CommunityViewTVCell") as! CommunityViewTVCell
        cell.nicknameLB.text = "배셔넝"
        cell.commentLB.text = "나는 노라조다"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
