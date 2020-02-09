//
//  ItemDetailsVC.swift
//  VertigoX_Example
//
//  Created by Russell Warwick on 28/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import VertigoX
import Signals
import PanModal

protocol ItemDetailsModule: BaseSheetModule {
    var newPage: VoidSignal { get }
}

class ItemDetailsVC: ViewController, ItemDetailsModule {
    
    //MARK: - BaseSheetModule

    var sheetDidDismiss = VoidSignal()
    
    //MARK: -
    
    var newPage = VoidSignal()
    
    var loggedIn = VoidSignal()

    let testView = UIView(color: .red)
    
    let testButton = UIButton(backgroundColor: .clear)
    
    override func viewDidLoad() {
        view.addSubviews(testView, testButton)
        testView.fillSuperview(safe: false)
        testButton.fill(testView)

        testButton.onTouchUpInside.subscribe(with: self) { _ in
            self.newPage.fire(())
        }
    }
    
    
    func panModalDidDismiss() {
        sheetDidDismiss.fire(())
    }
    
    override func styleView() {
        view.backgroundColor = .white
    }
    
    
    var panScrollable: UIScrollView? {
        return nil
    }

    var topOffset: CGFloat {
        return 0
    }

    var springDamping: CGFloat {
        return 1.0
    }

    var transitionDuration: Double {
        return 0.4
    }

    var transitionAnimationOptions: UIView.AnimationOptions {
        return [.allowUserInteraction, .beginFromCurrentState]
    }

    var shouldRoundTopCorners: Bool {
        return false
    }

    var showDragIndicator: Bool {
        return false
    }
  
}
