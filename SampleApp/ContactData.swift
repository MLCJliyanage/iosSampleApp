//
//  ContactData.swift
//  SampleApp
//
//  Created by user176267 on 8/10/20.
//  Copyright © 2020 user176267. All rights reserved.
//

import Foundation

struct ContactData: Codable {
    //let name: String
    let contacts: [Contact]
}

struct Contact: Codable {
    let name: String
    let email: String
}

