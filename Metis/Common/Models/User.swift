//
//  User.swift
//  Metis
//
//  Created by Veronika Zelinkova on 21.10.2023.
//

import Foundation

struct User: Codable {
    let firstName: String
    let secondName: String
    let birthdate: String
    let country: String
    let street: String
    let city: String
    let zipCode: Int
}
