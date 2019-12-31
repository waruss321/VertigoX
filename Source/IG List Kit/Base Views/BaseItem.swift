//
//  ListItem.swift
//  RussTools
//
//  Created by Russell Warwick on 21/10/2019.
//  Copyright © 2019 Russell Warwick. All rights reserved.
//

import IGListKit

public protocol ItemTemplate {
    var cellType: AnyClass { get }
}

public protocol VerticalItem: ItemTemplate {
    var cellHeight: CGFloat { get }
    var showSeporator: Bool { get }
}
 
public extension VerticalItem {
    var cellHeight: CGFloat {
        return .zero
    }
    var showSeporator: Bool {
        return false
    }
}

//MARK: - Base Cell

open class BaseVerticalItemCell: UICollectionViewCell, ViewTemplate {
    
    public var item: VerticalItem?
    
    open func configure(withItem item: VerticalItem, controller: BaseSectionController, itemPosition: ItemCellPosition){
        self.item = item
        width.constant = (controller.collectionContext?.insetContainerSize.width ?? 375) - controller.margin
        styleSectionCells(itemPosition: itemPosition, controller: controller, item: item)
        bindViewModel()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        width.constant = bounds.size.width
        contentView.fillSuperview() //This needs to happen otherwise the cell will not adjust to auto size
        run(frame: frame)
    }
    
    private lazy var width: NSLayoutConstraint = {
        let constraint = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        constraint.priority = .almostRequired
        constraint.isActive = true
        return constraint
    }()
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
    open func configureView(){}
    open func setConstraints(frame: CGRect){}
    open func styleView(){}
    open func fetchRequests(){}
    open func bindViewModel(){}
    open func bindViewModelSignals() {}
    open func bindSignals(){}
}

public extension BaseVerticalItemCell {
       
    private func styleSectionCells(itemPosition: ItemCellPosition, controller: BaseSectionController, item: VerticalItem) {
      
        removeShadows()
        removeSeporators()
        contentView.applyRadius(.zero, corners: [.all])

        let opacity: Float = controller.shadowOpacity
        let cornerRadius: CGFloat = controller.cornerRadius
        let doesNeedShadowViews: Bool = opacity != 0.0 || cornerRadius != 0.0

        switch itemPosition {
        case .firstItem:
             
            if item.showSeporator && controller.seporatorColor != .clear {
                let seporatorView = SeporatorView(color: controller.seporatorColor)
                contentView.addSubview(seporatorView)
                seporatorView.pin(leading: contentView.leading, bottom: contentView.bottom, trailing: contentView.trailing, size: CGSize(h: 1.25))
            }
            
            guard doesNeedShadowViews else { return }
            
            contentView.applyRadius(cornerRadius, corners: [.topLeft, .topRight])
            
            let topRightView = CollectionShadowView(offset: CGSize(w: 1, h: -1), opacity: opacity * 0.6, cornerRadius: cornerRadius, corners: .topRight)
            let topLeftView = CollectionShadowView(offset: CGSize(w: -1, h: -1), opacity: opacity * 0.6, cornerRadius: cornerRadius, corners: .topLeft)

            let left = CollectionShadowView(offset: CGSize(w: -1), opacity: opacity, bounds: CGRect(w: -1, h: 2))
            let right = CollectionShadowView(offset: CGSize(w: 1), opacity: opacity, bounds: CGRect(w: 1, h: 2))
            
            insertSubviews(left, right, below: contentView)
                        
            left.pin(leading: leading, bottom: bottom, padding: UIEdgeInsets(left: 1), size: CGSize(w: 1, h: 2))
            right.pin(bottom: bottom, trailing: trailing, size: CGSize(w: 1, h: 2))
            
            insertSubviews(topRightView, topLeftView, below: contentView)

            topRightView.pin(top: top, bottom: bottom, trailing: trailing)
            topRightView.setWidthTo(contentView.widthAnchor, multiplier: 0.503)
            
            topLeftView.pin(top: top, leading: leading, bottom: bottom)
            topLeftView.setWidthTo(contentView.widthAnchor, multiplier: 0.503)

        case .middleItem:
            
            if item.showSeporator && controller.seporatorColor != .clear {
                let seporatorView = SeporatorView(color: controller.seporatorColor)
                contentView.addSubview(seporatorView)
                seporatorView.pin(leading: contentView.leading, bottom: contentView.bottom, trailing: contentView.trailing, size: CGSize(h: 1.25))
            }
            
            guard doesNeedShadowViews else { return }
            
            contentView.applyRadius(.zero, corners: [.all])

            let left = CollectionShadowView(offset: CGSize(w: -1), opacity: opacity)
            let right = CollectionShadowView(offset: CGSize(w: 1), opacity: opacity)

            insertSubviews(left, right, below: contentView)
                        
            left.pin(top: top, leading: leading, bottom: bottom, size: CGSize(w: 1))
            
            right.pin(top: top, bottom: bottom, trailing: trailing, size: CGSize(w: 1))
        
        case .lastItem:
            guard doesNeedShadowViews else { return }
            
            contentView.applyRadius(cornerRadius, corners: [.bottomLeft, .bottomRight])
            
            let bottomRightView = CollectionShadowView(offset: CGSize(w: 1, h: 1), opacity: opacity * 0.6, cornerRadius: cornerRadius, corners: .bottomRight)
            let bottomLeftView = CollectionShadowView(offset: CGSize(w: -1, h: 1), opacity: opacity * 0.6, cornerRadius: cornerRadius, corners: .bottomLeft)
            
            insertSubviews(bottomRightView, bottomLeftView, below: contentView)

            bottomRightView.pin(top: top, bottom: bottom, trailing: trailing, padding: UIEdgeInsets(top: 0, bottom: -1))
            bottomRightView.setWidthTo(contentView.widthAnchor, multiplier: 0.503)
            
            bottomLeftView.pin(top: top, leading: leading, bottom: bottom, padding: UIEdgeInsets(top: 0, bottom: -1))
            bottomLeftView.setWidthTo(contentView.widthAnchor, multiplier: 0.503)
            
        case .onlyItem:
            guard doesNeedShadowViews else { return }
            contentView.applyRadius(cornerRadius, corners: [.all])

            let shadowView = CollectionShadowView(offset: CGSize(), opacity: opacity, radius: 2.0, bounds: CGRect(w: width.constant, h: contentView.frame.height), cornerRadius: cornerRadius)
            insertSubviews(shadowView, below: contentView)
            shadowView.fillSuperview()
        }
    }
    
    private func removeShadows(){
        for view in self.subviews {
            if let shadow = view as? CollectionShadowView { shadow.removeFromSuperview() }
        }
    }
    
    private func removeSeporators(){
        for view in contentView.subviews {
            if let seporator = view as? SeporatorView {
                seporator.removeFromSuperview()
            }
        }
    }
}

internal class SeporatorView: UIView { }

internal class CollectionShadowView: UIView {
    
    init(offset: CGSize, opacity: Float = 0.3, radius: CGFloat = 1.0, backgroundColor: UIColor = .white, shadowColor: UIColor = .black, bounds: CGRect? = nil, cornerRadius: CGFloat = .zero, corners: CACornerMask = .all) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = true
        
        if let bounds = bounds {
            if cornerRadius != .zero {
                self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            } else {
                self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            }
        }
        self.applyRadius(cornerRadius, corners: [corners])
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
