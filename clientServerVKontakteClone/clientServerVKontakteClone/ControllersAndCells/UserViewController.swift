//
//  UserViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 29.08.2021.
//

import UIKit

class UserViewController: UIViewController {
    
    let userAPIRequest = UserAPIService()
    
    var userProfile = [UserResponse]()
    
    
    @IBOutlet weak var userProfileImage: UIImageView! {
        didSet {
            self.userProfileImage.layer.cornerRadius = self.userProfileImage.bounds.height/2
        }
        
    }
    
    
    @IBOutlet weak var userProfileNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brandBackgroundColor //#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        userAPIRequest.userProfileAPIRequest {
            [weak self] profiles in
            
            guard let self = self else { return }
            
            self.userProfile = profiles
            
            if let imageURL = URL(string: self.userProfile.first!.photo200) {
                let imageData = try? Data(contentsOf: imageURL)
                self.userProfileImage.image = UIImage(data: imageData!)
            }
            
            guard let userLastName = self.userProfile.first?.lastName, let userFirstName = self.userProfile.first?.firstName else { return self.userProfileNameLabel.text = "User unknown"}
            
            self.userProfileNameLabel.text = "\(userLastName) \(userFirstName)"
            
        }
    }
}
