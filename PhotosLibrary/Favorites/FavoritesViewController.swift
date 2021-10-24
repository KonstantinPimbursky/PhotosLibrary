//
//  FavoritesViewController.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 20.10.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let coordinator: Coordinator
    private let viewModel: FavoritesViewInput
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    private let notSavedYetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вы еще не сохранили ни одной фотографии"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private var savedPhotos = [PhotoRealmObject]()
    
    init(coordinator: Coordinator,
         viewModel: FavoritesViewInput) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        savedPhotos = viewModel.getSavedPhotos()
        setupSubviews()
    }
    
    
    private func setupSubviews() {
        var constraints = [NSLayoutConstraint]()
        if savedPhotos.isEmpty {
            view.addSubview(notSavedYetLabel)
            constraints = [
                notSavedYetLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
                notSavedYetLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ]
        } else {
            tableView.delegate = self
            tableView.dataSource = self
            view.addSubview(tableView)
            constraints = [
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        }
        NSLayoutConstraint.activate(constraints)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FavoritesTableViewCell
        cell.photo = savedPhotos[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.showDetailedViewController(photoId: savedPhotos[indexPath.item].id,
                                               profileImageUrl: savedPhotos[indexPath.item].userProfileUrl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension FavoritesViewController: ReloadData {
    func reloadData() {
        savedPhotos = viewModel.getSavedPhotos()
        tableView.reloadData()
    }
}
