//
//  RegistrViewController.swift
//  diss
//
//  Created by Ксения Полянцева on 26.10.17.
//  Copyright © 2017 Ксения Полянцева. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
var REGflag:Bool = false

class RegistrViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var datePickerTxt: UITextField!
    
    let datePicker = UIDatePicker()
    // URL
    let URL_USER_REGISTER = "http://62.109.0.179:3000/addNewPerson";
    let URL_USER_LOGIN = "http://62.109.0.179:3000/login";

    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerTxt.inputAccessoryView = toolbar
        datePickerTxt.inputView = datePicker
    }
    
    var age:Int = 0
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        datePickerTxt.text = dateFormatter.string(from: datePicker.date)
        
        
        // вычисление возраста
        let now = Date()
        let birthday: Date = datePicker.date
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        age = ageComponents.year!
        
        self.view.endEditing(true)
        
    }
    
    var sex: String = ""
    @IBAction func femaleButton(_ sender: Any) {
        sex = "female"
    }
    
    @IBAction func maleButton(_ sender: Any) {
        sex = "male"
    }
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldYesPassword: UITextField!
    @IBOutlet weak var textFieldProfession: UITextField!
    
    var activTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        self.textFieldPassword.delegate = self
        self.textFieldName.delegate = self
        self.textFieldYesPassword.delegate = self
        self.textFieldProfession.delegate = self
        
    }
    
    //убрать клавиатуру, когда тапаем вне клавиатуры
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldName.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        textFieldYesPassword.resignFirstResponder()
        textFieldProfession.resignFirstResponder()
        return (true)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        let UserName = textFieldName.text;
        let UserPassword = textFieldPassword.text;
        let YesPassword = textFieldYesPassword.text;
        let UserProfession = textFieldProfession.text;
        
        // проверка на пустые ячейки
        if((UserName?.isEmpty)! || (UserPassword?.isEmpty)! || (UserProfession?.isEmpty)! || (YesPassword?.isEmpty)! || (datePickerTxt.text?.isEmpty)!){
            // выводим сообщение
            DisplayMyAlertMassege(userMassege: "Не все поля заполнены!", flag: false);
            return;
        }
        
        // если пароли не совпадают
        if(UserPassword != YesPassword){
            // выводим сообщение
            DisplayMyAlertMassege(userMassege: "Введенные пароли не совпадают!", flag: false);
            return;
        }
        
        // P A R A M E T E R S
        //creating parameters for the post request
        let parameters: Parameters=[
            "username":textFieldName.text!,
            "password":textFieldPassword.text!,
            "age":String(age),
            "sex":sex,
            "direction_of_work":textFieldProfession.text!,
        ]
        
        let param: Parameters=[
            "username":textFieldName.text!,
            "password":textFieldPassword.text!,
            ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseString
            {
                responseString in
                //printing response
                print(responseString)
                
                if (responseString.result.value == "Такое имя пользователя уже существует!"){
                    //error message in case of invalid credential
                    self.DisplayMyAlertMassege(userMassege: "Пользователь с такими данными уже существует! Повторите попытку.", flag: false);
                } else {
                    REGflag = true
                    self.DisplayMyAlertMassege(userMassege: "Вы успешно зарегистрированы в системе!", flag: true);
                }
                
                Alamofire.request(self.URL_USER_LOGIN, method: .post, parameters: param).responseString
                    {
                        response in
                        //printing response
                        print(response)
                        
                }
                USID = self.textFieldName.text!
        }
    }
    
    // уведомление об ошибке
    func DisplayMyAlertMassege(userMassege: String, flag: Bool){
        
        let myAlert = UIAlertController(title: "Внимание!", message: userMassege, preferredStyle: UIAlertControllerStyle.alert);
        
        var okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        if (flag == true) {
             okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (action: UIAlertAction) -> Void in
                self.performSegue(withIdentifier: "okRegisterSegue", sender: self )
            }
        }
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion: nil);
    }
}
