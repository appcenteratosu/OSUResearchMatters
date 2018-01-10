//
//  SocialTableViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 1/10/18.
//  Copyright © 2018 Oklahoma State University. All rights reserved.
//

import UIKit
import TwitterKit

class SocialTableViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeader()

        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: nil,
                                                     userID: "570260961",
                                                     apiClient: client,
                                                     maxTweetsPerRequest: 100,
                                                     includeReplies: false,
                                                     includeRetweets: true)
        self.showTweetActions = true
        
        if Twitter.sharedInstance().sessionStore.hasLoggedInUsers() {
            let store = Twitter.sharedInstance().sessionStore
            let session = store.session()!
            
            print("Logged in as:", session.userID)
        } else {
            print("No Users")
            Twitter.sharedInstance().logIn(completion: { (session, error) in
                if error != nil {
                    print("Error Loggin in")
                } else {
                    print(session!.userName)
                }
            })
        }
        
    }

    func setupHeader() {
        let logo = #imageLiteral(resourceName: "Header-2")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
}
