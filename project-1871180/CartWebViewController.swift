//
//  CartWebViewController.swift
//  project-1871180
//
//  Created by mac005 on 2021/05/29.
//

import UIKit
import WebKit
class CartWebViewController: UIViewController {

    var cellTitle : String?
    var cellUrl : String?
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //CartViewController에서 전달받은 url로 URLRequest
        if let title = cellTitle {
            print(title)
            if let url = URL(string: self.cellUrl!) {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }
    

}
