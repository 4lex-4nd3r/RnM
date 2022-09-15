//
//  DetailCollectionViewCell.swift
//  RnM
//
//  Created by Александр on 14.09.2022.
//

import UIKit
import SnapKit

class DetailCollectionViewCell: UICollectionViewCell {
   
   //MARK: - Properties
   
   let idCell = "CollectionCell"
   
   private let numberLabel: UILabel = {
      let label = UILabel()
      label.font = .systemFont(ofSize: 30, weight: .heavy)
      label.textColor = .white
      label.textAlignment = .center
      return label
   }()
   
   var viewModel: DetailCollectionViewCellViewModelProtocol! {
      didSet {
         numberLabel.text = viewModel.number
      }
   }

   //MARK: - Init
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .brown
      addSubview(numberLabel)
      layer.cornerRadius = 5
      numberLabel.snp.makeConstraints { make in
         make.centerX.centerY.equalToSuperview()
      }
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
