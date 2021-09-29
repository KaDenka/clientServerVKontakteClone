//
//  CommentsLikesTableViewCell.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 19.08.2021.
//

import UIKit

class CommentsLikesTableViewCell: UITableViewCell {
    @IBOutlet weak var likesImage: UIImageView!
    
    @IBOutlet weak var likesCount: UILabel! {
        didSet {
            likesCount.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var commentsCount: UILabel! {
        didSet {
            commentsCount.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var commentsLabel: UILabel! {
        didSet {
            commentsLabel.backgroundColor = .white
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
