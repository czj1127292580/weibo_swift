//
//  Status.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/31.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class Status: NSObject {

    // 微博创建时间
    var created_at: String?
    
    // 微博id
    var id: Int = 0
    
    // 微博信息内容
    var text: String?
    
    // 微博来源
    var source: String?
    
    // 配图数组
    var pic_urls: [[String: AnyObject]]?
    
    /// 用户信息
    var user: User?
    
    
    
    class func loadStatuses(finished: (models:[Status]?, error: NSError?) -> ()) {
        
        let path = "2/statuses/home_timeline.json"
        let params = ["access_token" : UserAccount.loadAccount()!.access_token!]
        
        NetWorkTools.shareNetWorkTools().GET(path, parameters: params, progress: nil, success: { (_, JSON) in
            
            let models = dict2Model(JSON!["statuses"] as! [[String: AnyObject]])
//            print(models)
            
            // 通过闭包将数据传递给调用者
            finished(models: models, error: nil)
            
            }) { (_, error) in
         
                finished(models: nil, error: error)
//                print(error)
        }
        
        
    }
    
    // 字典转模型
    class func dict2Model(list: [[String: AnyObject]]) -> [Status] {
        
        var models = [Status]()
        for dict in list {
            
            models.append(Status(dict: dict))
        }
        
        return models
    }
    
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        // 判断当前是否正在给微博字典中的user字典赋值
        if "user" == key {
            // 根据user key 对应的字典创建一个模型
            user = User(dict: value as! [String : AnyObject])
            return
        }
        
        // 调用父类方法，按照系统默认处理
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    // 打印当前模型
    var properties = ["created_at", "id", "text", "source", "pic_urls",]
    override var description: String{
        let dict = dictionaryWithValuesForKeys(properties)
        
        return "\(dict)"
    }
    
}
