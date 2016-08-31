//
//  User.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/9/1.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class User: NSObject {

    var id: Int = 0
    
    var name: String?
    
    var profile_image_url: String?
    
    var verified: Bool = false
    
    var verified_type: Int = -1
    
    var user: User?
    
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        
        if "user" == key {
            user = User(dict: value as! [String : AnyObject])
            return
        }
    }
    
    // 打印当前模型
    var properties = ["id", "name", "profile_image_url", "verified", "verified_type",]
    override var description: String{
        let dict = dictionaryWithValuesForKeys(properties)
        
        return "\(dict)"
    }

}
