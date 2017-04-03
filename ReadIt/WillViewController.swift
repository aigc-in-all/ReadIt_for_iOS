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
    
    var bookCellWidth: CGFloat = 0
    var bookCellHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "想读"
        self.view.backgroundColor = Constants.bgColor
        
        bookCellWidth = (self.view.bounds.width - 12 - 12 - 12 - 12) / 3
        bookCellHeight = bookCellWidth / 0.669 + 20 // 20 表示底部显示标题的高度
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        collectionView.backgroundColor = Constants.bgColor
        collectionView.register(BookViewCell.self, forCellWithReuseIdentifier: cellIdForContent)
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: cellIdForPlaceholder)
        
        self.view.addSubview(collectionView)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdForPlaceholder, for: indexPath) as! EmptyCell
        cell.emptyText = "最近一本书都不想读吗？亲，阅读贵在坚持，如果你改变了主意，请点击右下角的按钮添加书籍。"
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: bookCellWidth, height: bookCellHeight)
        return CGSize(width: self.view.bounds.width, height: bookCellHeight)
    }

}
