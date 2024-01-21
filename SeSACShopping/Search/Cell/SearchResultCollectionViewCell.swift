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
        
        heartBtn.backgroundColor = .white
        heartBtn.setTitle(nil, for: .normal)
        heartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        DispatchQueue.main.async {
            self.heartBtn.layer.cornerRadius
            = self.heartBtn.bounds.width/2
        }
    }
    
    func configureCell(_ data: Item){
        let url = URL(string: data.image)
        itemImageView.kf.setImage(with: url)
        
        malNameLabel.text = data.mallName
        titleLabel.text = data.title
        priceLabel.text = data.lprice
    }

}
