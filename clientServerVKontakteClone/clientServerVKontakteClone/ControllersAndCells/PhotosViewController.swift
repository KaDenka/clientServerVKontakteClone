//
//  PhotosViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 15.07.2021.
//

import UIKit

class PhotosViewController: UIViewController {
    
    let photosList = PhotosAPIService()
    
    var photos = [Photo]()

    @IBOutlet weak var photosCollectionView: UICollectionView! {
        didSet {
            photosCollectionView.delegate = self
            photosCollectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosList.photosListAPIRequest { [weak self] item in
            guard let self = self else { return }
            self.photos = item
            self.photosCollectionView.reloadData()
        }

        
    }
    

}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCollectionViewCell", for: indexPath) as! PhotoCell
        
        let image = photos[indexPath.row]
        guard let imageUrl = image.sizes.first?.url else {return cell}
        
        if let url = URL(string: imageUrl) {
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!)
            cell.photoImage.image = image
        }
        return cell
    }
    
    
}
