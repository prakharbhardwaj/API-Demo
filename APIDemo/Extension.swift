//
//  Extension.swift
//  APIDemo
//
//  Created by Prakhar Prakash Bhardwaj on 26/03/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    var hexString:String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}

extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var htmlAttributed: (NSAttributedString?, NSDictionary?) {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return (nil, nil)
            }
            
            var dict:NSDictionary?
            dict = NSMutableDictionary()
            
            return try (NSAttributedString(data: data,
                                           options: [.documentType: NSAttributedString.DocumentType.html,
                                                     .characterEncoding: String.Encoding.utf8.rawValue],
                                           documentAttributes: &dict), dict)
        } catch {
            print("error: ", error)
            return (nil, nil)
        }
    }
    
    func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(font.pointSize)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(font.familyName), Helvetica !important;" +
            "}</style> \(self)"

            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }

            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    func htmlAttributed(family: String?, size: CGFloat, style: String?, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" + "font-weight:  \(style ?? "normal") !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
}

extension UIView{
    func customActivityIndicator(view: UIView, widthView: CGFloat?,backgroundColor: UIColor?) -> UIView{
        
        //Config UIView
//        self.backgroundColor = .clear //Background color of your view which you want to set
//       self.backgroundColor = UIColor(white: 1, alpha: 0.3)
       self.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
       self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
       self.layer.shadowOpacity = 1
       self.layer.shadowRadius = 10
       self.clipsToBounds = true
       self.layer.masksToBounds = false
        
        var selfWidth = view.frame.width
        if widthView != nil{
            selfWidth = widthView ?? selfWidth
        }
        
        let selfHeigh = view.frame.height
        let loopImages = UIImageView()
        let imageListArray = [#imageLiteral(resourceName: "Image-1") , #imageLiteral(resourceName: "Image"), #imageLiteral(resourceName: "EmptyStar")] // Put your desired array of images in a specific order the way you want to display animation.
        
        loopImages.animationImages = imageListArray
        loopImages.animationDuration = TimeInterval(0.8)
        loopImages.startAnimating()
        
        let imageFrameX = (selfWidth / 2) - 30
        let imageFrameY = (selfHeigh / 2) - 60
        var imageWidth = CGFloat(80)
        var imageHeight = CGFloat(80)
        
        if widthView != nil{
            imageWidth = widthView ?? imageWidth
            imageHeight = widthView ?? imageHeight
        }
        
        //ConfigureLabel
//        let label = UILabel()
//        label.textAlignment = .center
//        label.textColor = .gray
//        label.font = UIFont.boldSystemFont(ofSize: 17) // Your Desired UIFont Style and Size
//        label.numberOfLines = 0
//        label.text = message ?? ""
//        label.textColor = textColor ?? UIColor.clear
//
//        //Config frame of label
//        let labelFrameX = (selfWidth / 2) - 100
//        let labelFrameY = (selfHeigh / 2) - 10
//        let labelWidth = CGFloat(200)
//        let labelHeight = CGFloat(70)
        
        // Define UIView frame
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height)
        
        
        //ImageFrame
        loopImages.frame = CGRect(x: imageFrameX, y: imageFrameY, width: imageWidth, height: imageHeight)
        
        //LabelFrame
//        label.frame = CGRect(x: labelFrameX, y: labelFrameY, width: labelWidth, height: labelHeight)
        
        //add loading and label to customView
        self.addSubview(loopImages)
//        self.addSubview(label)
        return self
    }
}

