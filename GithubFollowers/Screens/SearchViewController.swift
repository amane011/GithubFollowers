//
//  SearchViewController.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 10/28/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField  = CustomTextField()
    let callToActionButton = CustomButton(backgroundColor: .systemGreen, title: "Get User Info")
    var isUsernameEntered : Bool { return !usernameTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureActionButton()
        createDismissKeyboardSwipeGesture()
        
    }
    override func viewWillAppear(_ animated: Bool){
           super.viewWillAppear(animated)
           navigationController?.setNavigationBarHidden(true, animated: true) 
       }
    
    
    private func createDismissKeyboardSwipeGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC(){
        guard isUsernameEntered else{
            presentCustomAlert(title: "Empty Username", message: "Please enter a valid username", buttonTitle: "Ok")
            return
        }
        
        let userInfoVC = UserInfoViewController()
        userInfoVC.userName = usernameTextField.text!
        userInfoVC.title =   usernameTextField.text!
        navigationController?.pushViewController(userInfoVC, animated: true)
//        let followeListVC = FollowersListViewController()
//        followeListVC.userName = usernameTextField.text!
//        followeListVC.title = usernameTextField.text!
//        navigationController?.pushViewController(followeListVC, animated: true)
        
    }
    
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    

}
extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}


