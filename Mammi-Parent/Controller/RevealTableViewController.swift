//
//  RevealTableViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/13/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RevealTableViewController: UITableViewController  {
    
    var ChildrenArray = [Child]()
    var testChildrenArray =  [[String:AnyObject]]()
    var SelectedChildHadanaID = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
     GetChildrenWithAlamoFire()
    }
    
    
 
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.ChildrenArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyChildrenCell", for: indexPath) as? MyChildrenTableViewCell
        let CurrentChild = self.ChildrenArray[indexPath.row]
        cell?.configurationTheCell(ChildName: CurrentChild.name , CHildPhoto: CurrentChild.img, ChildClass: CurrentChild.childClass , ChildHadana: CurrentChild.hadanaName)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let SelectedChild = ChildrenArray[indexPath.row]
           SelectedChildHadanaID = SelectedChild.hadanaID
        let prefs = UserDefaults.standard
         prefs.removeObject(forKey: "CurrentHadana")
       // keyValue = prefs.string(forKey: "CurrentHadana")
        let CurrHadanaID = SelectedChildHadanaID
       //  prefs.set(CurrHadanaID, forKey: "CurrentHadana")
        UserDefaults.standard.set(CurrHadanaID, forKey: "CurrentHadana")
        let HomeVC = HomeViewController()
        HomeVC.CheckGalleryWithAlamoFire()
    }
    
    func DawnloadImage(url : String) -> UIImage   {
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        return UIImage(data: data!)!
    }
    
    
    
    func GetChildrenWithAlamoFire(){
        
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(user.self, from: _CurrentUser!)
        let CurrentUserToken = CurrentUser?._Token
        let CurrentUSerID : Int16 = (CurrentUser?._Id)!
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
      
        let url = "https://mymummy.herokuapp.com/api/v1/parents/\(CurrentUSerID)/childs"
      
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]

        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.testChildrenArray = resData as! [[String:AnyObject]]
                  
                   // print("TheRESPONSE\(resData)")
                    
                  for NextChild in self.testChildrenArray {
                    
                   var NextChildHadana =  NextChild["hadana"] as? Dictionary<String, AnyObject>
                   var NextChildClass =  NextChild["class"] as? Dictionary<String, AnyObject>
                    let RecivedChild = Child.init(
                          _name: NextChild["name"] as! String
                        , _img: self.DawnloadImage(url: NextChild["img"] as! String)
                        , _hadanaID:  NextChildHadana!["id"] as! Int
                        , _hadanaName: NextChildHadana!["name"] as! String
                        , _childClass: NextChildClass!["name"] as! String
                    )
                        self.ChildrenArray.append(RecivedChild)
                        }
                    self.tableView.reloadData()
                }
            }
        }
    }
}


