//
//  LoginViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/9/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var TxtFieldUsername: UITextField!
    @IBOutlet weak var TxtFieldPassWord: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TxtFieldMammi.font = UIFont(name: "RemachineScript_Personal_Use", size: 75 )
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LoginButtonWasPressed(_ sender: Any) {
        
        let UserPhone = TxtFieldUsername.text
        let PassWord = TxtFieldPassWord.text
        
        GoLoginWithAlamoFire(phone: UserPhone!, pass: PassWord!)
        
    }
    
    func GoLoginWithAlamoFire(phone : String , pass : String)
    {
        
        let parameters: [String: String] = [
            "phone" : phone,
            "password" : pass
        ]
        
        let header : [String: String] = [
            "Content-Type" : "application/json"
        ]
        Alamofire.request("https://mymummy.herokuapp.com/api/v1/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                   // print(response.result.value)
                    let json = JSON(data)
                    let name = json["user"]["name"]
                    let phone = json["user"]["phone"]
                    let typeofuser = json["user"]["type"]
                     let haveprivatechat = json["user"]["havePrivateChat"]
                     let haveparentchat = json["user"]["haveParentChat"]
                     let haveclasschat = json["user"]["haveClassChat"]
                     let havetutorial = json["user"]["haveTutorial"]
                     let creationdate = json["user"]["creationDate"]
                     let id = json["user"]["id"]
                    let ImgURL = json["user"]["img"]
                    let Token = json["token"]
                    
                    let NewUser = user(_TypeOfUser: typeofuser.stringValue, _ImgURL: ImgURL.stringValue, _HavePrivateChat: haveprivatechat.boolValue, _HaveParentChat: haveparentchat.boolValue, _HaveClassChat: haveclasschat.boolValue, _Name: name.stringValue, _Phone: phone.stringValue, _HaveTutorial: havetutorial.boolValue, _CreationDate: creationdate.stringValue, _Id: id.int16!, _Token: Token.stringValue)
                    
                    if let encoded = try? JSONEncoder().encode(NewUser) {
                        UserDefaults.standard.set(encoded, forKey: "kUser")
                    }
                    
                    self.performSegue(withIdentifier: "GoHome", sender: self)

                }
                break
                
            case .failure(_):
                print(response.result.error!)
                break
                
            }
        }
    }
    
  
    
  

}
