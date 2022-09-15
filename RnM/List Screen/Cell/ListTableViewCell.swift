//
//  ListTableViewCell.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import UIKit
import SDWebImage

class ListTableViewCell: UITableViewCell {

   // MARK: - Properties
   
   private let personImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.layer.cornerRadius = 10
      imageView.clipsToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   private let nameLabel: UILabel = {
      let label = UILabel()
      label.adjustsFontSizeToFitWidth = true
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()
   private let statusLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()

   private let genderLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
   }()

   private var labelsStack = UIStackView()
   
   var viewModel: ListTableViewCellViewModelProtocol! {
      didSet {
         nameLabel.text = viewModel.name
         statusLabel.text = viewModel.status
         genderLabel.text = viewModel.gender
         personImageView.sd_setImage(with: URL(string: viewModel.imageURL))
      }
   }

   // MARK: - Init
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupViews()
      setConstraints()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   // MARK: - Setups
   
   private func setupViews() {
      backgroundColor = .clear
      selectionStyle = .none
      addSubview(personImageView)
      labelsStack = UIStackView(arrangedSubviews: [nameLabel,
                                                   statusLabel,
                                                   genderLabel])
      labelsStack.axis = .vertical
      labelsStack.distribution = .equalSpacing
      labelsStack.translatesAutoresizingMaskIntoConstraints = false
      addSubview(labelsStack)
   }
   
   // MARK: - Constraints
   
   private func setConstraints() {
      
      NSLayoutConstraint.activate([
         personImageView.widthAnchor.constraint(equalToConstant: 100),
         personImageView.heightAnchor.constraint(equalToConstant: 100),
         personImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
         personImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
      ])
      
      NSLayoutConstraint.activate([
         labelsStack.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 30),
         labelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
         labelsStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
         labelsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
      ])
   }
}

