//
//  BlinkLoader.swift
//  BlinkLoader
//
//  Created by Giacomo Piva on 14/01/16.
//  Copyright © 2016 Giacomo Piva. All rights reserved.
//

import UIKit

class BlinkLoader: UIView {

    let container: UIView!
    let loader: UIView!
    let toColor: UIColor!
    var isRunning: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: Double, color: UIColor, backgroundColor: UIColor, toColor: UIColor, content: Character) {
        self.toColor = toColor
        
        container = UIView(frame: CGRectMake(0, 0, CGFloat(size), CGFloat(size)))
        container.backgroundColor = UIColor.clearColor()
        
        loader = UIView(frame: CGRectMake(0, 0, container.frame.size.width*0.8, container.frame.size.width*0.8))
        loader.center = CGPoint(x: container.frame.size.width/2, y: container.frame.size.height/2)
        loader.backgroundColor = backgroundColor
        loader.layer.borderWidth = CGFloat(loader.frame.size.width*0.05)
        loader.layer.borderColor = color.CGColor
        loader.layer.cornerRadius = CGFloat(loader.frame.size.width/2)
        loader.layer.masksToBounds = true
        
        let label = UILabel(frame: container.frame)
        label.center = CGPoint(x: container.bounds.width/2, y: container.bounds.height/2)
        label.text = "\(content)"
        label.font = UIFont.systemFontOfSize(container.bounds.width/3)

        label.textColor = color
        label.textAlignment = .Center
        
        container.addSubview(loader)
        container.addSubview(label)
        
        super.init(frame: CGRectMake(0, 0, CGFloat(size), CGFloat(size)))
    }
    
    func start(view: UIView, animated: Bool = false) {
        if (isRunning) {
            return
        }
        
        isRunning = true
        container.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        blinkLoop(loader)
        view.addSubview(container)
        
        if (animated) {
            container.alpha = 0
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.container.alpha = 1.0
            })
        }
    }
    
    func stop(animated: Bool = false) {
        if (animated) {
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: { () -> Void in
                self.container.alpha = 0
                }, completion: { (complete: Bool) -> Void in
                    self.container.removeFromSuperview()
            })
        } else {
            container.removeFromSuperview()
        }
        
        loader.layer.removeAllAnimations()
        isRunning = false
    }
    
    private func blinkLoop(view: UIView) {
        UIView.animateWithDuration(1.2, delay: 0, options: .CurveLinear, animations: { () -> Void in
            view.backgroundColor = self.toColor
            }) { (complete:Bool) -> Void in
                UIView.animateWithDuration(1.2, delay: 0, options: .CurveLinear, animations: { () -> Void in
                    view.backgroundColor = UIColor.clearColor()
                    }) { (complete:Bool) -> Void in
                        if (self.isRunning) {
                            self.blinkLoop(view)
                        }
                }
        }
    }
}
