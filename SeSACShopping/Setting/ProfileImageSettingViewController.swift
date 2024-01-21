//
//  ProfileImageSettingViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit

class ProfileImageSettingViewController: UIViewController {

    @IBOutlet var myProfileImageView: UIImageView!
    @IBOutlet var profileImageCollecionView: UICollectionView!
    
    var userSelect: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        configureView()
        configureLayout()
    }
    
    func configureView(){
        self.view.backgroundColor = .black
        
        myProfileImageView.image = UIImage(resource: .profile10)
        myProfileImageView.layer.borderColor = UIColor.accent.cgColor
        myProfileImageView.layer.borderWidth = 5
        DispatchQueue.main.async {
            self.myProfileImageView.layer.cornerRadius
            = self.myProfileImageView.bounds.width/2
        }
        
        profileImageCollecionView.backgroundColor = .clear
        profileImageCollecionView.dataSource = self
        profileImageCollecionView.delegate = self
    }
    
    func registerCell(){
        let xib = UINib(nibName: ProfileImageCollectionViewCell.identifier, bundle: nil)
        profileImageCollecionView.register(xib, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.identifier)
    }
    
    func configureLayout(){
        let layer = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/4
        layer.itemSize = CGSize(width: width, height: width)
        layer.minimumLineSpacing = 0
        layer.minimumInteritemSpacing = 0
        profileImageCollecionView.collectionViewLayout = layer
    }
    
}


extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.identifier, for: indexPath) as! ProfileImageCollectionViewCell
        
        cell.configureCell(data: "profile\(indexPath.item + 1)")
        
        if userSelect == indexPath.item {
            cell.profileImageView.layer.borderColor = UIColor.accent.cgColor
            cell.profileImageView.layer.borderWidth = 4
        } else {
            cell.profileImageView.layer.borderColor = UIColor.clear.cgColor
            cell.profileImageView.layer.borderWidth = 0
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userSelect = indexPath.row
        collectionView.reloadData()
    }
    
    
}
