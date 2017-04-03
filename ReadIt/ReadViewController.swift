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
    
    var bookCellWidth: CGFloat = 0
    var bookCellHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "已读"
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
        cell.emptyText = "阅读完成的书会放到这里，如果这里暂时没有内容，没什么好奇怪的，可能是你正在阅读中。但要是阅读中的列表也是空白，那就是你的不对了。"
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: bookCellWidth, height: bookCellHeight)
        return CGSize(width: self.view.bounds.width, height: bookCellHeight)
    }
}
