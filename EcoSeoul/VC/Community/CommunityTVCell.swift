//
//  CommunityTVCell.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CommunityTVCell: UITableViewCell {

    @IBOutlet weak var bestIMG: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    @IBOutlet weak var goodLB: UILabel!
    @IBOutlet weak var commentNumLB: UILabel!
    
    
    func configure(list : List){
        
        titleLB.text = list.boardTitle
        contentLB.text = list.boardContent
        
        if list.boardLike != nil {
            goodLB.text = (String)(list.boardLike!)
        }else{
            goodLB.text = "0"
        }
        
        if list.boardCmtnum != nil {
            commentNumLB.text = (String)(list.boardCmtnum!)
        }else{
            commentNumLB.text = "0"
        }
 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
