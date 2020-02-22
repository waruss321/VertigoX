//
//  UIViewBolierplate.swift
//  VertigoX
//
//  Created by Russell Warwick on 19/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

//MARK: - ConstraintRelation

public enum ConstraintRelation {
    case equal
    case equalOrLess
    case equalOrGreater
}

//MARK: - Layout

public extension UILayoutPriority {
    
    static var almost: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    static func custom(_ value: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: value)
    }
}

//MARK: - Add Subviews

public extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.reversed().forEach({
            insertSubview($0, at: .zero)
        })
    }
    
    func addSubviews(_ views: UIView..., below: UIView){
        views.forEach({
            insertSubview($0, belowSubview: below)
        })
    }
    
    func addSubviews(_ views: UIView..., above: UIView){
        views.forEach({
            insertSubview($0, aboveSubview: above)
        })
    }
}

//MARK: - Anchors

public extension UIView {

    var top: NSLayoutYAxisAnchor {
        return topAnchor
    }
    
    var bottom: NSLayoutYAxisAnchor {
        return bottomAnchor
    }

    var leading: NSLayoutXAxisAnchor {
        return leadingAnchor
    }
    
    var trailing: NSLayoutXAxisAnchor {
        return trailingAnchor
    }
    
    //MARK: - Safe Area
    
    var topSafe: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }
    
    var bottomSafe: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }
    
    var leadingSafe: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }
    
    var trailingSafe: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }
}

//MARK: - UIStackView

public extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...){
        views.forEach({ addArrangedSubview($0) })
    }
    
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        let removedSubviews = arrangedSubviews.reduce([]) { (removedSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
            return removedSubviews + [subview]
        }
        return removedSubviews
    }
}

//MARK: - UIEdgeInsets

public extension UIEdgeInsets {
    
    static func square(_ value: CGFloat) -> UIEdgeInsets {
        return .init(top: value, left: value, bottom: value, right: value)
    }
    
    static func padding(top: CGFloat = .zero, left: CGFloat = .zero, bottom: CGFloat = .zero, right: CGFloat = .zero) -> UIEdgeInsets{
        return .init(top: top, left: left, bottom: bottom, right: right)
    }
}

//MARK: - CGSize
 
public extension CGSize {
    
    static func square(_ value: CGFloat) -> CGSize {
        return .init(width: value, height: value)
    }
    
    static func width(_ value: CGFloat) -> CGSize {
        return .init(width: value, height: .zero)
    }
    
    static func height(_ value: CGFloat) -> CGSize {
        return .init(width: .zero, height: value)
    }
    
    static func size(w: CGFloat = .zero, h: CGFloat = .zero) -> CGSize {
        return .init(width: w, height: h)
    }
}

//MARK: - CGRect

public extension CGRect {
    
    init(x: CGFloat = .zero, y: CGFloat = .zero, w: CGFloat = .zero, h: CGFloat = .zero) {
        self.init(x: x, y: y, width: w, height: h)
    }
    
    init(w: CGFloat = .zero, h: CGFloat = .zero) {
        self.init(x: .zero, y: .zero, width: w, height: h)
    }
    
    init(square: CGFloat) {
        self.init(x: .zero, y: .zero, width: square, height: square)
    }
}

//MARK: - CGPoint

public extension CGPoint {
    
    static func point(x: CGFloat = .zero, y: CGFloat = .zero) -> CGPoint {
        return .init(x: x, y: y)
    }
}

//MARK: - Corner Radius

public extension CACornerMask {
    
    static var topLeft: CACornerMask {
        return .layerMinXMinYCorner
    }
    static var topRight: CACornerMask {
        return .layerMaxXMinYCorner
    }
    static var bottomLeft: CACornerMask {
        return .layerMinXMaxYCorner
    }
    static var bottomRight: CACornerMask {
        return .layerMaxXMaxYCorner
    }
    static var all: CACornerMask {
        return [topLeft, topRight, bottomLeft, bottomRight]
    }
}

public extension UIView {
    
    func setCornerRadius(_ radius: CGFloat, corners: CACornerMask = .all){
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
