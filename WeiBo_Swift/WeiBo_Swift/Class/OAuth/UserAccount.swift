//
//  UserAccount.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/28.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserAccount: NSObject, NSCoding {

    var access_token: String?
    
    var expires_in: NSNumber?{
        didSet{
            // 根据过期的秒数，生成真正的过期时间
            expires_Date = NSDate(timeIntervalSinceNow: (expires_in?.doubleValue)!)
        }
    }
    
    var uid: String?
    
    // 保存用户信息过期时间
    var expires_Date: NSDate?
    
    // 用户头像地址
    var avatar_large: String?
    
    // 用户昵称
    var screen_name: String?
    
    
    
    override init() {
        
    }
    
    init(dict: [String: AnyObject]) {
        
//        access_token = dict["access_token"] as? String
//        expires_in = dict["expires_in"] as? NSNumber
//        uid = dict["uid"] as? String
        super.init()
        
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print(key)
    }
    
    override var description: String{
        
        let properties = ["access_token","expires_in","uid", "expires_Date", "avatar_large", "screen_name"]
        let dict = self.dictionaryWithValuesForKeys(properties)
        return "\(dict)"
        
    }
    
    func loadUserInfo(finished: (account: UserAccount?, error: NSError?) -> ()) {
        
        assert(access_token != nil, "没有授权")
        
        let path = "2/users/show.json"
        let params = ["access_token":access_token!,
                      "uid":uid!]
        
        NetWorkTools.shareNetWorkTools().GET(path, parameters: params, progress: nil, success: { (_, JSON) in
            
            // 判断字典是否有值
            if let dict = JSON as? [String: AnyObject]{
                self.screen_name = dict["screen_name"] as? String
                self.avatar_large = dict["avatar_large"] as? String
                
                // 归档模型, 保存用户信息
//                self.saveAccount()
                finished(account: self, error: nil)
                return
            }
            
                finished(account: nil, error: nil)
        }) { (_, error) in
//            SVProgressHUD.showInfoWithStatus("网络不给力...", maskType: SVProgressHUDMaskType.Black)
            finished(account: nil, error: error)
        }
        
    }
    
    /**
     返回用户是否登录
     */
    class func userLogin() -> Bool {
        return UserAccount.loadAccount() != nil
    }
    
    // MARK: - 保存和读取
    /**
     保存授权模型
     */ 
    static let filePath = "account.plist".cacheDir()
    func saveAccount() {
        
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    
    /**
     加载授权模型
     
     - returns: 用户模型
     */
    static var account: UserAccount?
    class func loadAccount() -> UserAccount? {
        
        // 判断是否已经加载
        if account != nil {
            return account
        }
        // 加载授权模型
        account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? UserAccount
        
        // 判断授权信息是否过期
        if account?.expires_Date?.compare(NSDate()) == NSComparisonResult.OrderedAscending {
            // 已经过期
            return nil
        }
        
        return account
        
    }
    
    // MARK: - NSCoding
    // 将对象写入到文件中
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_Date, forKey: "expires_Date")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        
    }
    
    // 从文件中读取对象
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_Date = aDecoder.decodeObjectForKey("expires_Date") as? NSDate
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
    }
    
    
}
