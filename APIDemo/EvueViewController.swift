//
//  EvueViewController.swift
//  APIDemo
//
//  Created by Prakhar Prakash Bhardwaj on 08/04/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SDWebImage

struct Session: Decodable {
    let apiKey: String
    let sessionId: String
    let token: String
}

class EvueViewController: UIViewController {
    
//    @IBOutlet weak var img : ImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
//       generateSession()
//        img.sd_setImage(with: URL(string: "https://www.evueme.com/MVP-HTML/api/logo/br_naukri_logo.png") )
//        self.view.addSubview(UIView().customActivityIndicator(view: self.view, widthView: nil, backgroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
        
        self.view.backgroundColor = UIColor(hexFromString: "\(bgColor)")
        print(UIColor(hexFromString: "\(bgColor)"))
    }
    
    fileprivate func fetchCourseJSONwithResult(completion: @escaping (Result<Session, Error>) -> Void) {
                self.view.addSubview(UIView().customActivityIndicator(view: self.view, widthView: nil, backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)))
        
        let urlString = "https://demo.evueme.com/applicant/androidSessionGenerate"
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("iOS", forHTTPHeaderField: "deviceType")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, err) in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(Session.self, from: data)
                completion(.success(courses))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
            
            }.resume()
    }
    
    func generateSession() {
        fetchCourseJSONwithResult { (res) in
            switch res {
            case .success(let jsonResult):
//                    print(jsonResult.apiKey)
//                    print(jsonResult.sessionId)
//                    print(jsonResult.token)
                    DispatchQueue.main.async { // Correct
                        print(jsonResult.apiKey)
                        print(jsonResult.sessionId)
                        print(jsonResult.token)

//                        self.view.subviews.last?.removeFromSuperview()
                }
            case .failure(let err):
                print("Failed to fetch courses", err)
            }
        }
    }
    
}

//struct Job: Decodable {
//    var title: String
//    var salary: Float
//
//    init(title: String, salary: Float) {
//        self.title = title
//        self.salary = salary
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case title, salary
//    }
//}
//
//struct Person: Decodable {
//    var job: Job
//    var firstName: String
//    var lastName: String
//    var age: Int
//
//    init(job: Job, firstName: String, lastName: String, age: Int) {
//        self.job = job
//        self.firstName = firstName
//        self.lastName = lastName
//        self.age = age
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case job = "job_information", firstName = "firstname", lastName = "lastname", age
//    }
//}
//
//let rawData = """
//{
//    "job_information": {
//        "title": "iOS Developer",
//        "salary": 5000
//    },
//    "firstname": "John",
//    "lastname": "Doe",
//    "age": 20
//}
//""".data(using: .utf8)!
//
//
//let person = try JSONDecoder().decode(Person.self, from: rawData)
//print(person.firstName) // John
//print(person.lastName) // Doe
//print(person.job.title) // iOS Developer

extension UIColor {
    convenience init(hexFromString: String, alpha: CGFloat = 1.0) {
        var cString: String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt32 = 10066329 //color #999999 if string has wrong format
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) == 6 {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
