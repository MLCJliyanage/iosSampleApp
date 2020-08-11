//
//  ViewController.swift
//  SampleApp
//
//  Created by user176267 on 8/6/20.
//  Copyright © 2020 user176267. All rights reserved.
//

import UIKit
import WebKit

let htmlUrl = AppConstant.htmlUrl

class ViewController: UIViewController{

    @IBOutlet weak var webView: WKWebView!
    
    private func setupWebView() {
        
        let contentController = WKUserContentController()
        let userScript = WKUserScript(
            source: "mobileHeader()",
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.add(self, name: "loginAction")
        contentController.add(self, name: "getUsers")
        contentController.add(self, name: "alamofireGet")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.webView = WKWebView(frame: self.view.bounds, configuration: config)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupWebView()
        self.view.addSubview(self.webView)

        let htmlPath = Bundle.main.path(forResource: htmlUrl, ofType: "html")
        let htmlUrl = URL(fileURLWithPath: htmlPath!, isDirectory: false)
        self.webView.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl)
    }


}

extension ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "loginAction" {
            print("JavaScript is sending a message \(message.body)")
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let alamofireViewController = storyboard.instantiateViewController(identifier: "alamofire_vc") as! AlamofireViewController
            // userViewController.modalPresentationStyle = .fullScreen
            alamofireViewController.userName = message.body as! String
            self.present(alamofireViewController, animated: true, completion: nil)
        }
        
        if message.name == "getUsers" {
            print(message.body)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let userViewController = storyboard.instantiateViewController(identifier: "user_view") as! UserViewController
            // userViewController.modalPresentationStyle = .fullScreen
            self.present(userViewController, animated: true, completion: nil)
        }
        
        if message.name == "alamofireGet" {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let alamofireViewController = storyboard.instantiateViewController(identifier: "alamofire_vc") as! AlamofireViewController
            self.present(alamofireViewController, animated: true, completion: nil)
        }
    }
}
