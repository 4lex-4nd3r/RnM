//
//  NetworkManager.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import Foundation

class NetworkManager {
   
   static let shared = NetworkManager()
   private init () {}
   
   func getPersons(forPage: Int, completion: @escaping ([Person]) -> Void) {
      let getPersonsManager = GetPersonsManager()

      getPersonsManager.getPersons(forPage: forPage) { result in
         switch result {
         case .success(let persons):
            completion(persons)
         case .failure(let error):
            print(error.localizedDescription)
            completion([])
         }
      }
   }
}
