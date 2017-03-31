//
//  Book.swift
//  ReadIt
//
//  Created by 何清宝 on 17/3/26.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import ObjectMapper

// https://api.douban.com/v2/book/isbn/:9787201094014
class Book: Mappable {
    
    var isbn: String?           // ISBN
    var title: String?          // 书名
    var pages: Int?             // 页数
    var author: [String]?         // 作者
    var pubdate: String?        // 发布时间
    var translator: String?     // 译者
    var image: String?          // 封面图片
    var publisher: String?      // 出版社
    var authorIntro: String?    // 作者介绍
    var summary: String?        // 简介
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        isbn        <- map["isbn10"]
        title       <- map["title"]
        pages       <- map["pages"]
        author      <- map["author"]
        pubdate     <- map["pubdate"]
        translator  <- map["translator"]
        image       <- map["image"]
        publisher   <- map["publisher"]
        authorIntro <- map["authorIntro"]
        summary     <- map["summary"]
    }

}
