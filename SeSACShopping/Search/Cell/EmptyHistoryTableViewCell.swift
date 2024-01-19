//
//  EmptyHistoryTableViewCell.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit

class EmptyHistoryTableViewCell: UITableViewCell {

    @IBOutlet var emptyImageView: UIImageView!
    @IBOutlet var noticeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       configureView()
    }
    
    func configureView() {
         self.contentView.backgroundColor = .black
        
        emptyImageView.image = UIImage(resource: .empty)
        emptyImageView.contentMode = .scaleAspectFill
        
        noticeLabel.text = "최근 검색어가 없어요"
        noticeLabel.textColor = .white
        noticeLabel.font = .boldSystemFont(ofSize: 17)
    }
}
