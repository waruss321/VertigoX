//
//  BaseViewController.swift
//  VertigoX
//
//  Created by Russell Warwick on 20/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//
import UIKit

public protocol ViewControllerTemplate {
    func run(frame: CGRect) //Run all the functions below in specific order. Should be done on viewDidLoad
        
    func configureView() //Setting up of properties e.g setting delegates
    func setConstraints(frame: CGRect) //Set programatic constraints
    func styleView() //Setting styling e.g background colors

    func bindViewModel() //Bind values from view model to the view (nameLabel.text=viewModel.name)

    func bind() //Bind views (button.onTouchUpInside.subscribe)
    func fetchRequests() //Any API/Network calls
    func setView() -> UIView
}

public extension ViewControllerTemplate where Self: UIViewController {
    func run(frame: CGRect){
        setConstraints(frame: frame)
        styleView()
        configureView()
        
        fetchRequests()
        bindViewModel()
        bind()
    }
}

open class ViewController: UIViewController, ViewControllerTemplate {
    
    public init(xibName: String? = nil, bundle: Bundle? = nil) {
        super.init(nibName: xibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //View did load should no longer be used. Please use viewLoaded instead
    
    open override func loadView() {
        super.loadView()
        view = setView()
        run(frame: view.frame)
    }
    
    open func setView() -> UIView {
        return UIView(backgroundColor: .white)
    }
    
    open func setConstraints(frame: CGRect){ }
    open func styleView(){}
    open func configureView(){}
    
    open func fetchRequests(){}
    
    open func bindViewModel(){}
    open func bind(){}
}

public extension UIViewController {
    static var nib : UINib { return UINib(nibName: identifier, bundle: nil) }
    static var identifier: String { return String(describing: self) }
}
