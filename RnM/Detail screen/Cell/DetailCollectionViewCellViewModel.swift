//
//  DetailCollectionViewCellViewModel.swift
//  RnM
//
//  Created by Александр on 14.09.2022.
//

import Foundation

protocol DetailCollectionViewCellViewModelProtocol {
   init(number: String)
   var number: String { get }
}


class DetailCollectionViewCellViewModel: DetailCollectionViewCellViewModelProtocol {
   
   required init(number: String) {
      self.number = number
   }
   
   var number: String
}
