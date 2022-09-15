//
//  Person.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import Foundation

// MARK: - Persons

struct Persons: Decodable {
   let results: [Person]
}

// MARK: - Person

struct Person: Codable {
   let name: String
   let status: Status
   let gender: Gender
   let image: String
   let episode: [String]
}

enum Gender: String, Codable {
   case female = "Female"
   case male = "Male"
   case unknown = "unknown"
   case genderless = "Genderless"
}

enum Status: String, Codable {
   case alive = "Alive"
   case dead = "Dead"
   case unknown = "unknown"
}
