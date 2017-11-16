//
//  ViewController.swift
//  diss
//
//  Created by Ксения Полянцева on 26.10.17.
//  Copyright © 2017 Ксения Полянцева. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON
var USID:String = ""
var FBflag:Bool = false

class EnterViewController: UIViewController, UITextFieldDelegate {
    
    static let Ent = EnterViewController()

   var loginSuccess = false
    
    
    let URL_USER_LOGIN = "http://ksssq.online/v1/login.php";
    
    let defaultValues = UserDefaults.standard

    @IBAction func regButton(_ sender: Any) {
    //    self.performSegue(withIdentifier: "RegistrViewSegue", sender: self )
    }
    
    @IBOutlet weak var FBLogin: UIButton!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    
    
    @IBAction func loginButton(_ sender: Any) {
        let parameters: Parameters=[
            "Login":textFieldName.text!,
            "Password":textFieldPassword.text!
        ]
        
        ////
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        self.performSegue(withIdentifier: "GoAfterLoginSegue", sender: self )
                    }else{
                        //error message in case of invalid credential
                        self.DisplayMyAlertMassege(userMassege: "Пользователя с такими данными не существует! Повторите попытку.");
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0/255, green: 179/255, blue: 159/255, alpha: 1.0)
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        self.textFieldPassword.delegate = self
        self.textFieldName.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        if FBSDKAccessToken.current() != nil {
            FacebookManager.getUserData(completion: {
                self.FBLogin.setTitle("Продолжить как \(uslogname)", for: .normal)
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FBSDKAccessToken.current() != nil && loginSuccess == true)  {
            performSegue(withIdentifier: "ClientView", sender: self)
        }
    }
    
    
// убрать клавиатуру, когда тапаем вне клавиатуры
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldName.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return (true)
    }
    
    @IBAction func facebookLofinButton(_ sender: Any) {
        if (FBSDKAccessToken.current() != nil) {
            self.loginSuccess = true
            self.viewDidAppear(true)
            FBflag = false
        } else {
            FBflag = true
            FacebookManager.shared.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: { (result, error) in
                if error == nil {
                    FacebookManager.getUserData(completion: {
                        self.loginSuccess = true
                        self.viewDidAppear(true)
                        
                    })
                }
            })
        
        }
    }
    
    // уведомление об ошибке
    func DisplayMyAlertMassege(userMassege: String){
        
        let myAlert = UIAlertController(title: "Внимание!", message: userMassege, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated:true, completion: nil);
    }
    
}

