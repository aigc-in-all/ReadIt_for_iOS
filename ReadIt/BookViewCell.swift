//
//  BookViewCell.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/30.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class BookViewCell: UICollectionViewCell {
    
    var book: Book? {
        didSet {
            if let image = book?.image {
                bookImageView.af_setImage(
                    withURL: URL(string: image)!,
                    placeholderImage: nil,
                    filter: nil,
                    imageTransition: .crossDissolve(0.2)
                )
            }
        }
    }
    
    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bookNameLabel: UILabel = {
        let label = UILabel()
        label.text = "百年孤独"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressBar: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .bar)
        bar.progress = 0.7
        bar.trackTintColor = .gray
        bar.progressTintColor = .green
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.text = "70%"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.rgb(red: 138, green: 138, blue: 138)
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        
        addSubview(bookImageView)
        
        bookImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bookImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        bookImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bookImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
