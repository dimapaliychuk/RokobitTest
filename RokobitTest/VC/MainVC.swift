//
//  MainVC.swift
//  RokobitTest
//
//  Created by Dima Paliychuk on 5/2/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import UIKit
import SDWebImage

class MainVC: UIViewController {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var logoutButton: UIButton!
    private var user: User!
    
    
    //MARK: life cycle
    
    class func show(from: UIViewController, user: User) {
        let vc = UIStoryboard.main.instantiateViewController(
            withIdentifier: Constants.VcId.mainVC
        ) as!  MainVC
        vc.modalTransitionStyle = .flipHorizontal
        vc.user = user
        DBManager.shared.addUser(object: user)
        
        from.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    //MARK: private
    
    private func setupUI() {
        logoutButton.setTitle("logout".localized, for: .normal)
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        if let url = user.avatarURL {
            SDWebImageManager.shared().imageDownloader?.downloadImage(
                with: URL(string: url),
                options: .continueInBackground,
                progress: { (receivedSize, ExpectedSize, url) in
                
            }, completed: { [weak self] (image, data, error, finished) in
                self?.avatarImageView.image = image
            })
        }
    }
    
    
    //MARK: actions
    
    @IBAction private func logoutButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        DBManager.shared.deleteAll()
    }
    
}
