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

class StatViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate  {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.values.count
    }
    
    
    var values: [AnyObject] = []
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = (values[row] as? String)!
        return titleRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if values.count > 1 && values.count >= row{
            self.usersTextView.text = self.values[row] as? String
            self.usersPicker.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.usersTextView {
            self.usersPicker.isHidden = false
        }
    }
    
  //  let URL_GET_USERS = NSURL(string: "http://62.109.0.179:3000/users")
    
    let URL_GET_USERS = "http://62.109.0.179:3000/users"
    var URL_USER_TRACKS = "http://62.109.0.179:3000/trackUser?username=" // добавить имя пользователя !!!!!
    
    // пользователи
    @IBOutlet weak var usersTextView: UITextField!
    @IBOutlet weak var usersPicker: UIPickerView!
    
    @IBAction func usersButton(_ sender: Any) {
//        tracksPicker.isHidden = false
//        tracksTextView.isHidden = false
//        tracksButton.isHidden = false
        URL_USER_TRACKS = URL_USER_TRACKS + usersTextView.text!
        // запрос треков
        
//        let parameters: Parameters=[
//            "username":usersTextView.text!
//        ]
//        Alamofire.request(URL_USER_TRACKS, method: .get, parameters: parameters).responseJSON
//            {
//                response in
//                //printing response
//                print(response)
//        }
    }
    
    // треки
    @IBOutlet weak var tracksTextView: UITextField!
    @IBOutlet weak var tracksPicker: UIPickerView!
    @IBOutlet weak var tracksButton: UIButton!
    @IBAction func tracksButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let data = NSData(contentsOf: URL_GET_USERS! as URL)
//        var tmpValues = try!
//            JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
//        tmpValues = tmpValues.reversed() as NSArray
//        reloadInputViews()
//
//        for candidate in tmpValues{
//            if let cdict = candidate as? NSDictionary{
//                let names = cdict["username"]
//                self.values.append(names! as AnyObject)
//                print(names)
//            }
//        }
        
        // запрос юзеров
        Alamofire.request(URL_GET_USERS, method: .get, parameters: [:]).responseJSON
            {
                response in
                //printing response
                print(response)
                self.values.append(response.result.value as AnyObject)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
