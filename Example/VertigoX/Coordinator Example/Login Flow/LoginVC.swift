//
//  LoginVC.swift
//  RussTools
//
//  Created by Russell Warwick on 15/12/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import VertigoX

protocol LoginModule: BaseModule {
    var loggedIn: VoidSignal { get }
}

class LoginVC: ViewController, LoginModule {
    
    //MARK: - Signals
    
    var loggedIn = VoidSignal()
    
    //MARK: - Properties
    
    private let testLabel = UILabel(text: "Welcome to my App", font: UIFont.boldSystemFont(ofSize: 18), alignment: .center)
    private let loginButton = UIButton(text: "LOGIN")
    private let testView = TestView(test: "this is a test")
    //MARK: - Main View
    
//    override func setConstraints(frame: CGRect) {
//        view.addSubviews(testLabel, loginButton, testView)
//        testLabel.pin(top: view.topSafe, leading: view.leading, trailing: view.trailing,
//                      padding: .square(30))
//        
//        loginButton.pin(leading: view.leading, bottom: view.bottom, trailing: view.trailing,
//                        padding: .padding(left: 40, bottom: 100, right: 40),
//                        size: .size(h: 60))
//        
//        testView.pin(leading: view.leading, size: .size(w: 120, h: 100))
//        testView.centerY(view)
//    }
//    
    //MARK: - Bind
    
    override func bindSignals() {
        loginButton.onTouchUpInside.subscribe(with: self) { [weak self] _ in
            self?.loggedIn.fire(())
        }
    }
}


class TestView: View {
    
    var testLabel = UILabel()
    
    private let test: String
    
    init(test: String){
        self.test = test
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setConstraints(frame: CGRect) {
        addSubview(testLabel)
        testLabel.fillSuperview(padding: .padding(top: 20, left: 10))
        testLabel.text = test
    }
}
