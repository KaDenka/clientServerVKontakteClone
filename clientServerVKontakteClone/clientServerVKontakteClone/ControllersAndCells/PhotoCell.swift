//
//  PhotoCell.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView! {
        didSet {
            photoImage.backgroundColor = .white
        }
    }
}
