//
//  MoreViewController.swift
//  KoreanBox
//
//  Created by Igor Ogai on 01.11.2021.
//

import UIKit
import FirebaseAuth

class MoreViewController: UIViewController {
    
    //MARK:- Private Properties
    
    private(set) lazy var customView = view as! MoreView
    
    //MARK:- Lifecycle
    
    override func loadView() {
        view = MoreView()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Ещё"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK:- Private Methods
    
    private func configure() {
        customView.logOutButton.addTarget(self, action: #selector(logOutPressed), for: .touchUpInside)
    }
    
    @objc private func logOutPressed() {
        let alert = UIAlertController(title: "Выходите?", message: "Вы действительно хотите выйти из аккаунта?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { (_: UIAlertAction) in
            do {
                try Auth.auth().signOut()
                
                let authVC = AuthenticationViewController()
                authVC.modalPresentationStyle = .fullScreen
                self.present(authVC, animated: true, completion: nil)
            } catch {
                
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
