//
//  pushAnimation.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 2/21/18.
//  Copyright © 2018 Edwin Sierra. All rights reserved.
//

import UIKit

class pushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationControllerOperation = .push
    var thumbnailFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.viewController(forKey: .to)!.view!
        
        transitionContext.containerView.addSubview(toView)
        
        toView.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1.0
        }, completion: { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
