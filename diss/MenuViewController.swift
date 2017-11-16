import UIKit
import Alamofire
import FBSDKLoginKit
import SwiftyJSON

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
    let URL_USER_FBREGISTER = "http://ksssq.online/v1/register.php";
    var usage:String = ""
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0/255, green: 179/255, blue: 159/255, alpha: 1.0)
        
    self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        let ranID = uslogname + String(arc4random_uniform(100000) + 1)
        USID = ranID
        
        if (FBflag == true){
            let aletController = UIAlertController(title: "Внимание!", message: "Введите ваш возраст", preferredStyle: UIAlertControllerStyle.alert);
            let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){ (action) in
                let text = aletController.textFields?.first?.text
                self.usage = text!
                print(text ?? "nil text")
                
                let parameters: Parameters=[
                    "UserID":ranID,
                    "Login":uslogname,
                    "Password":usid,
                    "Age":self.usage,
                    "Sex":usgen,
                    ]
                
                Alamofire.request(self.URL_USER_FBREGISTER, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        //printing response
                        print(response)
                }
            }
            
            aletController.addTextField(configurationHandler: nil)
            aletController.addAction(action)
            self.present(aletController, animated: true, completion: nil)
    }

}
}
