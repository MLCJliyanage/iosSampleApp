//
//  AlamofireViewController.swift
//  SampleApp
//
//  Created by user176267 on 8/11/20.
//  Copyright © 2020 user176267. All rights reserved.
//

import UIKit
import SwiftyJSON

class AlamofireViewController: UIViewController, AlamofireManagerDelegate {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    var networkManager = AlamofireManager()
    var userName: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        networkManager.getData()
    }
    
    func didGetData(_ networkManager: AlamofireManager, data: Any) {
        let dataSet = try? JSON(data: data as! Data)
        let resultArray = dataSet!["contacts"]
        DispatchQueue.main.async {
            self.lblName.text = resultArray.arrayValue[0]["name"].stringValue
            self.lblEmail.text = resultArray.arrayValue[0]["email"].stringValue
            self.lblUserName.text = "Welcome \(String(describing: self.userName!))!"
        }
    }
    
    func failWithError(error: Error) {
        print(error)
    }

}
