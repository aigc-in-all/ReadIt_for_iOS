//
//  WillViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class WillViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellIdForContent = "content"
    let cellIdForPlaceholder = "placeholder"
    
    var collectionView: UICollectionView?
    
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "想读"
        self.view.backgroundColor = UIColor.bgColor
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.bgColor
        collectionView?.register(BookViewCell.self, forCellWithReuseIdentifier: cellIdForContent)
        collectionView?.register(EmptyCell.self, forCellWithReuseIdentifier: cellIdForPlaceholder)
        
        self.view.addSubview(collectionView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        books.removeAll()
        books.append(contentsOf: BookModel.instance.queryAllByWant())
        collectionView?.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if books.isEmpty {
            return 1
        } else {
            return books.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if books.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdForPlaceholder, for: indexPath) as! EmptyCell
            cell.emptyText = "最近一本书都不想读吗？亲，阅读贵在坚持，如果你改变了主意，请点击右下角的按钮添加书籍。"
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdForContent, for: indexPath) as! BookViewCell
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

}
