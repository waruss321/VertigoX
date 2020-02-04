//
//  PanModalPresentationAnimator.swift
//  PanModal
//
//  Copyright © 2019 Tiny Speck, Inc. All rights reserved.
//

#if os(iOS)
import UIKit

/**
 Handles the animation of the presentedViewController as it is presented or dismissed.

 This is a vertical animation that
 - Animates up from the bottom of the screen
 - Dismisses from the top to the bottom of the screen

 This can be used as a standalone object for transition animation,
 but is primarily used in the PanModalPresentationDelegate for handling pan modal transitions.

 - Note: The presentedViewController can conform to PanModalPresentable to adjust
 it's starting position through manipulating the shortFormHeight
 */

public class PanModalPresentationAnimator: NSObject {

    /**
     Enum representing the possible transition styles
     */
    public enum TransitionStyle {
        case modally
        case push
    }

    // MARK: - Properties

    /**
     The transition style
     */
    private let transitionStyle: TransitionStyle
    private let dismissal: Bool

    /**
     Haptic feedback generator (during presentation)
     */
    private var feedbackGenerator: UISelectionFeedbackGenerator?

    // MARK: - Initializers

    required public init(transitionStyle: TransitionStyle, dismissal: Bool = false) {
        self.transitionStyle = transitionStyle
        self.dismissal = dismissal
        super.init()

        /**
         Prepare haptic feedback, only during the presentation state
         */
        if case .modally = transitionStyle, !dismissal {
            feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator?.prepare()
        }
    }

    /**
     Animate presented view controller presentation
     */
    private func animatePresent(transitionContext: UIViewControllerContextTransitioning) {

        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return }

        let presentable = transitionContext.viewController(forKey: .to) as? PanModalPresentable.LayoutType

        // Calls viewWillAppear and viewWillDisappear
        fromVC.beginAppearanceTransition(false, animated: true)
        
        // Presents the view in shortForm position, initially
        let yPos: CGFloat = presentable?.shortFormYPos ?? 0.0

        // Use panView as presentingView if it already exists within the containerView
        let panView: UIView = transitionContext.containerView.panContainerView ?? toVC.view

        // Move presented view offscreen (from the bottom)
        panView.frame = transitionContext.finalFrame(for: toVC)
        panView.frame.origin.y = transitionContext.containerView.frame.height

        // Haptic feedback
        if presentable?.isHapticFeedbackEnabled == true {
            feedbackGenerator?.selectionChanged()
        }

        PanModalAnimator.animate({
            panView.frame.origin.y = yPos
        }, config: presentable) { [weak self] didComplete in
            // Calls viewDidAppear and viewDidDisappear
            fromVC.endAppearanceTransition()
            transitionContext.completeTransition(didComplete)
            self?.feedbackGenerator = nil
        }
    }
    
    /**
     Animate present view controller right(offscreen) to left
     */

    private func animatePush(transitionContext: UIViewControllerContextTransitioning) {

        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return }

        let presentable = transitionContext.viewController(forKey: .to) as? PanModalPresentable.LayoutType

        // Calls viewWillAppear and viewWillDisappear
        fromVC.beginAppearanceTransition(false, animated: true)
        
        // Presents the view in shortForm position, initially
        let xPos: CGFloat = 0.0

        // Use panView as presentingView if it already exists within the containerView
        let panView: UIView = transitionContext.containerView.panContainerView ?? toVC.view

        // Move presented view offscreen (from the bottom)
        panView.frame = transitionContext.finalFrame(for: toVC)
        panView.frame.origin.x = transitionContext.containerView.frame.width

        // Haptic feedback
        if presentable?.isHapticFeedbackEnabled == true {
            feedbackGenerator?.selectionChanged()
        }

        PanModalAnimator.animate({
            panView.frame.origin.x = xPos
        }, config: presentable) { [weak self] didComplete in
            // Calls viewDidAppear and viewDidDisappear
            fromVC.endAppearanceTransition()
            transitionContext.completeTransition(didComplete)
            self?.feedbackGenerator = nil
        }
    }
    
    /**
     Animate presented view controller dismissal
     */
    private func animatePresentDismissal(transitionContext: UIViewControllerContextTransitioning) {

        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return }

        // Calls viewWillAppear and viewWillDisappear
        toVC.beginAppearanceTransition(true, animated: true)
        
        let presentable = transitionContext.viewController(forKey: .from) as? PanModalPresentable.LayoutType
        let panView: UIView = transitionContext.containerView.panContainerView ?? fromVC.view

        PanModalAnimator.animate({
            panView.frame.origin.y = transitionContext.containerView.frame.height
        }, config: presentable) { didComplete in
            fromVC.view.removeFromSuperview()
            // Calls viewDidAppear and viewDidDisappear
            toVC.endAppearanceTransition()
            transitionContext.completeTransition(didComplete)
        }
    }
    
    /**
     Animate presented view controller dismissal rightLeft
     */
    private func animatePushDismissal(transitionContext: UIViewControllerContextTransitioning) {

        guard let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return }

        // Calls viewWillAppear and viewWillDisappear
        toVC.beginAppearanceTransition(true, animated: true)
        
        let presentable = transitionContext.viewController(forKey: .from) as? PanModalPresentable.LayoutType
        let panView: UIView = transitionContext.containerView.panContainerView ?? fromVC.view

        PanModalAnimator.animate({
            panView.frame.origin.x = transitionContext.containerView.frame.width
        }, config: presentable) { didComplete in
            fromVC.view.removeFromSuperview()
            // Calls viewDidAppear and viewDidDisappear
            toVC.endAppearanceTransition()
            transitionContext.completeTransition(didComplete)
        }
    }
}

// MARK: - UIViewControllerAnimatedTransitioning Delegate

extension PanModalPresentationAnimator: UIViewControllerAnimatedTransitioning {

    /**
     Returns the transition duration
     */
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return PanModalAnimator.Constants.defaultTransitionDuration
    }

    /**
     Performs the appropriate animation based on the transition style
     */
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch transitionStyle {
        case .modally:
            (dismissal) ? animatePresentDismissal(transitionContext: transitionContext)
                        : animatePresent(transitionContext: transitionContext)
        case .push:
           (dismissal) ? animatePushDismissal(transitionContext: transitionContext)
                       : animatePush(transitionContext: transitionContext)
        }
    }

}
#endif