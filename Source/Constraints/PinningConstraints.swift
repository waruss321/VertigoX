//
//  UIViewConstraints2.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 22/02/2020.
//

import UIKit

//MARK: - Top, leading, bottom & trailing helpers

public extension UIView {

    //MARK: - Pin Top
    
    @discardableResult
    func pinTop(_ anchor: NSLayoutYAxisAnchor, padding: CGFloat, relation: ConstraintRelation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint = topAnchor.constraint(equalTo: anchor, constant: padding)
        
        switch relation {
        case .equalOrGreater:
            constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: padding)
        case .equalOrLess:
            constraint = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: padding)
        default: break
        }
        
        constraint.priority = priority
        constraint.isActive = true

        return constraint
    }

    //MARK: - Pin Leading
    
    @discardableResult
    func pinLeading(_ anchor: NSLayoutXAxisAnchor, padding: CGFloat, relation: ConstraintRelation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint = leadingAnchor.constraint(equalTo: anchor, constant: padding)
        
        switch relation {
        case .equalOrGreater:
            constraint = leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: padding)
        case .equalOrLess:
            constraint = leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: padding)
        default: break
        }
        
        constraint.priority = priority
        constraint.isActive = true

        return constraint
    }
    
    //MARK: - Pin Bottom
    
    @discardableResult
    func pinBottom(_ anchor: NSLayoutYAxisAnchor, padding: CGFloat, relation: ConstraintRelation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let padding = -padding //Adjusted

        var constraint: NSLayoutConstraint = bottomAnchor.constraint(equalTo: anchor, constant: padding)
        
        //.equalOrGreater & .equalOrLess have been switch intentionally
        
        switch relation {
        case .equalOrGreater:
            constraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: padding)
        case .equalOrLess:
            constraint = bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: padding)
        default: break
        }
        
        constraint.priority = priority
        constraint.isActive = true

        return constraint
    }
    
    //MARK: - Pin Trailing
    
    @discardableResult
    func pinTrailing(_ anchor: NSLayoutXAxisAnchor, padding: CGFloat, relation: ConstraintRelation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let padding = -padding //Adjusted

        var constraint: NSLayoutConstraint = trailingAnchor.constraint(equalTo: anchor, constant: padding)
        
        //.equalOrGreater & .equalOrLess have been switch intentionally
        
        switch relation {
        case .equalOrGreater:
            constraint = trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: padding)
        case .equalOrLess:
            constraint = trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: padding)
        default: break
        }
        
        constraint.priority = priority
        constraint.isActive = true

        return constraint
    }
}
