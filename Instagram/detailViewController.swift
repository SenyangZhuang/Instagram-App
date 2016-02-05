//
//  DetailViewController.swift
//  Instagram
//
//  Created by Senyang Zhuang on 2/3/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var data: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let posterPath = data["images"]!["low_resolution"]!!["url"] as? String {
            //            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterPath)
            imageView.setImageWithURL(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            imageView.image = nil
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func onTap(sender: AnyObject) {
        print("QQQQ")
        performSegueWithIdentifier("fullScreenSegue", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      let fullScreenViewController = segue.destinationViewController as! FullScreenPhotoViewController
            fullScreenViewController.data = data
        
        
    }
    

  
}
