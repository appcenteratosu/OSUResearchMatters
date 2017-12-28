//
//  WebViewViewController.swift
//  OSUResearchMatters
//
//  Created by App Center on 12/23/17.
//  Copyright © 2017 Oklahoma State University. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openWebViewWith(url: url)
       
    }
    
    var url: URL!
    func openWebViewWith(url: URL) {
        // load requested page
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    @IBAction func closeWebView(_ sender: UIButton) {
        performSegue(withIdentifier: "returnFromWeb", sender: self)
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
