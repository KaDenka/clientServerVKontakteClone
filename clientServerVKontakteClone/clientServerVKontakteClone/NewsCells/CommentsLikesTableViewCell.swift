//
//  CommentsLikesTableViewCell.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 19.08.2021.
//

import UIKit

class CommentsLikesTableViewCell: UITableViewCell {
    @IBOutlet weak var likesImage: UIImageView!
    
    @IBOutlet weak var likesCount: UILabel!
    
    @IBOutlet weak var commentsCount: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
