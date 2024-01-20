//
//  ProfileImageSettingViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/19.
//

import UIKit

class ProfileImageSettingViewController: UIViewController {

    @IBOutlet var profileImageCollecionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell()
        configureView()
        configureLayout()
    }
    
    func configureView(){
        self.view.backgroundColor = .black
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
        
        cell.configureCell(data: "profile\(indexPath.item)")
        
        return cell
    }
    
    
}
