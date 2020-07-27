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
    func bind() //Bind views (button.onTouchUpInside)
}

public extension ViewTemplate {
    func run(frame: CGRect){
        configureView()
        setConstraints(frame: frame)
        styleView()
                
        bindViewModel()
        bind()
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
    open func bindViewModel(){}
    open func bind(){}
}
