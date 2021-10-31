//
//  DetailedInformationViewController.swift
//  PhotosLibrary
//
//  Created by Konstantin Pimbursky on 18.10.2021.
//

import UIKit
import SDWebImage

protocol DetailedInformationViewControllerDelegate {
    func getSavedPhotos() -> [PhotoRealmObject]
    func getProfileImageUrl() -> String
    func savePhoto() -> Void
    func deletePhoto() -> Void
    func getDetailsOfPhoto(completion: @escaping (PhotoDetails?) -> Void) -> Void
}

class DetailedInformationViewController: UIViewController {

// MARK: - PROPERTIES
    private let viewModel: DetailedInformationInput

    
// MARK: - INIT
    init(viewModel: DetailedInformationInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        let detailsView = DetailedInformationView()
        detailsView.delegate = self
        self.view = detailsView
    }
}

// MARK: - EXTENSIONS
extension DetailedInformationViewController: DetailedInformationViewControllerDelegate {
    
    func getDetailsOfPhoto(completion: @escaping (PhotoDetails?) -> Void) {
        viewModel.getDetailsOfPhoto(completion: completion)
    }
    
    func getSavedPhotos() -> [PhotoRealmObject] {
        return viewModel.getSavedPhotos()
    }
    
    func getProfileImageUrl() -> String {
        return viewModel.getProfileImageUrl()
    }
    
    func savePhoto() {
        viewModel.savePhoto()
    }
    
    func deletePhoto() {
        viewModel.deletePhoto()
    }
}
