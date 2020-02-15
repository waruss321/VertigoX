//
//  VeritcalItem.swift
//  VertigoX
//
//  Created by Russell Warwick on 25/01/2020.
//

import UIKit

public protocol VerticalItem: Item {
    //Might add some stuff here. Also might add a Horizontal Item
}

open class VerticalCell: UICollectionViewCell, ViewTemplate {
    //MARK: - Public
    
    public var item: VerticalItem? {
        didSet {
            bindViewModel()
        }
    }
    
    public var cellWidth: CGFloat? = nil {
        didSet {
            guard let cellWidth = cellWidth else { return }
            widthConstraint.isActive = true
            widthConstraint.constant = cellWidth
        }
    }

    //MARK: - Properties
    
    private lazy var widthConstraint: NSLayoutConstraint = {
        let constraint = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        constraint.isActive = false
        return constraint
    }()
    
    //MARK: - Configure
   
    public override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.fillSuperview() //This needs to happen otherwise the cell will not adjust to auto size
        run(frame: frame)
    }

    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
    open func configureView(){}
    open func setConstraints(frame: CGRect){}
    open func styleView(){}

    open func bindViewModel() {}
    open func bindViewModelSignals() {}
    open func bindSignals(){}
}

internal extension VerticalCell {
       
    func styleSectionCell(item: VerticalItem, controller: SectionController, position: ItemCellPosition) {
      
        removeShadows()
        removeSeporators()
        contentView.applyRadius(.zero, corners: [.all])

        let opacity: Float = controller.shadowOpacity
        let cornerRadius: CGFloat = controller.cornerRadius
        let doesNeedShadowViews: Bool = opacity != 0.0

        switch position {
        case .firstItem:

            if controller.showSeporator && controller.seporatorColor != .clear {
                let seporatorView = SeporatorView(backgroundColor: controller.seporatorColor)
                contentView.addSubview(seporatorView)
                seporatorView.pin(leading: contentView.leading, bottom: contentView.bottom, trailing: contentView.trailing, size: .size(h: 1.25))
            }
            
            if controller.cornerRadiusOption == CornerOptions.topBottom ||
                controller.cornerRadiusOption == CornerOptions.top {
                contentView.applyRadius(cornerRadius, corners: [.topLeft, .topRight])
            } else {
                contentView.applyRadius(.zero, corners: [.all])
            }
 
            guard doesNeedShadowViews else { return }
 
            let topRightView = CollectionShadowView(offset: .size(w: 1, h: -1), opacity: opacity * 0.6, cornerRadius: cornerRadius, corners: .topRight)
            let topLeftView = CollectionShadowView(offset: .size(w: -1, h: -1), opacity: opacity * 0.6, cornerRadius: cornerRadius, corners: .topLeft)

            let left = CollectionShadowView(offset: .size(w: -1), opacity: opacity, bounds: CGRect(w: -1, h: 2))
            let right = CollectionShadowView(offset: .size(w: 1), opacity: opacity, bounds: CGRect(w: 1, h: 2))
            
            insertSubviews(left, right, below: contentView)
                        
            left.pin(leading: leading, bottom: bottom, padding: .padding(left: 10), size: .size(w: 1, h: 2))
            right.pin(bottom: bottom, trailing: trailing, size: .size(w: 1, h: 2))
            
            insertSubviews(topRightView, topLeftView, below: contentView)

            topRightView.pin(top: top, bottom: bottom, trailing: trailing)
            topRightView.setWidthTo(contentView.widthAnchor, multiplier: 0.503)
            
            topLeftView.pin(top: top, leading: leading, bottom: bottom)
            topLeftView.setWidthTo(contentView.widthAnchor, multiplier: 0.503)

        case .middleItem:
            
            if controller.showSeporator && controller.seporatorColor != .clear {
                let seporatorView = SeporatorView(backgroundColor: controller.seporatorColor)
                contentView.addSubview(seporatorView)
                seporatorView.pin(leading: contentView.leading, bottom: contentView.bottom, trailing: contentView.trailing, size: .size(h: 1.25))
            }
            
            contentView.applyRadius(.zero, corners: [.all])
            
            guard doesNeedShadowViews else { return }

            let left = CollectionShadowView(offset: .size(w: -1), opacity: opacity)
            let right = CollectionShadowView(offset: .size(w: 1), opacity: opacity)

            insertSubviews(left, right, below: contentView)
                        
            left.pin(top: top, leading: leading, bottom: bottom, size: .size(w: 1))
            
            right.pin(top: top, bottom: bottom, trailing: trailing, size: .size(w: 1))
        
        case .lastItem:
            
            if controller.cornerRadiusOption == CornerOptions.topBottom ||
                controller.cornerRadiusOption == CornerOptions.bottom {
                contentView.applyRadius(cornerRadius, corners: [.bottomLeft, .bottomRight])
            } else {
                contentView.applyRadius(.zero, corners: [.all])
            }
                        
            guard doesNeedShadowViews else { return }

            let bottomRightView = CollectionShadowView(offset: .size(w: 1, h: 1), opacity: opacity * 0.6, cornerRadius: cornerRadius, corners: .bottomRight)
            let bottomLeftView = CollectionShadowView(offset: .size(w: -1, h: 1), opacity: opacity * 0.6, cornerRadius: cornerRadius, corners: .bottomLeft)
            
            insertSubviews(bottomRightView, bottomLeftView, below: contentView)

            bottomRightView.pin(top: top, bottom: bottom, trailing: trailing, padding: .padding(top: 0, bottom: -1))
            bottomRightView.setWidthTo(contentView.widthAnchor, multiplier: 0.503)
            
            bottomLeftView.pin(top: top, leading: leading, bottom: bottom, padding: .padding(top: 0, bottom: -1))
            bottomLeftView.setWidthTo(contentView.widthAnchor, multiplier: 0.503)
            
        case .onlyItem:
            
            if controller.cornerRadiusOption == CornerOptions.topBottom {
                contentView.applyRadius(cornerRadius, corners: [.all])
            } else if controller.cornerRadiusOption == CornerOptions.top {
                contentView.applyRadius(cornerRadius, corners: [.topLeft, .topRight])
            } else if controller.cornerRadiusOption == CornerOptions.topBottom {
                contentView.applyRadius(cornerRadius, corners: [.bottomLeft, .bottomRight])
            }
            
            contentView.applyRadius(cornerRadius, corners: [.all])
            
            guard doesNeedShadowViews else { return }
            
            let shadowView = CollectionShadowView(offset: CGSize(), opacity: opacity, radius: 1.5, cornerRadius: cornerRadius)
            
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
