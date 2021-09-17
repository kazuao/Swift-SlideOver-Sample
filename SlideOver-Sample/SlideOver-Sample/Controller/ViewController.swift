//
//  ViewController.swift
//  SlideOver-Sample
//
//  Created by k-aoki on 2021/09/16.
//

import UIKit

class ViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        return tableView
    }()

    var model = Model()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
}


// MARK: - Setup
private extension ViewController {

    func setupTableView() {
        view.addSubview(tableView)

        tableView.dragInteractionEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self

        tableView.frame = view.bounds

        navigationItem.rightBarButtonItem = editButtonItem
    }
}
