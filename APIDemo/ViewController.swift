//
//  ViewController.swift
//  APIDemo
//
//  Created by apple on 02/03/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import CoreTelephony

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var API:UITextField!
    @IBOutlet weak var session:UITextField!
    @IBOutlet weak var tokens:UITextField!
    
    var questionArray = [String]()
    var pollyArray = [String]()
    var initalTime = [String]()
    var mainTime = [String]()
    var inti = 0
    var questionCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session.text = ""
//        getApi()
//        let seconds = "01:30:10".numberOfSeconds()
//        print("%@ seconds", seconds)
//        self.generateActualSession()
        //        DispatchQueue.main.async {
        ////            self.callAPIGetMethod()
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Get Method
    func callAPIGetMethod() {
        let urlString = "https://www.evueme.com/MVP-HTML/api/createCandidatefeedback.php?candidate_id=ODs"
        let urlPath = URL(string: urlString)!
        let urlRequest = URLRequest(url: urlPath)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    if let response = response {
                        print(response)
                    }
                    print("Response \(jsonResult)")
//                    let priceArray = jsonResult["prices"] as! NSDictionary
                    DispatchQueue.main.async {
//                        for _ in priceArray {
//                            let inr = priceArray["inr"] as! NSDictionary
//                            self.API.text = (inr["BTC"] as! String)
//                            self.session.text = (inr["XRP"]  as! String)
//                            self.tokens.text = (inr["TRX"] as! String)
//                        }
                    } 
                }
            }
            catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        print("@@@",questionCount)
        print("###",inti)
        if (inti < questionCount) {
            DispatchQueue.main.async {
                self.generateActualSession()
            }
        }
        else{
            button.isUserInteractionEnabled = false
            button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
    
    
    // Post Method
//        func callAPIPostMethod() {
//
//            // Put values at here
//            let jobID = "ODk"
//            let mobile = "7417460607"
//            let dob = "05-01-1997"
//
//            guard let url = URL(string: "https://www.evueme.com/MVP-HTML/api/createCandidateData.php?cn_job_id=\(jobID)&msisdn=\(mobile)&dob=\(dob)&phonecode=91") else {return}
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("text/html", forHTTPHeaderField: "Content-Type")
//            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//                do {
//                    if let jsonData = data {
//                        if let jsonDataDict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
//                            print("Data is \(jsonDataDict)")
//                        }
//                    }
//                    if let HTTPResponse = response as? HTTPURLResponse {
//                        print(HTTPResponse)
//                        let statusCode = HTTPResponse.statusCode
//                        if statusCode == 200 {
//                            print("Success")
//                        }
//                    }
//                }
//                catch let err as NSError {
//                    print(err.debugDescription)
//                }
//            }
//            task.resume()
//
//        }
    
//    func callAPIPostMethod() {
//
//        let jobID = "OTM2"
//        let mobile = "7417460607"
//        let dob = "1997-01-05"
//        let parameters = ["cn_job_id":"\(jobID)", "msisdn":"\(mobile)", "dob":"\(dob)" ]
//
//        guard let url = URL(string: "https://www.evueme.com/MVP-HTML/api/createCandidateData.php?cn_job_id=\(jobID)&msisdn=\(mobile)&dob=\(dob)&phonecode=91") else {return}
//        //        guard let url = URL(string: "https://subdomainname.evueme.com/question/Appquestionares?job_id=job_id&app_id=app_id") else {return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("text/html", forHTTPHeaderField: "Content-Type")
//        guard let httpbody = try? JSONSerialization.data(withJSONObject: parameters, options:[]) else {return}
//        request.httpBody = httpbody
//
//        let session = URLSession.shared
//        session.dataTask(with: request) {data, response, error  in
//            if let response = response {
//                print(response)
//            }
//            if let data = data{
//                do{
//                    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
//                        DispatchQueue.main.async {
//                            self.API.text = String(json["code"] as! Int)
//                            self.tokens.text = (json["message"]  as! String)
//                            if (json["otp"] != nil) {
//                                self.session.text = String(json["otp"] as! Int)}
//                            else {return}
//                            print(json)
//                        }
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//
//            }.resume()
//
//    }
    
    func feedbackApi() {
        
        let jobID = "OTM2"
        let feedBackData = ""
        let parameters = ["feedback":"\(feedBackData)"]
        
        guard let url = URL(string: "https://www.evueme.com/MVP-HTML/api/createCandidatefeedback.php?candidate_id=\(jobID)") else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("text/html", forHTTPHeaderField: "Content-Type")
        guard let httpbody = try? JSONSerialization.data(withJSONObject: parameters, options:[]) else {return}
        request.httpBody = httpbody
        
        let session = URLSession.shared
        session.dataTask(with: request) {data, response, error  in
            if let response = response {
                print(response)
            }
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    func generateActualSession() {
        let urlString = "https://demo.evueme.com/question/Appquestionares?job_id=97&app_id=977"
        let urlPath = URL(string: urlString)!
        let urlRequest = URLRequest(url: urlPath)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {
//                    guard let dataArray = jsonResult[""] as? NSArray else {return}
                    DispatchQueue.main.async {
//                        print("@@@\(dataArray[1])")
//                        let exArray = dataArray[1]
                        self.questionCount = jsonResult.count
                        print(self.questionCount)
                        for item in jsonResult .objects(at: [self.inti]) {
                            let obj = item as! NSDictionary
                            print(obj["ques_descrip"] as! String)
//                            self.API.text = (obj["ques_descrip"] as! String)
                            self.API.attributedText = (obj["ques_descrip"] as! String).htmlAttributed(family: "System", size: 20, style: "normal", color: #colorLiteral(red: 0.7254901961, green: 0.5921568627, blue: 0.3137254902, alpha: 1))
                            print(obj["ques_polly"]  as! String)
                            self.tokens.text = (obj["ques_polly"]  as! String)
                            print((obj["prep_time"] as! String).numberOfSeconds())
                            let sss = ((obj["prep_time"] as! String).numberOfSeconds())
                            self.session.text = String(sss)
                            print((obj["resp_time"] as! String).numberOfSeconds())
                            print(obj["retake"] as! Int)
                            self.inti += 1
                            
                        }; print("Q:\(self.inti)/\(self.questionCount)")
//                        print("###",self.questionArray)
//                        print("@@@",self.pollyArray)
//                        print("$$$",self.initalTime)
//                        print("%%%",self.mainTime)
                    }
                }
            }
            catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
    
    func getApi() {
        let urlString = "https://demo.evueme.com/MVP-HTML/api/MainQuestion"
        let urlPath = URL(string: urlString)!
        let urlRequest = URLRequest(url: urlPath)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    guard let dataArray = jsonResult["ActualQuestions"] as? NSArray else {return}
                    DispatchQueue.main.async {
                        print(dataArray)
//                        for item in dataArray {
//                            let obj = item as! NSDictionary
//                            print(obj["ques_descrip"] as! String)
//                            self.API.text = (obj["ques_descrip"] as! String)
//                            print(obj["ques_polly"]  as! String)
//                            self.tokens.text = (obj["ques_polly"]  as! String)
//                            print((obj["prep_time"] as! String).numberOfSeconds())
//                            let sss = ((obj["prep_time"] as! String).numberOfSeconds())
//                            self.session.text = String(sss)
//                            print((obj["resp_time"] as! String).numberOfSeconds())
//                            print(obj["retake"] as! Int)
//                            self.inti += 1
//
//                        }
                    }
                }
            }
            catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
    
    func generatePracticeSession() {
        let urlString = "https://demo.evueme.com/question/1/Practicequestionare"
        let urlPath = URL(string: urlString)!
        let urlRequest = URLRequest(url: urlPath)

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSArray {                    DispatchQueue.main.async {
                    for item in jsonResult {
                        let obj = item as! NSDictionary
                        practiceQuestion = (obj["ques_descrip"] as!
                            String)
                        //                            audioString = ( obj["ques_polly"]  as! String)
                        initalPracTime = (obj["prep_time"] as! String).numberOfSeconds()
                        mainPracTime = (obj["resp_time"] as! String).numberOfSeconds()
                        responseTime = (obj["resp_time"] as! String)
                        retakeCount = (obj["retake"] as! Int)
                        practiceQuesId = (obj["quesid"] as! Int)
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
extension String {
    func numberOfSeconds() -> Int {
        var components: Array = self.components(separatedBy: ":")
//        let hours = Int(components[0]) ?? 0
        let minutes = Int(components[0]) ?? 0
        let seconds = Int(components[1]) ?? 0
//        return (hours * 3600) + (minutes * 60) + seconds
        return (minutes * 60) + seconds
    }
}
//extension String {
//    var html2Attributed: NSAttributedString? {
//        do {
//            guard let data = data(using: String.Encoding.utf8) else {
//                return nil
//            }
//            return try NSAttributedString(data: data,
//                                          options: [.documentType: NSAttributedString.DocumentType.html,
//                                                    .characterEncoding: String.Encoding.utf8.rawValue],
//                                          documentAttributes: nil)
//        } catch {
//            print("error: ", error)
//            return nil
//        }
//    }
//}
