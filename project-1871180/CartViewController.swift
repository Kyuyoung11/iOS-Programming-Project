///Users/mac005/Downloads/project-1871180-2/project-1871180/WebViewController.swift
//  CartViewController.swift
//  project-1871180
//
//  Created by mac022 on 2021/05/28.
//

import UIKit

class CartViewController: UIViewController {

    var cartList = [String]()
    var urlList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func editTable(_ sender: UIBarButtonItem) {
        if tableView.isEditing == true {
            tableView.isEditing = false
            sender.title = "Edit"
        } else {
            tableView.isEditing = true
            sender.title = "Done"
        }
    }
    
}

extension CartViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.dataSource = self
        tableView.delegate = self

        
        
      
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)!.backgroundColor = .yellow
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)!.backgroundColor = .white
    }
}


extension CartViewController {
    override func viewWillAppear(_ animated: Bool) {
        
        //AppDelegate에 있는 저장한 url의 title목록과 url목록을 가져옴
        let ad = UIApplication.shared.delegate as? AppDelegate
        if let list = ad?.cartList {
            self.cartList = list
            print(cartList)
        }
        if let url = ad?.urlList {
            self.urlList = url
            print(urlList)
        }
        
        //가져온 목록을 tableView에 표시
        tableView.reloadData()
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableCell")!
        
        
        let item = cartList[indexPath.row]
        cell.backgroundColor = .white
        cell.textLabel!.text = item
        
        
              
        return cell
    }
}

extension CartViewController {
    //cell을 누르면 CartWebViewController에 해당 cell의 물체 이름과 url을 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let index = self.tableView.indexPath(for: cell)
        let dest = segue.destination
        guard let webViewController = dest as? CartWebViewController else {
            return
        }
        webViewController.cellTitle = cartList[(index?.row)!]
        webViewController.cellUrl = urlList[(index?.row)!]
        
    }
}

extension CartViewController {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Edit에서 delete버튼을 눌렀을 때 동작
        if editingStyle == .delete{
            
            let title = "Delete \(cartList[indexPath.row])"
            let message = "Are you sure ...."
            
            let alertConroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Sure", style: .destructive) {
                (action) in
                let ad = UIApplication.shared.delegate as? AppDelegate
                ad?.cartList.remove(at: indexPath.row)
                self.cartList.remove(at: indexPath.row)
                
                ad?.urlList.remove(at: indexPath.row)
                self.urlList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            alertConroller.addAction(cancelAction)
            alertConroller.addAction(deleteAction)
            
            present(alertConroller, animated: true)
            
        }
    }
}


