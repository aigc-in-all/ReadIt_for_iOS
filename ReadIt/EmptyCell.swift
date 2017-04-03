//
//  EmptyCell.swift
//  ReadIt
//
//  Created by 何清宝 on 17/4/2.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class EmptyCell: UICollectionViewCell {
    
    var emptyText: String? {
        didSet {
            if let text = emptyText {
                emptyLabel.text = text
            }
        }
    }
    
    let emptyLabel: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.backgroundColor = UIColor.clear
        view.textColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(emptyLabel)
        
        emptyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        emptyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        emptyLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        emptyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
    }
    
}
