//
//  SearchHistoryTableViewCell.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/18.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet var historyLabel: UILabel!
    @IBOutlet var magnifygglassImageView: UIImageView!
    @IBOutlet var magnifyingglassView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configurateView()
    }

    func configurateView() {
        historyLabel.textColor = .white
        historyLabel.font = .systemFont(ofSize: 13)
        
        cancelBtn.tintColor = .gray
        
        magnifygglassImageView.tintColor = .white
        magnifyingglassView.backgroundColor = .clear
        magnifyingglassView.layer.borderWidth = 0.7
        magnifyingglassView.layer.borderColor = UIColor.darkGray.cgColor
        DispatchQueue.main.async {
            self.magnifyingglassView.layer.cornerRadius
            = self.magnifyingglassView.bounds.width/2
        }
        
        self.contentView.backgroundColor = .black
    }
    
    func configure(data: String) {
        historyLabel.text = data
    }
    
}
