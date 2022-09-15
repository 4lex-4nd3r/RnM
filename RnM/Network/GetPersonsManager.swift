//
//  GetPersonsManager.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import Foundation

class GetPersonsManager {
   
   let stringURL = "https://rickandmortyapi.com/api/character/?page="

   func getPersons(forPage: Int, completion: @escaping (Result<[Person], Error>) -> Void) {
      
      guard let url = URL(string: stringURL + "\(forPage)") else { return }
      URLSession.shared.dataTask(with: url) { data, _, error in
         DispatchQueue.main.async {
            if let error = error {
               completion(.failure(error))
            }
            guard let data = data else { return }
            do {
               let decoder = JSONDecoder()
               let personsData = try decoder.decode(Persons.self, from: data)
               let persons = personsData.results
               completion(.success(persons))
               
            } catch let jsonError {
               print("err")
               completion(.failure(jsonError))
            }
         }
      }.resume()
   }
}
