//
//  Book.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import UIKit

class Book: NSObject {
    
    var isbn: String            // ISBN
    var title: String           // 书名
    var pages: Int             // 页数
    var author: String?         // 作者
    var pubdate: String?        // 发布时间
    var translator: String?     // 译者
    var image: String?          // 封面图片
    var publisher: String?      // 出版社
    var authorIntro: String?    // 作者介绍
    var summary: String?        // 简介
    
    init(isbn: String, title: String, pages: Int) {
        self.isbn = isbn
        self.title = title
        self.pages = pages
    }

}
