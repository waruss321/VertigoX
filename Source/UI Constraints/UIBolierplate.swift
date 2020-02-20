//
//  UIViewBolierplate.swift
//  VertigoX
//
//  Created by Russell Warwick on 19/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import UIKit

//MARK: - RelationType

open class UILayoutRelations {
    
    let top: RelationType?
    let leading: RelationType?
    let bottom: RelationType?
    let trailing: RelationType?
    
    init(top: RelationType? = nil, leading: RelationType? = nil, bottom: RelationType? = nil, trailing: RelationType? = nil){
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
}

public enum RelationType {
    case equalTo
    case greaterThan
    case lessThan
}

open class UILayoutPrioritys {
    
    let top: UILayoutPriority?
    let leading: UILayoutPriority?
    let bottom: UILayoutPriority?
    let trailing: UILayoutPriority?
    
    init(top: UILayoutPriority? = nil, leading: UILayoutPriority? = nil, bottom: UILayoutPriority? = nil, trailing: UILayoutPriority? = nil){
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }
}

public extension UILayoutPriority {
    
    static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    static func custom(_ value: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: value)
    }
    
    static var notRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 0)
    }
}


//MARK: - UIView

public extension UIView {
    
    //MARK: - Removal of boilerplate + cleaner
    
    func addSubviews(_ views: UIView...) {
        views.reversed().forEach({
            insertSubview($0, at: .zero)
        })
    }
    
    func insertSubviews(_ views: UIView..., below: UIView){
        views.forEach({
            insertSubview($0, belowSubview: below)
        })
    }
    
    func insertSubviews(_ views: UIView..., above: UIView){
        views.forEach({
            insertSubview($0, aboveSubview: above)
        })
    }
    
    //MARK: - Layout

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
    
    static func allSides(_ side: CGFloat) -> UIEdgeInsets {
        return .init(top: side, left: side, bottom: side, right: side)
    }
    
    static func padding(top: CGFloat = .zero, left: CGFloat = .zero, bottom: CGFloat = .zero, right: CGFloat = .zero) -> UIEdgeInsets{
        return .init(top: top, left: left, bottom: bottom, right: right)
    }
}

public extension CGSize {
    
    static func square(_ v: CGFloat) -> CGSize {
        return .init(width: v, height: v)
    }
    
    static func size(w: CGFloat = .zero, h: CGFloat = .zero) -> CGSize {
        return .init(width: w, height: h)
    }
}

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
    
    func rectCorner() -> UIRectCorner {
        switch self {
            case .layerMinXMinYCorner: return .topLeft
            case .layerMaxXMinYCorner: return .topRight
            case .layerMinXMaxYCorner: return .bottomLeft
            case .layerMaxXMaxYCorner: return .bottomRight
            default: return .allCorners
        }
    }
}

public extension UIView {
    
    func applyRadius(_ radius: CGFloat, corners: CACornerMask){
        if #available(iOS 11, *) {
            layer.cornerRadius = radius
            layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
