//
//  UIViewConstraints.swift
//  VertigoX
//
//  Created by Russell Warwick on 19/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

public extension UIView {
    
    //MARK: - Fill to views

    func fillSuperview(safe: Bool = true) {
        self.fillSuperview(padding: .zero, usingSafeArea: safe)
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero, size: CGSize = .zero, usingSafeArea: Bool = true) {
        
        guard let superview = superview else { return }

        self.fill(superview, padding: padding, size: size, usingSafeArea: usingSafeArea)
    }
    
    func fill(_ view: UIView, padding: UIEdgeInsets = .zero, size: CGSize = .zero, usingSafeArea: Bool = true) {
        
        let topAnchor = (usingSafeArea) ? view.topSafe : view.top
        let leadingAnchor = (usingSafeArea) ? view.leadingSafe : view.leading
        let bottomAnchor = (usingSafeArea) ? view.bottomSafe : view.bottom
        let trailingAnchor = (usingSafeArea) ? view.trailingSafe : view.trailing
        
        self.pin(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: padding, size: size)
    }
    
    //MARK: - Pin View
    
    //MARK : - Pin With Priorty
    
    func pin(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, relations: UILayoutRelations? = nil, prioritys: UILayoutPrioritys? = nil, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            pinTop(top, constant: padding.top, relation: relations?.top, priority: prioritys?.top)
        }
        
        if let leading = leading {
            pinLeading(leading, constant: padding.left, relation: relations?.leading, priority: prioritys?.leading)
        }
        
        if let bottom = bottom {
            pinBottom(bottom, constant: -padding.bottom, relation: relations?.bottom, priority: prioritys?.bottom)
        }
        
        if let trailing = trailing {
            pinTrailing(trailing, constant: -padding.right, relation: relations?.trailing, priority: prioritys?.trailing)
        }
        
        self.size(size)
    }
    
    //MARK: - Pin Top
    
    @discardableResult
    func pinTop(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat, relation: RelationType? = .equalTo, priority: UILayoutPriority? = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint? = topAnchor.constraint(equalTo: anchor, constant: constant)
        
        if let relation = relation {
            switch relation {
                case .equalTo: constraint = topAnchor.constraint(equalTo: anchor, constant: constant)
                case .greaterThan: constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
                case .lessThan: constraint = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        }

        if let priority = priority {
            constraint = constraint?.usingPriority(priority)
        }
        
        constraint?.isActive = true
        
        return constraint
    }
    
    //MARK: - Pin Leading
    
    @discardableResult
    func pinLeading(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat, relation: RelationType? = .equalTo, priority: UILayoutPriority? = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint? = leadingAnchor.constraint(equalTo: anchor, constant: constant)
        
        if let relation = relation {
            switch relation {
                case .equalTo: constraint = leadingAnchor.constraint(equalTo: anchor, constant: constant)
                case .greaterThan: constraint = leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
                case .lessThan: constraint = leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        }

        if let priority = priority {
            constraint = constraint?.usingPriority(priority)
        }
        
        constraint?.isActive = true
        
        return constraint
    }
    
    //MARK: - Pin Bottom
    
    @discardableResult
    func pinBottom(_ anchor: NSLayoutYAxisAnchor, constant: CGFloat, relation: RelationType? = .equalTo, priority: UILayoutPriority? = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint? = bottomAnchor.constraint(equalTo: anchor, constant: constant)
        
        if let relation = relation {
            switch relation {
                case .equalTo: constraint = bottomAnchor.constraint(equalTo: anchor, constant: constant)
                case .greaterThan: constraint = bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
                case .lessThan: constraint = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        }

        if let priority = priority {
            constraint = constraint?.usingPriority(priority)
        }
        
        constraint?.isActive = true
        
        return constraint
    }
    
    //MARK: - Pin Trailing
    
    @discardableResult
    func pinTrailing(_ anchor: NSLayoutXAxisAnchor, constant: CGFloat, relation: RelationType? = .equalTo, priority: UILayoutPriority? = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint? = trailingAnchor.constraint(equalTo: anchor, constant: constant)
        
        if let relation = relation {
            switch relation {
                case .equalTo: constraint = trailingAnchor.constraint(equalTo: anchor, constant: constant)
                case .greaterThan: constraint = trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
                case .lessThan: constraint = trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            }
        }

        if let priority = priority {
            constraint = constraint?.usingPriority(priority)
        }
        
        constraint?.isActive = true
        return constraint
    }

    //MARK: - Center Views
    
    func centerTo(_ view: UIView, offset: CGPoint = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXTo(view, offset: offset.x)
        centerYTo(view, offset: offset.y)

        self.size(size)
    }
    
    @discardableResult
    func centerXTo(_ view: UIView, offset: CGFloat = .zero, size: CGSize = .zero) -> NSLayoutConstraint? {
    
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset)
        constraint.isActive = true
        
        self.size(size)
        
        return constraint
    }
    
    @discardableResult
    func centerYTo(_ view: UIView, offset: CGFloat = .zero, size: CGSize = .zero) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset)
        constraint.isActive = true
        
        self.size(size)
        
        return constraint
    }

    //MARK: - CGSize
    
    @discardableResult
    func height(_ height: CGFloat, relation: RelationType = .equalTo, priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint?
        
        switch relation {
            case .equalTo: constraint = heightAnchor.constraint(equalToConstant: height)
            case .greaterThan: constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
            case .lessThan: constraint = heightAnchor.constraint(lessThanOrEqualToConstant: height)
        }
        
        constraint?.priority = priority
        constraint?.isActive = true
        return constraint
    }
    
    @discardableResult
    func width(_ width: CGFloat, relation: RelationType = .equalTo, priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraint: NSLayoutConstraint?
        
        switch relation {
            case .equalTo: constraint = widthAnchor.constraint(equalToConstant: width)
            case .greaterThan: constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
            case .lessThan: constraint = widthAnchor.constraint(lessThanOrEqualToConstant: width)
        }
        
        constraint?.priority = priority
        constraint?.isActive = true
        return constraint
    }
    
    func size(_ size: CGSize, priority: UILayoutPriority = .required) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if size.width != .zero {
            width(size.width, priority: priority)
        }
        
        if size.height != .zero {
            height(size.height, priority: priority)
        }
    }
    
    @discardableResult
    func setWidthTo(_ layoutDiminesion: NSLayoutDimension, multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint? = widthAnchor.constraint(equalTo: layoutDiminesion, multiplier: multiplier)
        
        constraint?.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func setHeightTo(_ layoutDiminesion: NSLayoutDimension, multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraint: NSLayoutConstraint? = heightAnchor.constraint(equalTo: layoutDiminesion, multiplier: multiplier)
        
        constraint?.isActive = true
        
        return constraint
    }
    
    //MARK: - Aspect Ratio
       
    func applyAspectRatio(width: CGFloat, height: CGFloat){
       translatesAutoresizingMaskIntoConstraints = false
       addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: height/width, constant: 0))
    }
    
    func updateConstraint(constraint: NSLayoutConstraint, constant: CGFloat, priority: UILayoutPriority = .required){
        translatesAutoresizingMaskIntoConstraints = false
        constraint.priority = priority
        constraint.constant = constant
        constraint.isActive = true
        layoutIfNeeded()
    }
}

public extension UIView {
    func removeAllConstraints() {
        var _superview = self.superview

        while let superview = _superview {
            for constraint in superview.constraints {

                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}

public extension NSLayoutConstraint {
    func usingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
