//
//  NetworkManager.swift
//  SampleApp
//
//  Created by user176267 on 8/7/20.
//  Copyright © 2020 user176267. All rights reserved.
//

import Foundation
import Alamofire

protocol ContactManagerDelegate {
    func didContactUpdate(_ networkManager: NetworkManager, contacts: ContactData)
    func failWithError(error: Error)
}

final class NetworkManager {
    
    private let url = "https://api.androidhive.info/contacts/"
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

