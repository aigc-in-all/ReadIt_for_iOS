//
//  Book.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class Book: NSObject {
    
    var name: String        // 书名
    var pageCount: Int      // 总页数
    var isbn: String        // ISBN
    
    var readPage: Int?      // 已读页数
    
    init(name: String, isbn: String, pageCount: Int) {
        self.name = name
        self.isbn = isbn
        self.pageCount = pageCount
    }

}
