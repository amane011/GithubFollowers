//
//  CustomItemInfoVC.swift
//  GithubFollowers
//
//  Created by Ankit  Mane on 11/18/23.
//

import UIKit

class CustomItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = CustomItemInfoView()
    let itemInfoViewTwo = CustomItemInfoView()
    let actionButton  = CustomButton()
    
    var user: User!
    weak var delgate: UserInfoVCDelgate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action:#selector(actionButtonPressed), for: .touchUpInside)
    }
    
    @objc func actionButtonPressed() {}
    
    private func layoutUI(){
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            ])
            
    }
}
