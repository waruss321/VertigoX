//
//  AlignmentConstraints.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 22/02/2020.
//

import UIKit

//MARK: - Alignment helpers

public extension UIView {
    
    //MARK: - Center Views
    
    func center(_ view: UIView, offset: CGPoint = .zero, priority: UILayoutPriority = .required) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        centerX(view, offset: offset.x, priority: priority)
        centerY(view, offset: offset.y, priority: priority)
    }
    
    @discardableResult
    func centerX(_ view: UIView, offset: CGFloat = .zero, priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
    
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset)
        
        constraint.priority = priority
        constraint.isActive = true
                
        return constraint
    }
    
    @discardableResult
    func centerY(_ view: UIView, offset: CGFloat = .zero, priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset)
        
        constraint.priority = priority
        constraint.isActive = true
                
        return constraint
    }
}

public extension UIView {
    
    func setHugging(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        setContentHuggingPriority(priority, for: axis)
    }
    
    func setCompressionResistance(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        setContentCompressionResistancePriority(priority, for: axis)
    }
}
