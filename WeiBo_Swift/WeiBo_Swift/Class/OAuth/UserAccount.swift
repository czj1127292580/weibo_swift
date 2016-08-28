//
//  UserAccount.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/28.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class UserAccount: NSObject, NSCoding {

    var access_token: String?
    
    var expires_in: NSNumber?
    
    var uid: String?
    
    override init() {
        
    }
    
    init(dict: [String: AnyObject]) {
        
        access_token = dict["access_token"] as? String
        expires_in = dict["expires_in"] as? NSNumber
        uid = dict["uid"] as? String
    }
    
    override var description: String{
        
        let properties = ["access_token","expires_in","uid"]
        let dict = self.dictionaryWithValuesForKeys(properties)
        return "\(dict)"
        
    }
    
    // MARK: - 保存和读取
    /**
     保存授权模型
     */

    func saveAccount() {
        
        NSKeyedArchiver.archiveRootObject(self, toFile: "account.plist".cacheDir())
    }
    
    /**
     加载授权模型
     
     - returns: 用户模型
     */
    class func loadAccount() -> UserAccount? {
        
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile("account.plist".cacheDir()) as? UserAccount
        
        return account
        
    }
    
    // MARK: - NSCoding
    // 将对象写入到文件中
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")

        
    }
    
    // 从文件中读取对象
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        
    }
    
    
}
