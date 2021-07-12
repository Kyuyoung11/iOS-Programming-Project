//
//  TableViewController.swift
//  project-1871180
//
//  Created by mac014 on 2021/05/24.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var detectedItem = [String]()
    var cartList = [String]()
    
    



}
extension TableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.dataSource = self
        tableView.delegate = self

      
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)!.backgroundColor = .yellow
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)!.backgroundColor = .white
    }
}


extension TableViewController {
    override func viewWillAppear(_ animated: Bool) {
        let tabBarController = parent as! UITabBarController
        let yoloViewController = tabBarController.viewControllers![0] as! YoloViewController
        detectedItem = yoloViewController.getDetectedItem()
        
        tableView.reloadData()
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detectedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        
        
        let item = detectedItem[indexPath.row]
        cell.backgroundColor = .white
        cell.textLabel!.text = item
              
        return cell
    }
    
    
}

extension TableViewController {
    //cell을 누르면 WebViewController에 해당 cell에 있는 물체 이름을 전달함
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let index = self.tableView.indexPath(for: cell)
        let dest = segue.destination
        guard let webViewController = dest as? WebViewController else {
            return 
        }
        
        webViewController.cellTitle = detectedItem[(index?.row)!]
        
    }
}










