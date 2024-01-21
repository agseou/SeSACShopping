//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/21.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet var serachResultCollectionView: UICollectionView!
    var searchList: [Item] = []
    let searchManager = SearchAPIManager()
    var text: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchManager.callRequest(text: text) { list in
            self.searchList = list
            self.serachResultCollectionView.reloadData()
        }
        registerCell()
        configureView()
        configureLayout()
    }
    
    func configureView(){
        self.view.backgroundColor = .black
        
        serachResultCollectionView.backgroundColor = .clear
        serachResultCollectionView.dataSource = self
        serachResultCollectionView.delegate = self
    }
    
    func registerCell(){
        let xib = UINib(nibName: SearchResultCollectionViewCell.identifier, bundle: nil)
        serachResultCollectionView.register(xib, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    func configureLayout(){
        let layer = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/2
        layer.itemSize = CGSize(width: width, height: width + 100)
        layer.minimumLineSpacing = 0
        layer.minimumInteritemSpacing = 0
        serachResultCollectionView.collectionViewLayout = layer
    }
    
}


extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        
        cell.configureCell(searchList[indexPath.item])
        
        return cell
    }
    

}
