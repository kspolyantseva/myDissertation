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
    
    
   // var URL_USER_TRACKS = "http://62.109.0.179:3000/trackUser?username=" // добавить имя пользователя !!!!!
    
    // пользователи
    @IBOutlet weak var usersTextView: UITextField!
    @IBOutlet weak var usersPicker: UIPickerView!
    
    
    @IBAction func usersButton(_ sender: Any) {
        
       // var changeName = usersTextView.text!.index(of: " ")
        var changeName = usersTextView.text!
        changeName = changeName.replacingOccurrences(of: " ", with: "%20")
//        URL_USER_TRACKS = URL_USER_TRACKS + changeName
//        // запрос треков
//
//                let parameters: Parameters=[
//                    "username":usersTextView.text!
//                ]
//                Alamofire.request(URL_USER_TRACKS, method: .get, parameters: parameters).responseJSON
//                    {
//                        response in
//                        //printing response
//                        self.valueTrack = response.result.value as! [AnyObject]
//                        print(response)
//                }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var counrows: Int = values.count
        return counrows
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == usersPicker {
            let titleRow = (values[row] as? String)!
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      //  if values.count > 1 && values.count >= row{
        if pickerView == usersPicker {
            self.usersTextView.text = String(describing: values[row])
            print(values[row])
            self.usersPicker.isHidden = true
        }
     //   }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.usersTextView {
            self.usersPicker.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
