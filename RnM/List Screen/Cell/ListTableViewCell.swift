//
//  ListTableViewCell.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import UIKit
import SDWebImage
import SnapKit

class ListTableViewCell: UITableViewCell {

   // MARK: - Properties
   
   private let personImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.layer.cornerRadius = 10
      imageView.clipsToBounds = true
      return imageView
   }()
   
   private let nameLabel: UILabel = {
      let label = UILabel()
      label.adjustsFontSizeToFitWidth = true
      return label
   }()
   private let statusLabel: UILabel = {
      let label = UILabel()
      return label
   }()

   private let genderLabel: UILabel = {
      let label = UILabel()
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
      addSubview(labelsStack)
   }
   
   // MARK: - Constraints
   
   private func setConstraints() {
      
      personImageView.snp.makeConstraints { make in
         make.width.height.equalTo(100)
         make.left.equalToSuperview().inset(20)
         make.centerY.equalToSuperview()
      }
      
      labelsStack.snp.makeConstraints { make in
         make.top.bottom.equalToSuperview().inset(15)
         make.left.equalTo(personImageView.snp.right).inset(-30)
         make.right.equalToSuperview().inset(30)
      }
   }
}

