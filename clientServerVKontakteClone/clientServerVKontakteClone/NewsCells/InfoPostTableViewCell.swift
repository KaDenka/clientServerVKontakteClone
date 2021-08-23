//
//  InfoPostTableViewCell.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 19.08.2021.
//

import UIKit

class InfoPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatarImage: UIImageView!
    
    @IBOutlet weak var userInfoLabel: UILabel!
    
    @IBOutlet weak var dateInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
