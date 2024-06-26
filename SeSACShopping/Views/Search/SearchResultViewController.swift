//
//  SearchResultViewController.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/21.
//

import UIKit
import Alamofire

class SearchResultViewController: UIViewController {
    
    enum sortType: String, CaseIterable {
        case sim
        case date
        case asc
        case dsc
    }

    @IBOutlet var serachResultCollectionView: UICollectionView!
    var searchList: [Item] = [] {
        didSet { //변경된 직후 -> 프로퍼티 옵저버.
            serachResultCollectionView.reloadData()
        }
    }
    let searchManager = SearchAPIManager()
    var text: String = ""
    var start: Int = 1
    var countItems: String!
    var selectType: sortType = .sim
    @IBOutlet var totalSearchNumLabel: UILabel!
    @IBOutlet var sortBtns: [UIButton]!
    var templikeList: [Int] = []
    var likeList = UserDefaultsManager.shared.likes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        templikeList = likeList ?? []
        callRequest(text: text, start: start, sort: selectType.rawValue)
        registerCell()
        configureView()
        configureLayout()
    }
    
    
    func configureView(){
        self.view.backgroundColor = .black
        
        navigationItem.title = text
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .white
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        serachResultCollectionView.backgroundColor = .clear
        serachResultCollectionView.dataSource = self
        serachResultCollectionView.delegate = self
        serachResultCollectionView.prefetchDataSource = self
        
        totalSearchNumLabel.textColor = .accent
        totalSearchNumLabel.font = .systemFont(ofSize: 16)
        
        sortBtnStyle(btn: sortBtns[0], text: "정확도", isSelected: true)
        sortBtns[0].addTarget(self, action: #selector(changeSortType(_:)), for: .touchUpInside)
        sortBtnStyle(btn: sortBtns[1], text: "날짜순", isSelected: false)
        sortBtns[1].addTarget(self, action: #selector(changeSortType(_:)), for: .touchUpInside)
        sortBtnStyle(btn: sortBtns[2], text: "가격높은순", isSelected: false)
        sortBtns[2].addTarget(self, action: #selector(changeSortType(_:)), for: .touchUpInside)
        sortBtnStyle(btn: sortBtns[3], text: "가격낮은순", isSelected: false)
        sortBtns[3].addTarget(self, action: #selector(changeSortType(_:)), for: .touchUpInside)
    }
    
    func sortBtnStyle(btn: UIButton, text: String, isSelected: Bool) {
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.setTitleColor(isSelected ? .black : .white, for: .normal)
        btn.layer.borderWidth = 1
        btn.backgroundColor = isSelected ? .white : .black
        btn.layer.borderColor = UIColor.white.cgColor
        btn.layer.cornerRadius = 8
        btn.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    @objc func changeSortType(_ sender: UIButton){
        if sender.titleLabel?.text == "정확도" {
            selectType = .sim
            searchManager.callRequest(text: text, start: 1, sort: selectType.rawValue) { Shopping in
                self.searchList = Shopping.items
                self.sortBtnStyle(btn: self.sortBtns[0], text: "정확도", isSelected: true)
                self.sortBtnStyle(btn: self.sortBtns[1], text: "날짜순", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[2], text: "가격높은순", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[3], text: "가격낮은순", isSelected: false)
                self.searchList.removeAll()
                self.callRequest(text: self.text, start: 1, sort: sortType.sim.rawValue)
            }
        } else if sender.titleLabel?.text == "날짜순" {
            selectType = .date
            searchManager.callRequest(text: text, start: 1, sort: selectType.rawValue) { Shopping in
                self.searchList = Shopping.items
                self.sortBtnStyle(btn: self.sortBtns[0], text: "정확도", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[1], text: "날짜순", isSelected: true)
                self.sortBtnStyle(btn: self.sortBtns[2], text: "가격높은순", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[3], text: "가격낮은순", isSelected: false)
                self.searchList.removeAll()
                self.callRequest(text: self.text, start: 1, sort: sortType.date.rawValue)
            }
        } else if sender.titleLabel?.text == "가격높은순" {
            selectType = .dsc
            searchManager.callRequest(text: text, start: 1, sort: selectType.rawValue) { Shopping in
                self.searchList = Shopping.items
                self.sortBtnStyle(btn: self.sortBtns[0], text: "정확도", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[1], text: "날짜순", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[2], text: "가격높은순", isSelected: true)
                self.sortBtnStyle(btn: self.sortBtns[3], text: "가격낮은순", isSelected: false)
                self.searchList.removeAll()
                self.callRequest(text: self.text, start: 1, sort: sortType.dsc.rawValue)
            }
        } else if sender.titleLabel?.text == "가격낮은순" {
            selectType = .asc
            searchManager.callRequest(text: text, start: 1, sort: selectType.rawValue) { Shopping in
                self.searchList = Shopping.items
                self.sortBtnStyle(btn: self.sortBtns[0], text: "정확도", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[1], text: "날짜순", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[2], text: "가격높은순", isSelected: false)
                self.sortBtnStyle(btn: self.sortBtns[3], text: "가격낮은순", isSelected: true)
                self.searchList.removeAll()
                self.callRequest(text: self.text, start: 1, sort: sortType.asc.rawValue)
            }
        }
    }
    
    func registerCell(){
        let xib = UINib(nibName: SearchResultCollectionViewCell.identifier, bundle: nil)
        serachResultCollectionView.register(xib, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
    }
    
    func configureLayout(){
        let layer = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/2
        let height = UIScreen.main.bounds.height/3
        layer.itemSize = CGSize(width: width, height: height)
        layer.minimumLineSpacing = 0
        layer.minimumInteritemSpacing = 0
        serachResultCollectionView.collectionViewLayout = layer
    }
    
    func callRequest(text: String, start: Int, sort: String) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret]
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=20&start=\(start)&sort=\(sort)"
        
        let parameters: Parameters = [
            "query": query
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let success):
                if start == 1 {
                    self.searchList = success.items
                } else {
                    self.searchList.append(contentsOf: success.items)
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
    }

}


extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        cell.heartBtn.tag = Int(searchList[indexPath.item].productID)!
        cell.heartBtn.addTarget(self, action: #selector(tapHeartBtn), for: .touchUpInside)
        
        let productID = Int(searchList[indexPath.item].productID)
        let containsProductID = templikeList.contains(productID!)
        
        cell.configureCell(searchList[indexPath.item])
        if  containsProductID == true {
            cell.heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        serachResultCollectionView.reloadItems(at: [indexPath])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap")
        let sb = UIStoryboard(name: "Search", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: SearchDetailViewController.identifier) as! SearchDetailViewController
        
        vc.id = searchList[indexPath.item].productID
        vc.navTitle = searchList[indexPath.item].title
        
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func tapHeartBtn(_ sender: UIButton) {
        if let index = templikeList.firstIndex(of: sender.tag) {
            templikeList.remove(at: index)
            } else {
            templikeList.append(sender.tag)
        }
        UserDefaultsManager.shared.likes = templikeList
        print(templikeList)
    }
        
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if searchList.count - 2 <= item.item {
                start += 20
                print(start)
                callRequest(text: text, start: start, sort: selectType.rawValue)
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("cancelPrefetch \(indexPaths)")
    }
    
}
