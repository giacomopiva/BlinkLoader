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
        
        container = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(size), height: CGFloat(size)))
        container.backgroundColor = UIColor.clear
        
        loader = UIView(frame: CGRect(x: 0, y: 0, width: container.frame.size.width*0.8, height: container.frame.size.width*0.8))
        loader.center = CGPoint(x: container.frame.size.width/2, y: container.frame.size.height/2)
        loader.backgroundColor = backgroundColor
        loader.layer.borderWidth = CGFloat(loader.frame.size.width*0.05)
        loader.layer.borderColor = color.cgColor
        loader.layer.cornerRadius = CGFloat(loader.frame.size.width/2)
        loader.layer.masksToBounds = true
        
        let label = UILabel(frame: container.frame)
        label.center = CGPoint(x: container.bounds.width/2, y: container.bounds.height/2)
        label.text = "\(content)"
        label.font = UIFont.systemFont(ofSize: container.bounds.width/3)

        label.textColor = color
        label.textAlignment = .center
        
        container.addSubview(loader)
        container.addSubview(label)
        
        super.init(frame: CGRect(x: 0, y: 0, width: CGFloat(size), height: CGFloat(size)))
    }
    
    func start(_ view: UIView, animated: Bool = false) {
        if (isRunning) {
            return
        }
        
        isRunning = true
        container.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        blinkLoop(loader)
        view.addSubview(container)
        
        if (animated) {
            container.alpha = 0
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.container.alpha = 1.0
            })
        }
    }
    
    func stop(_ animated: Bool = false) {
        if (animated) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: { () -> Void in
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
    
    fileprivate func blinkLoop(_ view: UIView) {
        UIView.animate(withDuration: 1.2, delay: 0, options: .curveLinear, animations: { () -> Void in
            view.backgroundColor = self.toColor
            }) { (complete:Bool) -> Void in
                UIView.animate(withDuration: 1.2, delay: 0, options: .curveLinear, animations: { () -> Void in
                    view.backgroundColor = UIColor.clear
                    }) { (complete:Bool) -> Void in
                        if (self.isRunning) {
                            self.blinkLoop(view)
                        }
                }
        }
    }
}
