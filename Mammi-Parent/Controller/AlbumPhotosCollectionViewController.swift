//
//  AlbumPhotosCollectionViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/21/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AlbumPhotosCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "AlbumPhotosCell"
    
    var CurrentAlbumID = Int()
    var AlbumPhotos = [UIImage]()
    var testimgesArray = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.DawnloadimagesWithAlamofire()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "RemachineScriptPersonalUse", size: 28 )!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.strokeColor : #colorLiteral(red: 1, green: 0.4412012994, blue: 0.4056814313, alpha: 1) ]
        
        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DawnloadImage(url : String) -> UIImage   {
        
        let url = URL(string: url)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        return UIImage(data: data!)!
    }
    
    func DawnloadimagesWithAlamofire(){
        
        
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(user.self, from: _CurrentUser!)
        let CurrentUserToken = CurrentUser?._Token
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
        let url = "https://mymummy.herokuapp.com/api/v1/folders/2/images"
        
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.testimgesArray = resData as! [[String:AnyObject]]
           
                    for NextImages in self.testimgesArray {
                        self.AlbumPhotos.append(
                            self.DawnloadImage(url:
                                (NextImages["imgs"] as? String)!) )
                        print(self.AlbumPhotos)
                    }
                    self.collectionView?.reloadData()
                }
            }
        }
    }

    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let LeftAndRightPadding : CGFloat = 2.0
        let FullWidth = collectionView.frame.width
        var ItemSize = CGSize(width: (FullWidth - LeftAndRightPadding)  , height: (FullWidth - LeftAndRightPadding) )
        if Double(FullWidth) <= 400.0{
            ItemSize =  CGSize(width: (FullWidth - LeftAndRightPadding)/2.0 , height: (FullWidth - LeftAndRightPadding)/2.0 )
            
        }else if Double(FullWidth) > 400.0 {
            ItemSize =  CGSize(width: (FullWidth - LeftAndRightPadding)/3.0 , height: (FullWidth - LeftAndRightPadding)/3.0 )
        }
        return ItemSize
    }
    
    
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
      
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return AlbumPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumPhotoCollectionViewCell
        
        if self.AlbumPhotos.isEmpty{
            self.collectionView?.reloadData()
        } else {
            self.collectionView?.layoutIfNeeded()
            cell!.ImageViewAlbumPhoto.image = AlbumPhotos[indexPath.row]
            return cell!
        }
        return cell! 
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let FullImageVC = FullImageViewController()
        FullImageVC.SenderIndex = indexPath
        FullImageVC.ImageArray = self.AlbumPhotos
        self.navigationController?.pushViewController(FullImageVC, animated: true)
    }
    
}


