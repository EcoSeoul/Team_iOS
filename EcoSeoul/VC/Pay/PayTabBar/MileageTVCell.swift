//
//  MileageTVCell.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

class MileageTVCell: UITableViewCell {

    @IBOutlet weak var usageTitleLB: UILabel!
    @IBOutlet weak var usageDateLB: UILabel!
    @IBOutlet weak var plusminusLB: UILabel!
    @IBOutlet weak var mileageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
