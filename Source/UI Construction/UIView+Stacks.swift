//
//  UIView+Stacks.swift
//  VertigoX
//
//  Created by Russell Warwick on 05/02/2020.
//

import UIKit

public extension UIView {
    
    fileprivate func _stack(_ axis: NSLayoutConstraint.Axis = .vertical, views: [UIView], spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, usingSafeArea: Bool = true) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        addSubview(stackView)
        stackView.fillSuperview(usingSafeArea: usingSafeArea) //If top/bottom alignmnet is werid true changing 'toSafe'
        return stackView
    }
    
    @discardableResult
    func stack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill, usingSafeArea: Bool = true) -> UIStackView {
        return _stack(.vertical, views: views, spacing: spacing, alignment: alignment, distribution: distribution, usingSafeArea: usingSafeArea)
    }
    
    @discardableResult
    func hstack(_ views: UIView..., spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        return _stack(.horizontal, views: views, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    @discardableResult
    func size<T: UIView>(square: CGFloat) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: square).isActive = true
        heightAnchor.constraint(equalToConstant: square).isActive = true
        return self as! T
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func withBorder(width: CGFloat, color: UIColor) -> UIView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
}

public extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis = .vertical, spacing: CGFloat = .zero, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) {
        self.init(frame: .zero)
        self.axis = .vertical
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    @discardableResult
    func margin(top: CGFloat = .zero, left: CGFloat = .zero, bottom: CGFloat = .zero, right: CGFloat = .zero) -> UIStackView {
        let margins = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    func margin(square: CGFloat) -> UIStackView {
        let margins = UIEdgeInsets(top: square, left: square, bottom: square, right: square)
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true
        return self
    }
    
    @discardableResult
    func padLeft(_ left: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = left
        return self
    }
    
    @discardableResult
    func padTop(_ top: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = top
        return self
    }
    
    @discardableResult
    func padBottom(_ bottom: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = bottom
        return self
    }
    
    @discardableResult
    func padRight(_ right: CGFloat) -> UIStackView {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = right
        return self
    }
}
