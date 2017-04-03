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
            
            if let author = book?.author {
                authorLabel.text = author.joined(separator: ",")
            }
        }
    }
    
    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "作者"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "百年孤独"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
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
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.dividerColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.backgroundColor = .white
        
        addSubview(bookImageView)
        addSubview(authorLabel)
        addSubview(bookTitleLabel)
        addSubview(progressBar)
        addSubview(progressLabel)
        addSubview(dividerView)

        bookImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        bookImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        bookImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
        bookImageView.widthAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: 0.669).isActive = true
        
        authorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 12).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: progressLabel.leftAnchor, constant: -12).isActive = true
        
        bookTitleLabel.leftAnchor.constraint(equalTo: authorLabel.leftAnchor).isActive = true
        bookTitleLabel.bottomAnchor.constraint(equalTo: authorLabel.topAnchor, constant: -6).isActive = true
        
        progressBar.leftAnchor.constraint(equalTo: authorLabel.leftAnchor).isActive = true
        progressBar.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8).isActive = true
        progressBar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
        progressLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        progressLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
        progressLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
        dividerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dividerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        

    }
}
