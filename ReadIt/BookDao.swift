//
//  BookDao.swift
//  ReadIt
//
//  Created by heqingbao on 2017/4/4.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import Foundation

class BookDao: BaseDao {
    
    static let instance = BookDao()
    
    let tableName = "books"
    
    func insertBook(book: Book) -> Bool {
        
        var rowInfo = [String: String]()
        rowInfo["isbn"] = book.isbn
        rowInfo["title"] = book.title
        rowInfo["pages"] = book.pages
        rowInfo["author"] = book.author!.joined(separator: "|")
        rowInfo["pubdate"] = book.pubdate
        rowInfo["translator"] = book.translator!.joined(separator: "|")
        rowInfo["image"] = book.image
        rowInfo["publisher"] = book.publisher
//        rowInfo["author_intro"] = book.authorIntro
        rowInfo["summary"] = book.summary
        rowInfo["created_time"] = book.createdTime
        rowInfo["read_pages"] = book.readPages
        
        return insert(tableName: tableName, rowInfo: rowInfo)
    }
    
    func queryBy(isbn: String) -> Book? {
        
        let stmt = fetch(tableName: tableName, cond: "isbn = '\(isbn)'", order: nil)
        if sqlite3_step(stmt) == SQLITE_ROW {
            let isbn = sqlite3_column_text(stmt, 1)
            let title = sqlite3_column_text(stmt, 2)
            let pages = sqlite3_column_text(stmt, 3)
            let author = sqlite3_column_text(stmt, 4)
            let pubdate = sqlite3_column_text(stmt, 5)
            let translator = sqlite3_column_text(stmt, 6)
            let image = sqlite3_column_text(stmt, 7)
            let publisher = sqlite3_column_text(stmt, 8)
            //                let authorIntro = sqlite3_column_text(statement, 9)
            let summary = sqlite3_column_text(stmt, 10)
            let createdTime = sqlite3_column_text(stmt, 11)
            let readPages = sqlite3_column_text(stmt, 12)
            
            let book = Book()
            book.isbn = String(cString: isbn!)
            book.title = String(cString: title!)
            book.pages = String(cString: pages!)
            book.author = String(cString: author!).components(separatedBy: "|")
            book.pubdate = String(cString: pubdate!)
            book.translator = String(cString: translator!).components(separatedBy: "|")
            book.image = String(cString: image!)
            book.publisher = String(cString: publisher!)
            //                book.authorIntro = String(cString:authorIntro!)
            book.summary = String(cString: summary!)
            
            book.createdTime = String(cString: createdTime!)
            book.readPages = String(cString: readPages!)
            
            return book
        }
        
        return nil
    }
    
    func queryAll(cond: String) -> [Book] {
        var books = [Book]()
        
        let stmt = fetch(tableName: tableName, cond: cond, order: nil)
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let isbn = sqlite3_column_text(stmt, 1)
            let title = sqlite3_column_text(stmt, 2)
            let pages = sqlite3_column_text(stmt, 3)
            let author = sqlite3_column_text(stmt, 4)
            let pubdate = sqlite3_column_text(stmt, 5)
            let translator = sqlite3_column_text(stmt, 6)
            let image = sqlite3_column_text(stmt, 7)
            let publisher = sqlite3_column_text(stmt, 8)
            //                let authorIntro = sqlite3_column_text(statement, 9)
            let summary = sqlite3_column_text(stmt, 10)
            let createdTime = sqlite3_column_text(stmt, 11)
            let readPages = sqlite3_column_text(stmt, 12)
            
            let book = Book()
            book.isbn = String(cString: isbn!)
            book.title = String(cString: title!)
            book.pages = String(cString: pages!)
            book.author = String(cString: author!).components(separatedBy: "|")
            book.pubdate = String(cString: pubdate!)
            book.translator = String(cString: translator!).components(separatedBy: "|")
            book.image = String(cString: image!)
            book.publisher = String(cString: publisher!)
            //                book.authorIntro = String(cString:authorIntro!)
            book.summary = String(cString: summary!)
            
            book.createdTime = String(cString: createdTime!)
            book.readPages = String(cString: readPages!)
            
            books.append(book)
        }
        
        return books
    }
    
    func update(book: Book) -> Bool {
        var rowInfo = [String: String]()
        rowInfo["title"] = book.title
        rowInfo["pages"] = book.pages
        rowInfo["author"] = book.author!.joined(separator: "|")
        rowInfo["pubdate"] = book.pubdate
        rowInfo["translator"] = book.translator!.joined(separator: "|")
        rowInfo["image"] = book.image
        rowInfo["publisher"] = book.publisher
        //        rowInfo["author_intro"] = book.authorIntro
        rowInfo["summary"] = book.summary
        rowInfo["created_time"] = book.createdTime
        rowInfo["read_pages"] = book.readPages
        
        return super.update(tableName: tableName, cond: "isbn = \"\(book.isbn!)\"", rowInfo: rowInfo)
    }
    
    func deleteBy(isbn: String) -> Bool {
        return delete(tableName: tableName, cond: "isbn = \"\(isbn)\"")
    }
}
