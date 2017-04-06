//
//  ViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

import AlamofireImage
import SwiftyJSON

class ReadingBookViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var books = [Book]()
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "在读"
        self.view.backgroundColor = UIColor.bgColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(onAddButtonClicked))
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(BookViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(collectionView!)
        
        UserDefaults.standard.addObserver(self, forKeyPath: SettingsViewController.KEY_SHOW_PROGRESS_BY_PERCENTAGE, options: .new, context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        books.removeAll()
        books.append(contentsOf: BookModel.instance.queryAllByReading())
        collectionView?.reloadData()
    }
    
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: SettingsViewController.KEY_SHOW_PROGRESS_BY_PERCENTAGE, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        collectionView?.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookViewCell
        cell.book = books[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 80)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.isbn = books[indexPath.item].isbn
        detailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Custom acitons
    
    func onAddButtonClicked() {
//        let addBookViewController = AddBookViewController()
////        addBookViewController.callback = { book in
////            self.books.append(book)
////            let indexPath = IndexPath(item: self.books.count - 1, section: 0)
////            self.collectionView?.insertItems(at: [indexPath])
////        }
//        let navController = UINavigationController(rootViewController: addBookViewController)
//        present(navController, animated: true, completion: nil)
        
        let searchController = SearchTableViewController(style: .plain)
        self.navigationController?.pushViewController(searchController, animated: true)
    }
}
