//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by Mutlu Celep on 21.06.2020.
//  Copyright © 2020 Mutlu Celep. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController{
    
    var userName: String = ""
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViewArray: [UIView] = []
    let dateLabel = CustomBodyLabel(textAlignment: .center)
    
    weak var delegate: FollowerListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
        
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: userName){
            [weak self] result in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User){
        let repoItemVC          = RepoItemVC(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = FollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: UserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: followerItemVC, to: self.itemViewOne)
        self.add(childVC: repoItemVC, to: self.itemViewTwo)
        
        self.dateLabel.text = "Github user since \(user.createdAt.convertToDisplayFormat())"
    }
    
    func layoutUI(){
        itemViewArray = [headerView,itemViewOne,itemViewTwo, dateLabel]
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        for itemView in itemViewArray {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self) //called after the VC is added from a container view controller.
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(url: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentAlertOnMainThread(title: "No Followers", message: "This user has no followers.", buttonTitle: "Ok")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
