//
//  SizeConstraints.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 22/02/2020.
//

import UIKit

//MARK: - Width & Height Helpers

public extension UIView {
    
    func setSize(_ size: CGSize, priority: UILayoutPriority = .required) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if size.width != .zero {
            setWidth(size.width, priority: priority)
        }
        
        if size.height != .zero {
            setHeight(size.height, priority: priority)
        }
    }
    
    @discardableResult
    func setWidth(_ height: CGFloat, relation: ConstraintRelation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
                
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint = widthAnchor.constraint(equalToConstant: height)
        
        switch relation {
        case .equalOrGreater:
            constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: height)
        case .equalOrLess:
            constraint = widthAnchor.constraint(lessThanOrEqualToConstant: height)
        default: break
        }
        
        constraint.priority = priority
        constraint.isActive = true

        return constraint
    }
    
    @discardableResult
    func setHeight(_ height: CGFloat, relation: ConstraintRelation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
                
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        
        switch relation {
        case .equalOrGreater:
            constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        case .equalOrLess:
            constraint = heightAnchor.constraint(lessThanOrEqualToConstant: height)
        default: break
        }
        
        constraint.priority = priority
        constraint.isActive = true

        return constraint
    }
    
    @discardableResult
    func equalWidth(_ view: UIView, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)

        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func equalHeight(_ view: UIView, multiplier: CGFloat = 1.0, priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)

        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
    
    //MARK: - Aspect Ratio
    
    @discardableResult
    func setAspectRatio(width: CGFloat, height: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: height/width, constant: 0)
    
        constraint.priority = priority
        constraint.isActive = true
        
        return constraint
    }
}
