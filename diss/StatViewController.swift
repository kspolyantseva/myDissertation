//
//  StatViewController.swift
//  diss
//
//  Created by Ksenia Polyantseva on 01.12.17.
//  Copyright © 2017 Ксения Полянцева. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StatViewController: UIViewController {
    
    let URL_GET_USERS = "http://62.109.0.179:3000/users";
    let URL_USER_TRACKS = "http://62.109.0.179:3000/trackUser?username=" // добавить имя пользователя !!!!!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // запрос юзеров
        Alamofire.request(URL_GET_USERS, method: .get, parameters: [:]).responseJSON
            {
                response in
                //printing response
                print(response)
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
