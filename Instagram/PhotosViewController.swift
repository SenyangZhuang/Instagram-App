//
//  ViewController.swift
//  Instagram
//
//  Created by Senyang Zhuang on 1/27/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var datas: [NSDictionary]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        //print("WWWWWW")
        super.viewDidLoad()
        tableView.rowHeight = 250;
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)")
                            self.datas = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
     return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        //print(indexPath.row)
        let data = datas![indexPath.section]
        let full_name = data["user"]!["username"] as! String
        if let posterPath = data["images"]!["low_resolution"]!!["url"] as? String {
//            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterPath)
            cell.contentImage.setImageWithURL(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            cell.contentImage.image = nil
        }


//        cell.overviewLabel.text = overview
        
        //        cell.posterView.setImageWithURL(imageUrl!)
        
        
        //print("row \(indexPath.row)")
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        if let datas = datas{
            return datas.count
        }else{
            return 0
        }
    }
    

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        //print(datas)
        
        let data = datas![section]
        if let profileImagePath = data["user"]!["profile_picture"] as? String{
            let profileImageUrl = NSURL(string: profileImagePath)
            print(profileImagePath)
            profileView.setImageWithURL(profileImageUrl!)
        }else{
            profileView.image = nil
        }
        
        headerView.addSubview(profileView)
        
        // Add a UILabel for the username here
        let usernameLabel = UILabel(frame: CGRect(x: 50, y: -25, width: 200, height: 100))
            usernameLabel.text = data["user"]!["full_name"] as? String
        
        headerView.addSubview(usernameLabel)
        return headerView
    
    
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return  50
    }


}

