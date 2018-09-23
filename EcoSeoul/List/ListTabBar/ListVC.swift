//
//  ListVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ListVC: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewDesign()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]{
        let child1 = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "RequestListTVC")
        let child2 = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "DonationListTVC")
        let child3 = UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "PostListTVC")
        return [child1, child2, child3]
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadViewDesign(){
        self.settings.style.selectedBarHeight = 1
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarBackgroundColor = .white
        self.settings.style.selectedBarHeight = 3
        self.settings.style.selectedBarVerticalAlignment = .bottom
        self.settings.style.buttonBarMinimumLineSpacing = 0
        self.settings.style.buttonBarItemTitleColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        self.settings.style.buttonBarItemFont = UIFont(name: notoSansFont.Medium.rawValue, size: 17)!
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = true
        self.settings.style.buttonBarLeftContentInset = 10
        self.settings.style.buttonBarRightContentInset = 10
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell, newCell: ButtonBarViewCell, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell.label.textColor = UIColor.white
            newCell.label.textColor = UIColor.white
            
            } as? ((ButtonBarViewCell?, ButtonBarViewCell?, CGFloat, Bool, Bool) -> Void)
    }
}

