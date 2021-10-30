//
//  ViewController.swift
//  PinterestDemo
//
//  Created by Łukasz Jakubek on 28/06/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //MARK: Property
    
    let api = ApiCaller()
    
    var results: [Result] = []
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        searchBar.placeholder = "Wyszukaj"
        return searchBar
    }()
    
    
    let collectView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    
    let placeholderImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.8, height: 250))
        imageView.image = UIImage(named: "image1")!
        return imageView
    }()
    
    var titleVc: String = ""

    //MARK: Life cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectView.delegate = self
        collectView.dataSource = self
        searchBar.delegate = self

        collectView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        collectView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.indentifier)
        collectView.backgroundColor = .white
        
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(collectView)
        collectView.frame = view.bounds
        
     
        
        
        if results.isEmpty {
            view.addSubview(placeholderImage)
            placeholderImage.center = view.center
        }
    }


}

extension ViewController {
    
    @objc func presentationDetail() {
        print("jestem")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.configureImage(urlString: results[indexPath.row].urls.full)
        return cell
    }
    
}

extension ViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (view.frame.size.width * 0.5) - 4, height: (UIScreen.main.bounds.width * 0.5) * 0.6)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 2, bottom: 10, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.title = self.titleVc
        let navVC = UINavigationController(rootViewController: vc)
        vc.configureImage(urlString: results[indexPath.row].urls.full)
       present(navVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.indentifier, for: indexPath) as! Header
        header.configureHeader()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}


extension ViewController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.placeholderImage.isHidden = true
        
        guard let text = searchBar.text else {
            return
        }
        
        self.titleVc = text
        
        searchBar.resignFirstResponder()
        
        api.fetchData(query: text) { results in
            DispatchQueue.main.async {
                self.results = results
                self.collectView.reloadData()
            }
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
  
}

