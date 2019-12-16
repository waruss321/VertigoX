//
//  BaseViewController.swift
//  RussTools
//
//  Created by Russell Warwick on 20/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//
import UIKit

public protocol ViewControllerTemplate: ViewTemplate {
    func fetchRequests() //Any API/Network calls
}

public extension ViewControllerTemplate where Self: UIViewController {
    func run(frame: CGRect){
        configureView()
        setConstraints(frame: frame)
        styleView()
        
        fetchRequests()
        
        bindViewModel()
        bindViewModelSignals()
        bindSignals()
    }
}

open class ViewController: UIViewController, ViewControllerTemplate {
    
    public init(xibName: String? = nil, bundle: Bundle? = nil) {
        super.init(nibName: xibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //View did load should no longer be used. Please use viewLoaded instead
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        run(frame: view.frame)
    }
    
    open func configureView(){}
    open func setConstraints(frame: CGRect){}
    open func styleView(){}
    
    open func fetchRequests(){}
    
    open func bindViewModel(){}
    open func bindViewModelSignals(){}
    open func bindSignals(){}
}

public extension UIViewController {
    static var nib : UINib { return UINib(nibName: identifier, bundle: nil) }
    static var identifier: String { return String(describing: self) }
}
