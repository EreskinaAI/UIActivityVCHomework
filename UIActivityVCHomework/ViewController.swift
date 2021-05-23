//
//  ViewController.swift
//  UIActivityVCHomework
//
//  Created by Анна Ереськина on 23.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    /// Кнопка "поделиться"
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.backgroundColor = .purple
        button.setTitle("SHARE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    /// Ввод сообщения
    private let messageTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a message text"
        tf.backgroundColor = .lightGray
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    /// Заголовок
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Shared message:"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Переданное сообщение
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        makeConstraints()
    }
}

//MARK: User methods

extension ViewController {
    
    private func setupView() {
        view.backgroundColor = .gray
        view.addSubview(shareButton)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(messageTF)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            messageTF.heightAnchor.constraint(equalToConstant: 44),
            messageTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            messageTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            messageTF.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -60),
            
            shareButton.heightAnchor.constraint(equalToConstant: 64),
            shareButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            shareButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            titleLabel.topAnchor.constraint(equalTo: shareButton.bottomAnchor, constant: 80),
            
            messageLabel.heightAnchor.constraint(equalToConstant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }
}

//MARK:  Action

extension ViewController {
    @objc func shareButtonTapped() {
        let item: Any = messageTF.text as Any
        
        let customActivity = CustomActivity(title: "My activity", imageName: "summer") { items in
            self.messageLabel.text = items.reduce("") {
                ($0 + (($1 as? [String])?.joined(separator: " ") ?? "")) }
        }
        
        let activityVC = UIActivityViewController(activityItems: [item],
                                                  applicationActivities: [customActivity])
        
        activityVC.excludedActivityTypes = [
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.saveToCameraRoll
        ]
        
        present(activityVC, animated: true)
    }
}
