//
//  HttpManager.swift
//  ReadIt
//
//  Created by heqingbao on 2017/3/31.
//  Copyright © 2017年 heqingbao. All rights reserved.
//

import Alamofire

class HttpManager {
    
    static let sharedInstance: HttpManager = {
        let manager = HttpManager()
        return manager
    }()
    
    func postRequest(urlString: String, params: [String: Any], success: @escaping ([String: AnyObject]) -> Void, failure: @escaping (NSError) -> Void) {
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let data = value as? [String: AnyObject] {
                    success(data)
                }
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
    func getRequest(urlString: String, params: [String: Any]?, success: @escaping ([String: AnyObject]) -> Void, failure: @escaping (NSError) -> Void) {
        Alamofire.request(urlString, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if let data = value as? [String: AnyObject] {
                    success(data)
                }
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
    func cancelAll() {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({ (task) in
                task.cancel()
            })
        }
    }
}
