//
//  ProfileImageCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit

class ProfileImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(data: String){
        profileImageView.image = UIImage(named: data)
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius
            = self.profileImageView.bounds.width/2
        }
    }
}
