//
//  PostListTVCell.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class PostListTVCell: UITableViewCell {

    @IBOutlet weak var postTitleLB: UILabel!
    @IBOutlet weak var postContentLB: UILabel!
    @IBOutlet weak var postDateLB: UILabel!
    
    @IBOutlet weak var postLikeLB: UILabel!
    @IBOutlet weak var postCmtNumLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
