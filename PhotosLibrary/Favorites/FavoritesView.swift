//
//  FavoritesView.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 31.10.2021.
//

import UIKit

class FavoritesView: UIView {
    // MARK: - Properties
    var savedPhotos = [PhotoRealmObject]()
    var delegate: FavoritesViewControllerDelegate? {
        didSet {
            setupSubviews()
        }
    }
    
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
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func setupSubviews() {
        if let delegate = delegate {
            savedPhotos = delegate.loadData()
        }
        var constraints = [NSLayoutConstraint]()
        if savedPhotos.isEmpty {
            addSubview(notSavedYetLabel)
            constraints = [
                notSavedYetLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
                notSavedYetLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor)
            ]
        } else {
            tableView.delegate = self
            tableView.dataSource = self
            addSubview(tableView)
            constraints = [
                tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ]
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    func reloadData() {
        if let delegate = delegate {
            savedPhotos = delegate.loadData()
        }
        tableView.reloadData()
    }

}

//MARK: - Extensions
extension FavoritesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FavoritesTableViewCell
        cell.photo = savedPhotos[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        delegate.showNextViewController(photoId: savedPhotos[indexPath.item].id,
                                        profileImageUrl: savedPhotos[indexPath.item].userProfileUrl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
