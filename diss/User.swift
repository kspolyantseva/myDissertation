//
//  User.swift
//  diss
//
//  Created by Ксения Полянцева on 04.11.17.
//  Copyright © 2017 Ксения Полянцева. All rights reserved.
//

import Foundation
import SwiftyJSON



class User {
    var logname:String?
    var id:String?
    var gen:String?
    static let currentUser = User()
    
    func setUser(_ json: JSON){
        logname = json["name"].string!
        id = json["id"].string!
        gen = json["gender"].string!
    }
}
