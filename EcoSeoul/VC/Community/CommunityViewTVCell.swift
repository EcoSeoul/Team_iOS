//
//  CommunityViewTVCell.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class CommunityViewTVCell: UITableViewCell {

    @IBOutlet weak var nicknameLB: UILabel!
    @IBOutlet weak var commentLB: UILabel!
    @IBOutlet weak var dateLB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func commentConfig(comment : CommentResult){
        nicknameLB.text = (String)(comment.userIdx)
        commentLB.text = comment.cmtContent
        dateLB.text = comment.cmtDate
    }

}
