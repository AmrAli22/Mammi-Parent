//
//  ReportViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/28/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReportViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    ///kidinfoviewOutlets
    @IBOutlet weak var ImgViewKidPic: UIImageView!
    @IBOutlet weak var TxtFieldKidName: UITextField!
    @IBOutlet weak var ImgViewAttendCheck: UIImageView!
     ///kidinfoviewOutletsEnd
    
    //////RatingStars
    @IBOutlet weak var ImgViewFirstStar: UIImageView!
    @IBOutlet weak var ImgViewSecStar: UIImageView!
    @IBOutlet weak var ImgViewThirdStar: UIImageView!
    @IBOutlet weak var ImgViewFourStar: UIImageView!
    @IBOutlet weak var ImgviewFiveStar: UIImageView!
    //////RatingsStarsEnd
    
    //////FoodOutlets
    @IBOutlet weak var ImgViewMuchFood: UIImageView!
    @IBOutlet weak var ImgViewNormalFood: UIImageView!
    @IBOutlet weak var ImgViewLittleFood: UIImageView!
    //////FoodOutletsEnd
    
    /////WaterOutlets
    @IBOutlet weak var ImgviewMuchWater: UIImageView!
    @IBOutlet weak var ImgViewNormalWater: UIImageView!
    @IBOutlet weak var ImgViewLittleWater: UIImageView!
    /////WaterOutletsEnd
    
    ////BathroomOutlets
    @IBOutlet weak var ImgviewDiaber: UIImageView!
    @IBOutlet weak var ImgViewWaterPee: UIImageView!
    @IBOutlet weak var TxtFieldDiberCount: UITextField!
    @IBOutlet weak var TxtFieldWaterPeeCount: UITextField!
    ////BathroomOutletsEnd

    ////TableView
    @IBOutlet weak var tableView: UITableView!
    ////TableViewEnd
    
    ////Overview
    @IBOutlet weak var TxtViewOverView: UITextView!
    ////OverviewEnd
    
    ////////////////////////OutletsEnd
    
    ////////Var
    var ChoosenDateFromPicker = String()
    var testReportArr = [[String : AnyObject]]()
    var testSubjectsArr = [String : AnyObject]()
    var SubjectsArr = [[String : String]]()
    
    ///////VarEnd
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        ImgViewKidPic.makeRoundedImages()
        ImgViewAttendCheck.makeRoundedImages()
        
       self.DawnloadReportWithAlamofire()
        
    }
    
    @IBAction func BackBtnAct(_ sender: Any) {
        dismiss(animated: true)
    }
    ///////DatePacker
   
    @IBAction func BtnActDatePacker(_ sender: Any) {
        
        if self.childViewControllers.count == 0 {
        
        let PopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpView") as? PopUpPickerViewController
        self.addChildViewController(PopUpVC!)
        PopUpVC?.view.frame = self.view.frame
        self.view.addSubview((PopUpVC?.view)!)
        PopUpVC?.didMove(toParentViewController: self)
        }else{
            if self.childViewControllers.count > 0{
                let viewControllers:[UIViewController] = self.childViewControllers
                for viewContoller in viewControllers{
                    viewContoller.willMove(toParentViewController: nil)
                    viewContoller.view.removeFromSuperview()
                    viewContoller.removeFromParentViewController()
                }
            }
            }
        }
       ////////EndOfDatePacker
    
    
    /////TableViewFunctions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportSubjectCell", for: indexPath) as? ReportSubjectTableViewCell
        for (key, value) in testSubjectsArr {
            cell?.ConfigurationCell(Subject: key , Grade: value as! String)
        }
        return cell!
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testSubjectsArr.count
    }
    
    //////////EndOfTableViewFunctions
    @IBAction func ActBtnBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    /////////FetchingData
    
        ////////////DawnloadImages
    func DawnloadImage(url : String) -> UIImage   {
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!)!
    }
        ////////////EndDawnloadImages
    
            ///////AlamoFire
    
    func DawnloadReportWithAlamofire(){
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(user.self, from: _CurrentUser!)
        let CurrentUserToken = CurrentUser?._Token
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
        let firstUrl = "https://mymummy.herokuapp.com/api/v1/childs/5200/reports?"
        
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type": "application/json"
        ]
        
        let Parameters : [String: String] = [
                    "date" : "04/11/2018"
        ]

        var FinalURL = String()
        do {
            let url = URL(string: firstUrl)!
            let urlRequest = URLRequest(url: url)
          
            let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: Parameters)
            
           // let url = NSURL(string: urlstring)
           FinalURL = "\(encodedURLRequest)"
            
        } catch is Error {
            print("EndPointerror")
        }
        
        Alamofire.request(FinalURL , method: .get , encoding: JSONEncoding.default, headers: header)
            .responseString {
            (response) in
            
                print ( response.response?.statusCode as Any )
                
                
                
            if((response.result.value) != nil) {
            
                do{
                    let dataFromString = response.result.value?.data(using: .utf8, allowLossyConversion: false)

                    let swiftyJsonVar = try JSON(data: dataFromString!)
                    
                    //// BathroomHandler
                   
                    if case self.TxtFieldDiberCount.text! = String(describing: swiftyJsonVar["diaber"].int){
                        
                    }
                    if case self.TxtFieldWaterPeeCount.text! = String(describing: swiftyJsonVar["bathroomWater"].int){
                        
                    }
                    //// BathroomHandlerEnd
                    
                    ////// ActiveHandler
                    
                    switch swiftyJsonVar["active"].int {
                    case 1? :
                        
                        self.ImgViewFirstStar.alpha = 1.0
                        self.ImgViewSecStar.alpha = 0.2
                        self.ImgViewThirdStar.alpha = 0.2
                        self.ImgViewFourStar.alpha = 0.2
                        self.ImgviewFiveStar.alpha = 0.2
                        
                    case 2? :
                        
                        self.ImgViewFirstStar.alpha = 1.0
                        self.ImgViewSecStar.alpha = 1.0
                        self.ImgViewThirdStar.alpha = 0.2
                        self.ImgViewFourStar.alpha = 0.2
                        self.ImgviewFiveStar.alpha = 0.2
                        
                        
                    case 3? :
                        
                        self.ImgViewFirstStar.alpha = 1.0
                        self.ImgViewSecStar.alpha = 1.0
                        self.ImgViewThirdStar.alpha = 1.0
                        self.ImgViewFourStar.alpha = 0.2
                        self.ImgviewFiveStar.alpha = 0.2
                        
                    case 4? :
                        
                        self.ImgViewFirstStar.alpha = 1.0
                        self.ImgViewSecStar.alpha = 1.0
                        self.ImgViewThirdStar.alpha = 1.0
                        self.ImgViewFourStar.alpha = 1.0
                        self.ImgviewFiveStar.alpha = 0.2
                        
                        
                    case 5? :
                        
                        self.ImgViewFirstStar.alpha = 1.0
                        self.ImgViewSecStar.alpha = 1.0
                        self.ImgViewThirdStar.alpha = 1.0
                        self.ImgViewFourStar.alpha = 1.0
                        self.ImgviewFiveStar.alpha = 1.0
                        
                    default:
                        
                        self.ImgViewFirstStar.alpha = 0.2
                        self.ImgViewSecStar.alpha = 0.2
                        self.ImgViewThirdStar.alpha = 0.2
                        self.ImgViewFourStar.alpha = 0.2
                        self.ImgviewFiveStar.alpha = 0.2
                        
                    }
                    ////// ActiveHandlerEnd
                    
                    //////"food"Handler ['Much', 'Normal', 'Little']
                    
                    switch swiftyJsonVar["food"].string {
                    case  "Normal"? :
                        self.ImgViewNormalFood.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                    case  "Much"? :
                        self.ImgViewMuchFood.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                    case  "Little"? :
                        self.ImgViewLittleFood.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                    default:
                        self.ImgViewLittleFood.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        self.ImgViewMuchFood.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        self.ImgViewNormalFood.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    }
                    
                    //////"food"HandlerENd
                    
                    ////////WaterHandler
                    
                    switch swiftyJsonVar["water"].string {
                    case  "Normal"? :
                        self.ImgViewNormalWater.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                    case  "Much"? :
                        self.ImgviewMuchWater.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                    case  "Little"? :
                        self.ImgViewLittleWater.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                    default:
                        self.ImgViewLittleWater.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        self.ImgviewMuchWater.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                        self.ImgViewNormalWater.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    }
                    
                    ////////WaterHandlerEnd
                    
                    ///////NotesHandler
                    self.TxtViewOverView.text = swiftyJsonVar["note"].string
                    ///////NotesHandlerEND
                    
                    //////NameAndPhotoHandler
                    let decoder = JSONDecoder()
                    let _CurrentChild = UserDefaults.standard.data(forKey: "CurrChild")
                    let CurrentChild = try? decoder.decode(Child.self, from: _CurrentChild!)
                    self.TxtFieldKidName.text = CurrentChild?.name
                    self.ImgViewKidPic.image = self.DawnloadImage(url: (CurrentChild?.imgURL)!)
                    //////NameAndPhotoHandler
                    
                    ////////SubjectsHandler///////
                    
                   if let Subjects = swiftyJsonVar["subject"].arrayObject {
                    
                    // print ("Subjects= \(Subjects)")
                    
                    self.testReportArr = Subjects as! [[String:AnyObject]]
                
                    
                        for NextSubjet in self.testReportArr {
                            
                          //  print ("NextSubject= \(NextSubjet)")
                            let NextGrade = NextSubjet["grade"] as? String
                            let NextSubjectName =  NextSubjet["subject"]!["name"] as? String
                            
                        //    print ("AppendedSubject = \([NextSubjectName! : NextGrade!])")
                            
                            self.SubjectsArr.append([NextSubjectName! : NextGrade!])
                            
                        }
                    
                    
                    
                    }
                   
                    ////////SubjectsHandlerEnd///////
                    
                        } catch {
                      print (error)
                    }
                  }
               }
        
    } ///////AlamoFireEnd
//////////EndFetchingData
}///end Of Class
