//
//  FacebookManager.swift
//  diss
//
//  Created by Ксения Полянцева on 30.10.17.
//  Copyright © 2017 Ксения Полянцева. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftyJSON
import Alamofire

var uslogname:String = ""
var usid:String = ""
var usgen:String = ""


class FacebookManager {
    
    
    static let shared = FBSDKLoginManager()
    static let fbm = FacebookManager()
    
    public class func getUserData(completion: @escaping () -> Void) {
        if FBSDKAccessToken.current() != nil{
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"]).start(completionHandler: { (connection, result, error) in
            if error == nil{
                let json = JSON(result!)
                uslogname = json["name"].string!
                usid = json["id"].string!
//                usgen = json["gender"].string!
                
                print(json)
                
                completion()
            }
        })
    }
        
}
}
