//
//  DetailViewController.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import UIKit

class DetailViewController: UIViewController, DetailViewInput {
    
    @IBOutlet weak var userDetailStackView: UIStackView!
    
    var presenter: DetailViewPresenter?
    var router: DetailViewRouterProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.didViewReady()
    }
    
    // MARK: Methods
    func detailLoaded(_ detail: User) {
        self.configureUI(with: detail)
    }
    
    func detailNotLoaded() {
        let alertVC = UIAlertController(title: "Ошибка", message: "Данные не удалось загрузить", preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK", style: .default) { [weak router = self.router] _ in
            router?.goBack()
        }
        
        alertVC.addAction(alertOK)
        present(alertVC, animated: true)
    }
    
    // MARK: IBAction
    @IBAction func goBackClicked(_ sender: UIButton) {
        presenter?.didGoBackClicked()
    }
}

// MARK: ConfigureUI
extension DetailViewController {
    func configureUI(with detail: User) {
        title = detail.fullname        
        [
            "Имя": detail.fullname,
            "Логин": detail.userName,
            "E-Mail": detail.email,
            "Адрес": "\(detail.address?.city ?? "") \(detail.address?.street ?? "") \(detail.address?.suite ?? "") \(detail.address?.zipCode ?? "")",
            "Телефон": detail.phone,
            "Сайт": detail.website,
            "Компания": detail.company?.name,
            "Слоган компании": detail.company?.catchPhrase,
            "BS": detail.company?.someBS
        ].forEach { makeUILabel(item: $0) }
    }
    
    func makeUILabel(item: (key: String, value: String?)) {
        guard let value = item.value else { return }
        let title = item.key
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "\(title): \(value)"
        userDetailStackView.addArrangedSubview(label)
    }
}
