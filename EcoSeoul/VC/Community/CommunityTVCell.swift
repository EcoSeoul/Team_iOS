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
    
    
    func configure(apply : List){
        
//        titleLB.text = apply.boardTitle
//        commentLB.text = (String)(apply.commentCount)
        titleLB.text = apply.boardTitle
        contentLB.text = apply.boardContent
        goodLB.text = (String)(apply.boardLike)
        commentNumLB.text = (String)(apply.boardCmtnum)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
