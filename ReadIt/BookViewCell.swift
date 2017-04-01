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
            
            if let title = book?.title {
                bookTitleLabel.text = title
            }
        }
    }
    
    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "test")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bottomBarView: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "23/879"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "百年孤独"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
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
        
        addSubview(bookImageView)
        bookImageView.addSubview(bottomBarView)
        
        addSubview(bookTitleLabel)
        
        bookImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bookImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bookImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bookImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        bottomBarView.leftAnchor.constraint(equalTo: bookImageView.leftAnchor).isActive = true
        bottomBarView.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: -20).isActive = true
        bottomBarView.rightAnchor.constraint(equalTo: bookImageView.rightAnchor).isActive = true
        bottomBarView.bottomAnchor.constraint(equalTo: bookImageView.bottomAnchor).isActive = true
        
        bookTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bookTitleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor).isActive = true
        bookTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bookTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        

    }
}
