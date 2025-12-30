//
//  HomeViewController.swift
//  Reminder
//
//  Created by Gabriel on 12/11/25.
//

import UIKit

class HomeViewController: UIViewController {
    let contentView: HomeView
    weak var flowDelegate: HomeFlowDelegate?
    
    init(view: HomeView, flowDelegate: HomeFlowDelegate) {
        self.contentView = view
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupConstraints()
        setupNewPrescriptionNavigation()
        setupMyPrescriptionsNavigation()
        loadUserData()
        contentView.delegate = self
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        
    }
    
    private func setupConstraints() {
        self.setupContentViewToBounds(contentView)
    }

    private func loadUserData() {
        if let user = UserDefaultsManager.loadUser() {
            contentView.usernameTextField.text = user.name
            if let image = user.image {
                contentView.profileImage.image = UIImage(data: image)
            }
        }
        
    }
}

extension HomeViewController {
    private func setupNewPrescriptionNavigation() {
        contentView.newPrescriptionButton.onTap = { [weak self] in
            self?.flowDelegate?.navigateToNewPrescription()
        }
    }
    
    private func setupMyPrescriptionsNavigation() {
        contentView.myPrescriptionsButton.onTap = { [weak self] in
            self?.flowDelegate?.navigateToMyPrescriptions()
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func didProfileImageTapped() {
        selectProfileImage()
    }
    
    func logoutUser() {
        UserDefaultsManager.removeUser()
        self.flowDelegate?.logout()
    }
    
    func didUpdateUsername(username: String) {
        UserDefaultsManager.updateUser(image: nil, name: username)
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            contentView.profileImage.image = editedImage
            UserDefaultsManager.updateUser(image: editedImage, name: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.profileImage.image = originalImage
            UserDefaultsManager.updateUser(image: originalImage, name: nil)
        }
        
        dismiss(animated: true)
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

