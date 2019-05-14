//
//  ImageViewClass.swift
//  APIDemo
//
//  Created by Prakhar Prakash Bhardwaj on 10/05/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

var bgColor = ""

public class ImageView: UIImageView {
    
    @IBOutlet weak var textsfield: UITextField!
    var imageUrl = ""
    
    override public func awakeFromNib() {
        super.awakeFromNib()
//        self.sd_setImage(with: URL(string: "https://www.evueme.com/MVP-HTML/api/logo/br_naukri_logo.png"))
    }
    @IBAction func editDidEnd(_ sender: UITextField) {
        DispatchQueue.main.async {
            self.text2Image()
        }
    }

    func text2Image(){

            let urlString = "https://www.evueme.com/MVP-HTML/api/branding"
            let urlPath = URL(string: urlString)!
            let urlRequest = URLRequest(url: urlPath)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                        if let response = response {
                            print(response)
                        }
                        print("Response \(jsonResult)")
                        let brandArray = jsonResult["Branding"] as! NSArray
                        DispatchQueue.main.async {
                        for items in brandArray .objects(at: [0]) {
                            let obj = items as! NSDictionary
                            let objElements = (obj["\(self.textsfield.text!)"] as? NSArray ?? [""])
                            for objElem in objElements .objects(at: [0]) {
                                let objElemDict = objElem as! NSDictionary
                                print(objElemDict["color_header"] as! String)
                                print(objElemDict["color_topbar"] as! String)
                                print(objElemDict["brand_icon"] as! String)
                                self.sd_setImage(with: URL(string: "\((objElemDict["brand_icon"] as! String))"))
                                bgColor = (objElemDict["color_topbar"] as! String)
                            }
                        }
                        }
                    }
                }
                catch let err as NSError {
                    print(err.debugDescription)
                }
            }
            task.resume()
    }
}

