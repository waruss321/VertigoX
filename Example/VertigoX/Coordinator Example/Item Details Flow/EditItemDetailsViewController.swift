//
//  EditDetailsVC.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 03/02/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals

protocol EditItemDetailsModule: BaseModule {
    
}

class EditItemDetailsViewController: ViewController, EditItemDetailsModule {

    let button: UIButton = {
        let label = UIButton()
        label.setTitle("back", for: .normal)
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Full Screen"
        view.backgroundColor = .blue
        setupConstraints()
    }

    private func setupConstraints() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }

}
