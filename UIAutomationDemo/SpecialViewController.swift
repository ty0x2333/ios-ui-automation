//
//  SpecialViewController.swift
//  UIAutomationDemo
//
//  Created by ty0x2333 on 2018/12/21.
//  Copyright © 2018 ty0x2333. All rights reserved.
//

import UIKit

class SpecialViewController: UIViewController {
    private let rectView: UIView = UIView()
    private let searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Special"
        view.backgroundColor = UIColor.white
        rectView.backgroundColor = UIColor.blue
        view.addSubview(rectView)
        
        view.addSubview(searchBar)
        if UITestUtils.isTesting {
            for sv in searchBar.subviews {
                for ssv in (sv.subviews.filter { $0 is UITextField }) {
                    ssv.tintColor = UIColor.clear
                }
            }
        }
    
        rectView.frame = CGRect(x: (view.bounds.width - 100) / 2.0,
                                y: (view.bounds.height - 100) / 2.0,
                                width: 100,
                                height: 100)
        if !UITestUtils.isTesting {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.`repeat`], animations: {
                self.rectView.frame = CGRect(x: (self.view.bounds.width - 200) / 2.0,
                                             y: (self.view.bounds.height - 200) / 2.0,
                                             width: 200,
                                             height: 200)
            }, completion: nil)
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 0, y: 200, width: view.bounds.width, height: 50)
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
}
