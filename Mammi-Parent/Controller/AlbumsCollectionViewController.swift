//
//  AlbumsCollectionViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/21/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class AlbumsCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifier = "AlbumCell"
    var complitionHandler: ((Bool)->Void)?
    var GalleryId = Int()
    var testFoldersArray = [[String : AnyObject]]()
    var FoldersArray = [Folder?]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        DispatchQueue.main.async {
           self.getGalleryFoldersWithAlamofire()
        }
      
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "RemachineScriptPersonalUse", size: 28 )!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.strokeColor : #colorLiteral(red: 1, green: 0.4412012994, blue: 0.4056814313, alpha: 1) ]

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView?.reloadData()
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
    
    func getGalleryFoldersWithAlamofire() {
        
        let decoder = JSONDecoder()
        let _CurrentUser = UserDefaults.standard.data(forKey: "kUser")
        let CurrentUser = try? decoder.decode(user.self, from: _CurrentUser!)
        let CurrentUserToken = CurrentUser?._Token
        
        var  bearer = "Bearer "
        bearer += CurrentUserToken!
        
        let url = "https://mymummy.herokuapp.com/api/v1/galleries/1/folders"
       
        let header : [String: String] = [
            "Authorization" : bearer ,
            "Content-Type" : "application/json"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["data"].arrayObject {
                    self.testFoldersArray = resData as! [[String:AnyObject]]
                    
                    for NextFolder in self.testFoldersArray {
                        let ReceivedFolder = Folder.init(_name: NextFolder["name"] as! String
                            , _img: self.DawnloadImage(url: NextFolder["img"] as! String)
                            , _id: NextFolder["id"] as! Int
                              )
                        
                        self.FoldersArray.append(ReceivedFolder)
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            }
        }
      
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return FoldersArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumCollectionViewCell
        if self.FoldersArray.isEmpty {
            self.collectionView?.reloadData()
        }else{
            cell?.GonfigureCell(Albumtitle: (FoldersArray[indexPath.row]?.name)! ,
                                AlbumImage: (FoldersArray[indexPath.row]?.img)!  )
        
            return cell!
        }
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let AlbumPhotos = AlbumPhotosCollectionViewController()
        AlbumPhotos.CurrentAlbumID = (FoldersArray[indexPath.row]?.id)!
        self.navigationController?.pushViewController(AlbumPhotos, animated: true)
    }
}
