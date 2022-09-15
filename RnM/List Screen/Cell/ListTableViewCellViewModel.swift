//
//  ListTableViewCellViewModel.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import Foundation

protocol ListTableViewCellViewModelProtocol: AnyObject {
   
   init(person: Person)
   
   var name: String { get }
   var status: String { get }
   var gender: String { get }
   var imageURL: String { get }
}

class ListTableViewCellViewModel: ListTableViewCellViewModelProtocol {

   private var person: Person
   
   required init(person: Person) {
      self.person = person
   }
   
   var name: String {
      return person.name + " \(person.id)"
   }
   
   var status: String {
      "Is " + person.status
   }
   
   var gender: String {
      person.gender
   }
   
   var imageURL: String {
      person.image
   }
}
