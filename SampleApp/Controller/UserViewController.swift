//
//  UserViewController.swift
//  SampleApp
//
//  Created by user176267 on 8/7/20.
//  Copyright © 2020 user176267. All rights reserved.
// https://api.androidhive.info/contacts/

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ContactManagerDelegate {
            
    var arr_name = [String]()
    var arr_email = [String]()
    
    var networkManager = NetworkManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        networkManager.getContacts()
    }
    
    func didContactUpdate(_ networkManager: NetworkManager, contacts: ContactData) {
        print(contacts.contacts[0])
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.arr_email.removeAll()
            self.arr_name.removeAll()
            
            for i in contacts.contacts{
                let name = i.name
                self.arr_name.append(name)
                let email = i.email
                self.arr_email.append(email)
            }
            self.tableView.reloadData()
        }
    }
    
    func failWithError(error: Error) {
        print(error)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
        cell?.textLabel?.text = arr_name[indexPath.row]
        return cell!
    
    }
    
}
