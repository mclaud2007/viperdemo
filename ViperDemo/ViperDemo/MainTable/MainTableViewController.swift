//
//  MainTableViewController.swift
//  ViperDemo
//
//  Created by Григорий Мартюшин on 15.01.2021.
//

import UIKit

class MainTableViewController: UIViewController, MainTableViewInput {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainTableViewOutput?
    internal var users: [User]?
    private let cellID = "MainTableViewCell"
    
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.didViewReady()
    }
    
    // MARK: - Method's
    func usersListChanged() {
        tableView.reloadData()
    }
    
    func usersNotLoaded(_ error: Error?) {
        tableView.reloadData()
        
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось загрузить список пользователей", preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertOK)
        
        present(alert, animated: true)
    }
}

private extension MainTableViewController {
    func configureUI() {
        title = "User list"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellID, bundle: nil),
                           forCellReuseIdentifier: cellID)
    }
}

// MARK: - UITableViewDataSource
extension MainTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MainTableViewCell else {
            preconditionFailure()
        }
        
        cell.configure(with: users?[indexPath.row])
        return cell
    }
}

extension MainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectUser(users?[indexPath.row])
    }
}
