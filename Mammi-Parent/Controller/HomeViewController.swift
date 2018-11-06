//
//  FirstViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/8/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController , UIScrollViewDelegate {

    @IBOutlet weak var BtnClasses: UIButton!
    @IBOutlet weak var BtnGallery: UIButton?
    @IBOutlet weak var BtnEvent: UIButton!
    @IBOutlet weak var BtnOurSystem: UIButton!
    @IBOutlet weak var BtnAbout: UIButton!
    @IBOutlet weak var BtnNews: UIButton!
    @IBOutlet weak var BtnMenu: UIButton!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var MainScrollView: UIScrollView!
    
    
    let bannerArray : [UIImage] = [#imageLiteral(resourceName: "hdana3"),#imageLiteral(resourceName: "hdana2"),#imageLiteral(resourceName: "hdana1")]
    var offSet: CGFloat = 0
    var TestGalleryIDAlbums = [[String:AnyObject]]()
    var GalleryIDAlbums = Int()
   
   

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let revVC = RevealTableViewController()
        revVC.GetChildrenWithAlamoFire{ (complete) in
            if complete {
                self.CheckGalleryWithAlamoFire()
            }
        }
        RunBanner()
        ChildrenButtonActivation()
     //
        
        /// ///////RoundedButton
        
        self.BtnGallery?.makeRoundedShapes()
        self.BtnOurSystem.makeRoundedShapes()
        self.BtnClasses.makeRoundedShapes()
        self.BtnEvent.makeRoundedShapes()
        self.BtnAbout.makeRoundedShapes()
        self.BtnNews.makeRoundedShapes()
            
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if self.GalleryIDAlbums == 0 {
            self.BtnGallery?.isHidden = true
        } else {
            self.BtnGallery?.isHidden = false
        }
    }
    
    
    func ChildrenButtonActivation(){
        
        if self.revealViewController() != nil {
            
            BtnMenu.target(forAction: #selector(SWRevealViewController.revealToggle(_:)), withSender: SWRevealViewController())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
     
    }
    
    func RunBanner(){
        
        
        self.offSet = 0
        _ = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        
        imagePageControl.numberOfPages = bannerArray.count
        
        MainScrollView.isPagingEnabled = true
        MainScrollView.contentSize.height = self.view.bounds.size.height
        MainScrollView.contentSize.width = self.view.bounds.width * CGFloat(bannerArray.count)
        MainScrollView.showsHorizontalScrollIndicator = true
        MainScrollView.delegate = self
        
        for (index, image) in bannerArray.enumerated() {
            let image = image
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleToFill
            imageView.frame.size.width = self.view.bounds.size.width
            imageView.frame.size.height = self.MainScrollView.bounds.size.height
            imageView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            MainScrollView.addSubview(imageView)
        
        
        }
    }
        
        @objc func autoScroll() {
            let totalPossibleOffset = CGFloat(bannerArray.count - 1) * self.view.bounds.size.width
            if offSet == totalPossibleOffset {
                offSet = 0 // come back to the first image after the last image
            }
            else {
                offSet += self.view.bounds.size.width
            }
            DispatchQueue.main.async() {
                UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                    self.MainScrollView.contentOffset.x = CGFloat(self.offSet)
                }, completion: nil)
            }
        }
    
    
    func CheckGalleryWithAlamoFire(){
        
        let decoder = JSONDecoder()
        let _CurrentChild = UserDefaults.standard.data(forKey: "CurrChild")
        let CurrentChild = try? decoder.decode(Child.self, from: _CurrentChild!)
       
        /*
         f let newValue = someValue {
         print(newValue)
         }
         */
        
        let CurrentChildHadanaID = CurrentChild!.hadanaID
            //
        
            let GetGalleryURL = "https://mymummy.herokuapp.com/api/v1/hadana/\(CurrentChildHadanaID)/galleries"
            
        
       
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(user.self, from: _CurrentUser!)
        let CurrentUserToken = CurrentUser?._Token
        //let CurrentUSerID : Int16 = (CurrentUser?._Id)!
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!

        let header : [String: String] = [
            "Authorization" : bearer ,
          //  "Content-Type" : "application/json"
        ]
        
        Alamofire.request(GetGalleryURL, method: .get,encoding: JSONEncoding.default , headers: header).responseJSON { (responseData) -> Void in
            print (responseData)
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
              //  print(swiftyJsonVar)
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.TestGalleryIDAlbums = resData as! [[String:AnyObject]]
                    self.GalleryIDAlbums = (self.TestGalleryIDAlbums[0]["id"] as! Int)
                
                   // print("GalleryIDSArraay\(self.GalleryIDAlbums)")
                    if self.GalleryIDAlbums == 0 {
                        self.BtnGallery?.isHidden = true
                    } else {
                        self.BtnGallery?.isHidden = false
                }
            }
        }
    }
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoGallery" {
                let controller = segue.destination as! AlbumsCollectionViewController
                controller.GalleryId = GalleryIDAlbums
            
        }
    }
    
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

