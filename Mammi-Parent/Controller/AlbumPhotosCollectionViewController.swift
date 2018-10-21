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

private let reuseIdentifier = "Cell"

class AlbumPhotosCollectionViewController: UICollectionViewController {
    
    var CurrentAlbumID = Int()
    var AlbumPhotos = [UIImage]()
    var testimgesArray = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return AlbumPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumPhotoCollectionViewCell
    
        cell?.ImageViewAlbumPhoto.image = AlbumPhotos[indexPath.row]
    
        return cell !
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
                        self.AlbumPhotos.append( self.DawnloadImage(url:
                            (NextImages["imgs"] as? String)!))
         
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            }
        }
    }
}


