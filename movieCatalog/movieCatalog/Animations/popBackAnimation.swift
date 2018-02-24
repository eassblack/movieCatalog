//
//  popBackAnimation.swift
//  movieCatalog
//
//  Created by Edwin Sierra on 2/23/18.
//  Copyright © 2018 Edwin Sierra. All rights reserved.
//

import UIKit

/// Animacion que se ejecuta al momento de hacer un pop haciendo un swipe desde el borde izquierdo de la pantalla
class popBackAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Tomamos el view controller de donde vinimos y el view controller a donde vamos desde el
        // transitionContext que nos pasan como un parametro
        guard let fromVC = transitionContext.viewController(forKey:UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        toVC.view.frame.origin = fromVC.view.frame.origin
     
        // Insertamos el fromVC sobre el toVC para crear el efecto deseado
        // El toVC aparece debajo del FromVC
        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        fromVC.view.layer.shadowOpacity = 0.5
        fromVC.view.layer.shadowOffset = CGSize(width: 2.0, height: 0.0)
        fromVC.view.layer.shadowRadius = 3.0
        fromVC.view.layer.shadowColor = UIColor.white.cgColor
        
        // Hacemos la animacion
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame.origin.x = SCREEN_SIZE.width
            fromVC.view.layoutIfNeeded()
        }) { (finish) in
            //Le decimos al transition context que terminamos la animacion
            fromVC.view.layer.shadowOpacity = 0.0
            fromVC.view.layer.shadowOffset = CGSize.zero
            fromVC.view.layer.shadowRadius = 0.0
            fromVC.view.layer.shadowColor = UIColor.clear.cgColor
            let cancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!cancelled)
        }
        
    }
}
