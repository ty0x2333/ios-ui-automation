//
//  SimpleViewController.swift
//  UIAutomationDemo
//
//  Created by luckytianyiyan on 2018/12/18.
//  Copyright © 2018 luckytianyiyan. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {
    private let label = UILabel()
    private let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Bundle.main.infoDictionary?["CFBundleName"] as? String
        
        label.text = "Hello World"
        label.textAlignment = .center
        view.addSubview(label)
        
        button.setTitle("rotate", for: .normal)
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let itemMaxSize = CGSize(width: view.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        
        let labelSize = label.sizeThatFits(itemMaxSize)
        label.frame = CGRect(x: 0, y: (view.bounds.height - labelSize.height) / 2.0, width: view.bounds.width, height: labelSize.height)
        
        let buttonSize = button.sizeThatFits(itemMaxSize)
        button.frame = CGRect(x: (view.bounds.width - buttonSize.width) / 2.0, y: label.frame.maxY + 20.0, width: buttonSize.width, height: buttonSize.height)
    }
    
    @objc private func onClick() {
        label.transform = label.transform.rotated(by: CGFloat.pi / 2.0)
    }
}
