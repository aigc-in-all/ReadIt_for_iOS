//
//  ReadViewController.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellIdForContent = "content"
    let cellIdForPlaceholder = "placeholder"
    
    var books = [Book]()
    
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "已读"
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
        books.append(contentsOf: BookModel.instance.queryAllByReaded())
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
            cell.emptyText = "阅读完成的书会放到这里，如果这里暂时没有内容，没什么好奇怪的，可能是你正在阅读中。但要是阅读中的列表也是空白，那就是你的不对了。"
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
