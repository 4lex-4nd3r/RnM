//
//  DetailViewController.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import UIKit
import SnapKit

class DetailViewController : UIViewController {
   
   // MARK: - Properties
   
   private let personImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.layer.cornerRadius = 20
      imageView.clipsToBounds = true
      return imageView
   }()
   
   private let episodesLabel: UILabel = {
      let label = UILabel()
      label.text = "present in episodes"
      label.font = .systemFont(ofSize: 25, weight: .bold)
      return label
   }()
   
   private let collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = 10
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout )
      collectionView.backgroundColor = .none
      collectionView.showsVerticalScrollIndicator = false
      return collectionView
   }()
   
   private let detailCell = DetailCollectionViewCell()
   private let idDetailCell = "idDetailCell"
   
   var viewModel: DetailViewModelProtocol
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setupUI()
      setConstraints()
   }
   
   required init(viewModel: DetailViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   //MARK: - Setups
   
   private func setupViews() {
      view.backgroundColor = .systemBackground
      view.addSubview(personImageView)
      view.addSubview(episodesLabel)
      view.addSubview(collectionView)
      collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: idDetailCell)
      collectionView.dataSource = self
      collectionView.delegate = self
   }
   
   private func setupUI() {
      navigationItem.title = viewModel.name
      personImageView.sd_setImage(with: URL(string: viewModel.image))
      collectionView.reloadData()
   }

   //MARK: - Constraints
   
   private func setConstraints() {
      
      personImageView.snp.makeConstraints { make in
         make.width.height.equalTo(200)
         make.centerX.equalToSuperview()
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
      }

      episodesLabel.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(personImageView.snp.bottom).inset(-20)
      }

      collectionView.snp.makeConstraints { make in
         make.top.equalTo(episodesLabel.snp.bottom).inset(-20)
         make.left.right.bottom.equalToSuperview().inset(40)
      }
   }
}

//MARK: - UICollectionViewDataSource


extension DetailViewController: UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      viewModel.numberOfItems()
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idDetailCell, for: indexPath) as? DetailCollectionViewCell else {
         return UICollectionViewCell()
      }
      cell.viewModel = viewModel.cellViewModel(for: indexPath)
      return cell
   }
}

//MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {}

//MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 50, height: 50)
   }
}
