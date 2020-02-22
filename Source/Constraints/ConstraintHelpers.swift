//
//  UIViewConstraintHelpers.swift
//  IGListDiffKit
//
//  Created by Russell Warwick on 22/02/2020.
//

import UIKit

//MARK: - Fill Helpers

public extension UIView {
    
    //MARK: - Fill to views
    
    func fillSuperview() {
        self.fillSuperview(padding: .zero, usingSafeArea: true)
    }

    func fillSuperview(usingSafeArea: Bool) {
        self.fillSuperview(padding: .zero, usingSafeArea: usingSafeArea)
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero, usingSafeArea: Bool = true) {
        
        guard let superview = superview else { return }

        self.fill(superview, padding: padding, usingSafeArea: usingSafeArea)
    }
    
    func fill(_ view: UIView, padding: UIEdgeInsets = .zero, usingSafeArea: Bool = true) {
        
        let topAnchor = (usingSafeArea) ? view.topSafe : view.top
        let leadingAnchor = (usingSafeArea) ? view.leadingSafe : view.leading
        let bottomAnchor = (usingSafeArea) ? view.bottomSafe : view.bottom
        let trailingAnchor = (usingSafeArea) ? view.trailingSafe : view.trailing
        
        self.pin(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                 padding: padding)
    }
    
}
 
//MARK: - Pin Helpers

public extension UIView {
    
    func pin(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            pinTop(top, padding: padding.top)
        }
        
        if let leading = leading {
            pinLeading(leading, padding: padding.left)
        }
        
        if let bottom = bottom {
            pinBottom(bottom, padding: padding.bottom)
        }
        
        if let trailing = trailing {
            pinTrailing(trailing, padding: padding.right)
        }
        
        self.setSize(size)
    }
    
    //MARK: - Superview Pin Helpers (Top Bottom, Left Right, TopRight, TopLeft, BottomRight, BottomLeft)
    
    func pinSuperviewTopBottom(top: CGFloat = .zero, bottom: CGFloat = .zero, size: CGSize = .zero){
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        pinTop(superview.top, padding: top)
        
        pinBottom(superview.bottom, padding: bottom)
        
        self.setSize(size)
    }
    
    func pinSuperviewLeadingTrailing(leading: CGFloat = .zero, trailing: CGFloat = .zero, size: CGSize = .zero){
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        pinLeading(superview.leading, padding: leading)
        
        pinTrailing(superview.trailing, padding: trailing)
        
        self.setSize(size)
    }
    
    func pinSuperviewTopLeading(top: CGFloat = .zero, leading: CGFloat = .zero, size: CGSize = .zero){
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        pinTop(superview.top, padding: top)
                
        pinLeading(superview.leading, padding: leading)
        
        self.setSize(size)
    }
    
    func pinSuperviewTopTrailing(top: CGFloat = .zero, trailing: CGFloat = .zero, size: CGSize = .zero){
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        pinTop(superview.top, padding: top)
                
        pinTrailing(superview.trailing, padding: trailing)
        
        self.setSize(size)
    }
    
    func pinSuperviewBottomLeading(bottom: CGFloat = .zero, leading: CGFloat = .zero, size: CGSize = .zero){
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        pinBottom(superview.bottom, padding: bottom)
                
        pinLeading(superview.leading, padding: leading)
        
        self.setSize(size)
    }
    
    func pinSuperviewBottomTrailing(bottom: CGFloat = .zero, trailing: CGFloat = .zero, size: CGSize = .zero){
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        pinBottom(superview.bottom, padding: bottom)
                
        pinTrailing(superview.trailing, padding: trailing)
        
        self.setSize(size)
    }
}
