//
//  PayVC.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 21..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PayVC: ButtonBarPagerTabStripViewController, APIService {
    
    let check = UserDefaults.standard.object(forKey: "check") as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonBar()
     
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         moveToViewController(at: check)
     
    }
    
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]{
        let child1 = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "MileageTVC")
        let child2 = UIStoryboard(name: "Pay", bundle: nil).instantiateViewController(withIdentifier: "MoneyTVC")
        return [child1, child2]
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    func configureButtonBar() {
        // Sets the background colour of the pager strip and the pager strip item
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        
        // Sets the pager strip item font and font color
        settings.style.buttonBarItemFont = UIFont(name: "NotoSansCJKkr-Medium", size: 16.0)!
        settings.style.buttonBarItemTitleColor = .gray
        
        // Sets the pager strip item offsets
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        // Sets the height and colour of the slider bar of the selected pager tab
        settings.style.selectedBarHeight = 3.0
        settings.style.selectedBarBackgroundColor = .black
        
        settings.style.buttonBarBackgroundColor = .white
        
        containerView.frame.origin.y = 104
        buttonBarView.frame.contains(CGRect(x: 0, y: 60, width: 375, height: 667))
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .black
        }
    }
}

