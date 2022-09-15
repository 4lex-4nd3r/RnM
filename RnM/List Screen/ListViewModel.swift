//
//  ListViewModel.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import Foundation

protocol ListViewModelProtocol: AnyObject {
   
   var persons: [Person] { get }
   
   func getPersons(completion: @escaping () -> Void)
   func numberOfRows() -> Int
   func cellViewModel(for indexPath: IndexPath) -> ListTableViewCellViewModelProtocol
   func detailViewModel(for indexPath: IndexPath) -> DetailViewModelProtocol
   
   func loadMoreData(completion: () -> Void)
}

class ListViewModel: ListViewModelProtocol {

   var persons: [Person] = []
   
   func getPersons(completion: @escaping () -> Void) {
      
      let page = Int(persons.count / 20) + 1
      NetworkManager.shared.getPersons(forPage: page) { [weak self] persons in
         guard let self = self else { return }
         self.persons += persons
         
         // апи работает очень быстро, так что поставил задержку,
         // чтобы было видно что данные "грузятся"
         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion()
         }
      }
   }
   
   func numberOfRows() -> Int {
      persons.count
   }
   
   func cellViewModel(for indexPath: IndexPath) -> ListTableViewCellViewModelProtocol {
      let person = persons[indexPath.row]
      return ListTableViewCellViewModel(person: person)
   }
   
   func detailViewModel(for indexPath: IndexPath) -> DetailViewModelProtocol {
      print(indexPath.row + 1)
      let person = persons[indexPath.row]
      return DetailViewModel(person: person)
   }
   
   func loadMoreData(completion: () -> Void) {
      print("load")
      completion()
   }
}
