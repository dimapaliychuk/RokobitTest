//
//  HelpLoginVC.swift
//  RokobitTest
//
//  Created by Dima Paliychuk on 5/2/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import Foundation
import UIKit


class HelpLoginVC: UIViewController {

    
    //MARK: life cycle
    
    class func show(from: UIViewController) {
        let vc = UIStoryboard.main.instantiateViewController(
            withIdentifier: Constants.VcId.helpLoginVC
        )
        vc.modalTransitionStyle = .flipHorizontal
        
        from.present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: actions
    
    @IBAction private func backAction(_ sender: Any) {
        DBManager.shared.deleteAll()
        self.dismiss(animated: true, completion: nil)
    }
    
}
