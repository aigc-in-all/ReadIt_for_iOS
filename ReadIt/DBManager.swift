//
//  DBManager.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/31.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import Foundation

class DBManager {
    
    var db: SQLiteConnect?
    
    static let sharedInstance: DBManager = {
        let manager = DBManager()
        return manager
    }()
    
    func open() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let sqlitePath = urls[urls.count - 1].absoluteString + "sqlite3.db"
        
        // file:///Users/heqingbao/Library/Developer/CoreSimulator/Devices/8724985C-0295-4FE9-809D-E9797454E2DE/data/Containers/Data/Application/CA080F82-EAF5-4805-AC4E-CB78865CA479/Documents/sqlite3.db
        print(sqlitePath)
        
        db = SQLiteConnect(path: sqlitePath)
        
        if let mydb = db {
            mydb.createTable(tableName: "books", columnsInfo: [
                "id integer primary key autoincrement",
                "isbn text",
                "title text",
                "pages text",
                "author text",
                "pubdate text",
                "translator text",
                "image text",
                "publisher text",
                "authorIntro text",
                "summary text",
                "createdTime text"])
        }
    }
    
    func queryAll() -> [Book] {
        var books = [Book]()
        if let mydb = db {
            let statement = mydb.fetch(tableName: "books", cond: "1 == 1", order: nil)
            while sqlite3_step(statement) == SQLITE_ROW {
                let isbn = sqlite3_column_text(statement, 1)
                let title = sqlite3_column_text(statement, 2)
                let pages = sqlite3_column_text(statement, 3)
                let author = sqlite3_column_text(statement, 4)
                let pubdate = sqlite3_column_text(statement, 5)
                let translator = sqlite3_column_text(statement, 6)
                let image = sqlite3_column_text(statement, 7)
                let publisher = sqlite3_column_text(statement, 8)
//                let authorIntro = sqlite3_column_text(statement, 9)
                let summary = sqlite3_column_text(statement, 10)
                let createdTime = sqlite3_column_text(statement, 11)
                
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
                
                books.append(book)
            }
        }
        
        return books
    }
    
    func insertBook(book: Book) -> Bool {
        if let mydb = db {
            return mydb.insert(tableName: "books",
                               rowInfo: [
                                "isbn": "'\(book.isbn!)'",
                                "title": "'\(book.title!)'",
                                "pages": "'\(book.pages!)'",
                                "author": "'\(book.author!.joined(separator: "|"))'",
                                "pubdate": "'\(book.pubdate!)'",
                                "translator": "'\(book.translator!.joined(separator: "|"))'",
                                "image": "'\(book.image!)'",
                                "publisher": "'\(book.publisher!)'",
//                                "authorIntro": "'\(book.authorIntro!)'",
                                "summary": "'\(book.summary!)'",
                                "createdTime": "'\(book.createdTime!)'"
                                ]
                            )
            // 如果 authorIntro 和 summary 同时插入会失败，暂不清楚原因！！！
        }
        return false
    }
}
