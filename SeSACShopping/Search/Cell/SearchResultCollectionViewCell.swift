//
//  SearchResultCollectionViewCell.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/21.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var heartBtn: UIButton!
    @IBOutlet var malNameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    func configureView() {
        
        itemImageView.layer.cornerRadius = 10
        itemImageView.contentMode = .scaleToFill
        
        heartBtn.backgroundColor = .white
        heartBtn.setTitle("", for: .normal)
        heartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        DispatchQueue.main.async {
            self.heartBtn.layer.cornerRadius
            = self.heartBtn.bounds.width/2
        }
        
        malNameLabel.textColor = .lightGray
        malNameLabel.font = .systemFont(ofSize: 13, weight: .light)
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        titleLabel.numberOfLines = 2
        
        priceLabel.textColor = .white
    }
    
    func configureCell(_ data: Item){
        let url = URL(string: data.image)
        itemImageView.kf.setImage(with: url)
        
        malNameLabel.text = data.mallName
        titleLabel.text = data.title
        priceLabel.text = data.lprice
    }

}
