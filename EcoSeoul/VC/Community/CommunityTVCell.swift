//
//  CommunityTVCell.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 24..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit

protocol MyCellDelegate: AnyObject {
    func likeBtnTapped(at index: IndexPath)
}

class CommunityTVCell: UITableViewCell {
    
    var delegate: MyCellDelegate!
    var indexPath:IndexPath!

    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var bestIMG: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var contentLB: UILabel!
    @IBOutlet weak var goodLB: UILabel!
    @IBOutlet weak var commentNumLB: UILabel!
    
    @IBAction func likeBtnTapped(sender: AnyObject) {
        self.delegate.likeBtnTapped(at: indexPath)
    }
    
    func configure(list : List){
        
        let boardlike = gino(list.boardLike)
        let boardCmtnum = gino(list.boardCmtnum)
        
        titleLB.text = list.boardTitle
        contentLB.text = list.boardContent
        goodLB.text = String(boardlike)
        commentNumLB.text = String(boardCmtnum)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
 

}

extension CommunityTVCell {
    
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
}
