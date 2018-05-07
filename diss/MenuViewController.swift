import UIKit
import Alamofire
import FBSDKLoginKit
import SwiftyJSON
var values: [AnyObject] = []

class MenuViewController: UIViewController, UITextFieldDelegate {
    
 //   @IBOutlet weak var navigationController: UINavigationItem!
    @IBAction func mapButton(_ sender: Any) {
    }
    @IBAction func profileButton(_ sender: Any) {
    }
    @IBAction func statButton(_ sender: Any) {
    }
    @IBAction func systemButton(_ sender: Any) {
    }
    let URL_USER_FBREGISTER = "http://82.146.61.227:3000/addNewPerson";
    let URL_USER_LOGIN = "http://82.146.61.227:3000/login";
    
    var usage:String = ""
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0/255, green: 179/255, blue: 159/255, alpha: 1.0)
        
    self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        
        if (FBflag == true){
            let aletController = UIAlertController(title: "Внимание!", message: "Введите ваш возраст", preferredStyle: UIAlertControllerStyle.alert);
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){ (action) in
                let text = aletController.textFields?.first?.text
                self.usage = text!
                print(text ?? "nil text")
                let parameters: Parameters=[
                    "username":uslogname,
                    "password":usid,
                    "age":self.usage,
                    "sex":usgen,
                    "direction_of_work":"none",
                    ]
                Alamofire.request(self.URL_USER_FBREGISTER, method: .post, parameters: parameters).responseString
                    {
                        responseString in
                        //printing response
                        print(responseString)
                }
            }
            aletController.addTextField(configurationHandler: nil)
            aletController.addAction(action)
            self.present(aletController, animated: true, completion: nil)
            
    }
        
        
        if (ENTERflag == false && (FBflag == true || FBflag == false) && REGflag == false){
        let param: Parameters=[
            "username":uslogname,
            "password":usid,
            ]
            USID = uslogname
        Alamofire.request(self.URL_USER_LOGIN, method: .post, parameters: param).responseString
            {
                response in
                //printing response
                print(response)
        }
        }
        if (USID == "admin"){
            let URL_GET_USERS = "http://82.146.61.227:3000/users"
            // запрос юзеров
            Alamofire.request(URL_GET_USERS, method: .get, parameters: [:]).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    values = response.result.value as! [AnyObject]
                    print(values)
            }
        }

}
}
