//
//  WebViewController.swift
//  APIDemo
//
//  Created by Prakhar Prakash Bhardwaj on 28/03/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import WebKit
import Reachability

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var practiceVideo: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReachabilityManager.shared.addListener(listener: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.removeListener(listener: self)
    }
    
    func loadVideo() {
        guard let videoURL = URL(string: "https://www.tripvenza.com/dashboard/")
            else { return }
        practiceVideo.load( URLRequest(url: videoURL) )
        practiceVideo.navigationDelegate = self
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
}

extension WebViewController: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.Connection) {
        
        switch status {
        case .none:
            debugPrint("ViewController: Network became unreachable")
        case .wifi:
            debugPrint("ViewController: Network reachable through WiFi")
        case .cellular:
            debugPrint("ViewController: Network reachable through Cellular Data")
        }
        
        // Update login button Enable/Disable status
        //        loginButton.isEnabled = !(status == .notReachable)
        if status == .none {
            let alert = UIAlertController(title: "Oops!", message: "No Internet Connection", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertAction)
//            present(alert, animated: true, completion:nil)
            if let presented = self.presentedViewController {
                presented.removeFromParent()
            }
            
            if presentedViewController == nil {
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            loadVideo()
        }
    }
}
