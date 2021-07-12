//
//  WebViewController.swift
//  project-1871180
//
//  Created by mac036 on 2021/05/27.
//

import UIKit
import WebKit
import SwiftSoup


class WebViewController: UIViewController {

    var cellTitle : String?
    var cartList = [String]()
    var talbeViewController : TableViewController?

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func gotoCartButton(_ sender: Any) {
        crawling()
    }
    

}
extension WebViewController {
    override func viewWillAppear(_ animated: Bool) {
        //YoloViewController에서 저장한 cellTitle값으로 아마존 사이트에 해당 물체를 검색한 페이지를 URLRequest 함
        if let title = cellTitle {
            print(title)
            let url = URL(string: "https://amazon.com/s?k=\(title)&ref=nb_sb_noss")
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    }
}
extension WebViewController {
    func crawling() {
        let url = webView.url
          
            guard let myURL = url else {   return    }
            
            do {
                //SwiftSoup을 통해 크롤링해서 현재 url의 title을 가져온다.
                let html = try String(contentsOf: myURL, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                let headerTitle = try doc.title()
                print(headerTitle)
               
                //AppDelegate에 있는 리스트에 url과 title를 저장한다.
                let ad = UIApplication.shared.delegate as? AppDelegate
                ad?.cartList.append(headerTitle)
                ad?.urlList.append(myURL.absoluteString)
                print(ad?.cartList)
                print(ad?.urlList)
                
                
            } catch Exception.Error(let _, let message) {
                print("Message: \(message)")
            } catch {
                print("error")
            }
        
    }
}





