//
//  SQLiteManager.swift
//  ReadIt
//
//  Created by heqingbao on 2017/4/4.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import Foundation

class SQLiteManager: NSObject {
    
    static let instance = SQLiteManager()
    
    var db: OpaquePointer?
    
    static func sharedInstance() -> SQLiteManager {
        return instance
    }
    
    func openDB() -> Bool {
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let dbPath = (documentPath! as NSString).appendingPathComponent("app.db")
        
        let resultCode = sqlite3_open(dbPath, &db)
        if resultCode != SQLITE_OK {
            print("数据库打开失败, code=\(resultCode), errmsg=\(String(cString: sqlite3_errmsg(db)))")
            return false
        }
        
        print("数据库打开成功: \(dbPath)")
        return createTables()
    }
    
    func createTables() -> Bool {
        let sql = "CREATE TABLE IF NOT EXISTS books (id integer primary key autoincrement,isbn text,title text,pages text,author text,pubdate text,translator text,image text,publisher text,author_intro text,summary text,created_time text,read_pages text)"
        return execSQL(sql: sql)
    }
    
    @discardableResult func execSQL(sql: String) -> Bool {
        let resultCode = sqlite3_exec(self.db, sql, nil, nil, nil)
        if resultCode == SQLITE_OK {
            return true
        }
        
        print("执行 \(sql) 失败, code=\(resultCode), errmsg=\(String(cString: sqlite3_errmsg(db)))")
        return false
    }
    
    func queryAll() -> [Book] {
        var books = [Book]()
        let query = "SELECT * FROM books"
        var stmt: OpaquePointer?
        let resultCode = sqlite3_prepare_v2(self.db, query, -1, &stmt, nil)
        if resultCode != SQLITE_OK {
            print("查询失败")
            return []
        }
        
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
    
    //id integer primary key autoincrement,isbn text,title text,pages text,author text,pubdate text,translator text,image text,publisher text,author_intro text,summary text,created_time text,read_pages text
    func insertBook(book: Book) -> Bool {
        let sql = "INSERT INTO books ('isbn', 'title', 'pages', 'author', 'pubdate', 'translator', 'image', 'publisher', 'author_intro', 'summary', 'created_time', 'read_pages') VALUES ('isbn', 'title', 'pages', 'author', 'pubdate', 'translator', 'image', 'publisher', 'author_intro', 'summary', 'created_time', 'read_pages') "
        var stmt: OpaquePointer?
        let resultCode = sqlite3_prepare_v2(self.db, sql, -1, &stmt, nil)
        if resultCode == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                return true
            }
            
            sqlite3_finalize(stmt)
        }
        
        return false
    }
}
