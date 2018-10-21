//
//  EventsTableViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/16/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EventsTableViewController: UITableViewController {
    
   
    @IBAction func BtnActBack(_ sender: Any) {
        dismiss(animated: true) 
    }
    var EventArray = [Event]()
    var TestEventArray =  [[String:AnyObject]]()
    var CurrentChildHadanaID = Int()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    CurrentChildHadanaID = UserDefaults.standard.integer(forKey:"CurrentHadana")
    print(CurrentChildHadanaID)
    DawnloadEventsWithAlamoFire()
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
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
        return EventArray.count
    }
    
 
     func dateFromISOString(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
       let DateFormat = dateFormatter.date(from: string)
        let myString = dateFormatter.string(from: DateFormat!)
        return myString
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoEvent" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let SelectedEvent = EventArray[indexPath.row]
                let controller = segue.destination as! TheEventViewController
                controller.CurrentEvent = SelectedEvent
            }
        }
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? TheEventTableViewCell
        let CurrentEvent = self.EventArray[indexPath.row]
        cell?.ConfigrationTheCell(Date: CurrentEvent.Date,
                                  Name: CurrentEvent.name,
                                  Desc: CurrentEvent.Desc,
                                  Cost: CurrentEvent.Cost,
                                  Image: CurrentEvent.img)

        return cell!
    }
    
    func DawnloadImage(url : String) -> UIImage   {
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        return UIImage(data: data!)!
    }
    
    @objc func notificationReceived(_ notification: Notification) {
        guard let text = notification.userInfo?["text"] as? Int else { return }
       CurrentChildHadanaID = text
    }
    
 
    func DawnloadEventsWithAlamoFire(){
       
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(user.self, from: _CurrentUser!)
        let CurrentUserToken = CurrentUser?._Token
        //let CurrentUSerID : Int16 = (CurrentUser?._Id)!
        
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
        let url = "https://mymummy.herokuapp.com/api/v1/hadana/\(CurrentChildHadanaID)/events"
         print ("THEURL\(url)")
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.TestEventArray = resData as! [[String:AnyObject]]
                    print (self.TestEventArray)
                    for NextEvent in self.TestEventArray {
                        
                        let ReceivedEvent = Event.init(
                            _name: NextEvent["name"] as! String
                          , _img:  self.DawnloadImage(url: NextEvent["img"] as! String)
                          , _Desc: NextEvent["description"] as! String
                        , _Date: self.dateFromISOString(string: NextEvent["dateOfEvent"] as! String ) 
                          , _Cost: NextEvent["price"] as! String
                            , _Attends : NextEvent["numberofParticipant"] as! Int
                        )
                        
                        self.EventArray.append(ReceivedEvent)
                        
                        print ("EventArrayInFunction\(self.EventArray)")
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }//funcDawnlaodEnd
}//Classend
