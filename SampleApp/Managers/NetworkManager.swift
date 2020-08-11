//
//  NetworkManager.swift
//  SampleApp
//
//  Created by user176267 on 8/7/20.
//  Copyright © 2020 user176267. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ContactManagerDelegate {
    func didContactUpdate(_ networkManager: NetworkManager, contacts: ContactData)
    func failWithError(error: Error)
}

protocol AlamofireManagerDelegate {
    func didGetData(_ networkManager: AlamofireManager, data: Any)
    func failWithError(error: Error)
}

let url = AppConstant.apiUrl

final class NetworkManager {
    
    var delegate: ContactManagerDelegate?
    
    func getContacts(){
        if let urlString = URL(string: "\(url)"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString) { (data, response, error) in
                if error != nil {
                    self.delegate?.failWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let contacts = self.parseJSON(data: safeData){
                        self.delegate?.didContactUpdate(self, contacts:contacts)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    
    func parseJSON(data: Data) -> ContactData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ContactData.self, from: data)
            print(decodedData.contacts[0])
            return decodedData
        } catch{
            delegate?.failWithError(error: error)
            return nil
        }
    }
}


final class AlamofireManager {
    
    var delegate: AlamofireManagerDelegate?
    
    func getData() {
        if let urlString = URL(string: "\(url)") {
            AF.request(urlString)
                .responseJSON { (response) in
                    switch response.result{
                    case .success:
                        self.delegate?.didGetData(self, data: response.data!)
                        break
                    case .failure:
                        print(response.error!)
                        self.delegate?.failWithError(error: response.error!)
                        break
                    }
            }
        }
        
    }
    
}

