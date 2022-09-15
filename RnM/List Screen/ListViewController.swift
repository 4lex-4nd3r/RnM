//
//  ListViewController.swift
//  R'n'M-test-v1
//
//  Created by Александр on 14.09.2022.
//

import UIKit

class ListViewController : UIViewController {
   
   // MARK: - Properties
   
   private let backImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.image = UIImage(named: "back")
      imageView.contentMode = .scaleAspectFit
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
   }()
   
   private let tableView: UITableView = {
      let tv = UITableView()
      tv.isHidden = true
      tv.translatesAutoresizingMaskIntoConstraints = false
      return tv
   }()
   
   private let activity: UIActivityIndicatorView = {
      let act = UIActivityIndicatorView()
      act.translatesAutoresizingMaskIntoConstraints = false
      act.startAnimating()
      return act
   }()

   private let listCell = ListTableViewCell()
   private let idListCell = "idListCell"
   
   private var viewModel: ListViewModel! {
      didSet {
         viewModel.getPersons { [weak self] in
            guard let self = self else { return }
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.backImageView.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
         }
      }
   }
   
   // MARK: - Lifecycle
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      setConstraints()
      setDelegates()
      viewModel = ListViewModel()
   }
   
   //MARK: - Setups
   
   private func setupViews() {
      view.backgroundColor = .systemBackground
      let logoutButton = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.badge.xmark"), style: .done, target: self, action: #selector(logoutButtonTapped))
      navigationItem.rightBarButtonItem = logoutButton
      view.addSubview(backImageView)
      navigationItem.title = "Persons"
      view.addSubview(tableView)
      tableView.register(ListTableViewCell.self, forCellReuseIdentifier: idListCell)
      view.addSubview(activity)
   }
   
   private func setDelegates() {
      tableView.delegate = self
      tableView.dataSource = self
   }

   //MARK: - Selectors
   
   @objc private func logoutButtonTapped() {
      
      UserDefaults.standard.set(Login.notLogin.rawValue, forKey: UserDefaultsKeys.loginKey.rawValue)
      
      guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
      
      window.rootViewController = LoginViewController()
      UIView.transition(with: window, duration: 1, options: [.transitionCrossDissolve], animations: {}, completion: nil)
   }
  
   //MARK: - Constraints
   
   private func setConstraints() {
      
      NSLayoutConstraint.activate([
         activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         activity.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
      ])
      
      NSLayoutConstraint.activate([
         backImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
      
      NSLayoutConstraint.activate([
         tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
   }
}

//MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      110
   }
   
   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     
      let count = viewModel.numberOfRows()
      guard count != 826 else { return }
     
      if indexPath.row == count - 1 {
         let activity = UIActivityIndicatorView(style: .medium)
         activity.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(110))
         activity.startAnimating()
         tableView.tableFooterView = activity
         tableView.tableFooterView?.isHidden = false
//         load data
         viewModel.getPersons {
            tableView.reloadData()
            tableView.tableFooterView?.isHidden = true
         }
      }
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

      let viewModel = viewModel.detailViewModel(for: indexPath)
      let detailVC = DetailViewController(viewModel: viewModel)
      navigationController?.pushViewController(detailVC, animated: true)
   }
}

//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      viewModel.numberOfRows()
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: idListCell, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
      cell.viewModel = viewModel.cellViewModel(for: indexPath)
      return cell
   }
}

