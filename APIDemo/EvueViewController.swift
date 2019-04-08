//
//  EvueViewController.swift
//  APIDemo
//
//  Created by Prakhar Prakash Bhardwaj on 08/04/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

struct Session: Decodable {
    let apiKey: String
    let sessionId: String
    let token: String
}

class EvueViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       generateSession()
    }
    
    fileprivate func fetchCourseJSONwithResult(completion: @escaping (Result<Session, Error>) ->()){
        
        let urlString = "https://demo.evueme.com/applicant/androidSessionGenerate"
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("iOS", forHTTPHeaderField: "deviceType")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            
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
                    print(jsonResult.apiKey)
                    print(jsonResult.sessionId)
                    print(jsonResult.token)
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
