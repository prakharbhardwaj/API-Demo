//
//  PlayerViewController.swift
//  APIDemo
//
//  Created by Prakhar Prakash Bhardwaj on 16/05/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.play()
    }
    
    func play() {
        let url = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: url!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.addChild(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.playerView.frame
        player.play()
    }
}
