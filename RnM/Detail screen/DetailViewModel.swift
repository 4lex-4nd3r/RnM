//
//  DetailViewModel.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import Foundation


protocol DetailViewModelProtocol {
   
   init(person: Person)
   
   var name: String { get }
   var image: String { get }
   var episode: [String] { get }
   
   func numberOfItems() -> Int
   func cellViewModel(for indexPath: IndexPath) -> DetailCollectionViewCellViewModelProtocol
}

class DetailViewModel: DetailViewModelProtocol {
 
   private var person: Person
   
   required init(person: Person) {
      self.person = person
   }
   
   var name: String {
      return person.name
   }
   
   var image: String {
      return person.image
   }
   
   var episode: [String] {
      return person.episode
   }
   
   func numberOfItems() -> Int {
      person.episode.count
   }
   
   func cellViewModel(for indexPath: IndexPath) -> DetailCollectionViewCellViewModelProtocol {
      let fullLink = person.episode[indexPath.row]
      let number = String(fullLink.dropFirst(40))
      return DetailCollectionViewCellViewModel(number: number)
   }
}

