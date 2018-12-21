//
//  TableViewController.swift
//  UIAutomationDemo
//
//  Created by ty0x2333 on 2018/12/21.
//  Copyright © 2018 ty0x2333. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let datas: [(title: String, type: UIViewController.Type)] = [
        (title: "Simple", type: SimpleViewController.self),
        (title: "Special", type: SpecialViewController.self)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Bundle.main.infoDictionary?["CFBundleName"] as? String
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = datas[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(datas[indexPath.row].type.init(), animated: true)
    }
}
