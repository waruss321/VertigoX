//
//  UIViewConstruction.swift
//  VertigoX
//
//  Created by Russell Warwick on 09/09/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

public protocol ViewTemplate {
    
    func run(frame: CGRect) //Run all the functions below in specific order. Should be done on viewDidLoad
        
    func configureView() //Setting up of properties e.g setting delegates
    func setConstraints(frame: CGRect) //Set programatic constraints
    func styleView() //Setting styling e.g background colors
        
    func bindViewModel() //Bind values from view model to the view (nameLabel.text=viewModel.name)
    func bindViewModelSignals() //Bind signals from view model to view (viewModel.dataFetched.subscribe..)
    func bindSignals() //Bind views signals (button.onTouchUpInside.subscribe)
}

public extension ViewTemplate {
    func run(frame: CGRect){
        configureView()
        setConstraints(frame: frame)
        styleView()
                
        bindViewModel()
        bindViewModelSignals()
        bindSignals()
    }
}

open class View: UIView, ViewTemplate {
    
    public init(){
        super.init(frame: .zero)
        run(frame: .zero)
    }

    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
    open func configureView(){}
    open func setConstraints(frame: CGRect){}
    open func styleView(){}
    open func fetchRequests(){}
    open func bindViewModel(){}
    open func bindViewModelSignals() {}
    open func bindSignals(){}
}
