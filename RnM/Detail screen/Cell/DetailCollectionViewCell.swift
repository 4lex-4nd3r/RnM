//
//  DetailCollectionViewCell.swift
//  RnM
//
//  Created by Александр on 14.09.2022.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
   
   //MARK: - Properties
   
   let idCell = "CollectionCell"
   
   private let numberLabel: UILabel = {
      let label = UILabel()
 
      label.font = .systemFont(ofSize: 30, weight: .heavy)
      label.textColor = .white
      label.textAlignment = .center
      
      label.translatesAutoresizingMaskIntoConstraints = false
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
      setupViews()
      setConstraints()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Setups
   
   private func setupViews() {
      backgroundColor = .brown
      addSubview(numberLabel)
      layer.cornerRadius = 5
   }
   
   //MARK: - Constraints
   
   private func setConstraints() {
      
      NSLayoutConstraint.activate([
         numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
         numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
   }
}
