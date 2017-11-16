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
class RegistrViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var datePickerTxt: UITextField!
    
    let datePicker = UIDatePicker()
    // URL
    let URL_USER_REGISTER = "http://ksssq.online/v1/register.php";

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
    var activTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        self.textFieldPassword.delegate = self
        self.textFieldName.delegate = self
        self.textFieldYesPassword.delegate = self
        
    }
    
    // убрать клавиатуру, когда тапаем вне клавиатуры
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldName.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        textFieldYesPassword.resignFirstResponder()
        return (true)
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        
        let UserName = textFieldName.text;
        let UserPassword = textFieldPassword.text;
        let YesPassword = textFieldYesPassword.text;
        
        // проверка на пустые ячейки
        if((UserName?.isEmpty)! || (UserPassword?.isEmpty)! || (YesPassword?.isEmpty)! || (datePickerTxt.text?.isEmpty)!){
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
        
        let ranID = textFieldName.text! + String(arc4random_uniform(100000) + 1)
        USID = ranID
        
        //creating parameters for the post request
        let parameters: Parameters=[
            "UserID":ranID,
            "Login":textFieldName.text!,
            "Password":textFieldPassword.text!,
            "Age":String(age),
            "Sex":sex,
        ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)

                //получаем json значение с сервера
                if let result = response.result.value {
                    
                    //конвертируем как NSDictionary
                    let jsonData = result as! NSDictionary
                    let mes = jsonData.value(forKey: "message") as! String?
                    //if (mes == "User created successfully"){
                      //  self.DisplayMyAlertMassege(userMassege: "Вы успешно зарегистрированы в системе!", flag: true);
                    if (mes == "Some error occurred"){
                        self.DisplayMyAlertMassege(userMassege: "Ошибка! Повторите попытку.", flag: false);
                    } else {
                        if (mes == "User already exist"){
                            self.DisplayMyAlertMassege(userMassege: "Пользователь с такими данными уже существует! Повторите попытку.", flag: false);
                        } else {
                                self.DisplayMyAlertMassege(userMassege: "Вы успешно зарегистрированы в системе!", flag: true);
                        }
                    }
                    
                }
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
