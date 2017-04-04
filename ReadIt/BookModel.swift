//
//  BookModel.swift
//  ReadIt
//
//  Created by heqingbao on 2017/4/4.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

class BookModel {
    
    static let instance = BookModel()
    
    // 所有正在读的书
    func queryAllByReading() -> [Book] {
        let books = BookDao.instance.queryAll(cond: "read_pages > 0")
        return books.filter({
            (book: Book) -> Bool in
                return Int(book.readPages!)! < Int(book.pages!)!
        })
    }
    
    // 所有已读完的书
    func queryAllByReaded() -> [Book] {
        let books = BookDao.instance.queryAll(cond: "read_pages > 0")
        return books.filter({
            (book: Book) -> Bool in
            return Int(book.readPages!)! == Int(book.pages!)!
        })
    }
    
    // 所有想读的书
    func queryAllByWant() -> [Book] {
        return BookDao.instance.queryAll(cond: "read_pages = 0")
    }
    
    func add(book: Book) -> Bool {
        return BookDao.instance.insertBook(book: book)
    }
    
    func delete(isbn: String) -> Bool {
        return BookDao.instance.deleteBy(isbn: isbn)
    }
    
    func update(book: Book) -> Bool {
        return BookDao.instance.update(book: book)
    }
    
    func query(isbn: String) -> Book? {
        return BookDao.instance.queryBy(isbn: isbn)
    }
    
    func bookExist(isbn: String) -> Bool {
        return self.query(isbn: isbn) != nil
    }
}
