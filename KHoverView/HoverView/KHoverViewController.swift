//
//  KHoverViewController.swift
//  KHoverView
//
//  Created by Kurniadi on 20/10/18.
//  Copyright © 2018 Kurniadi. All rights reserved.
//

import UIKit


class KHoverViewController: UIViewController {
    
    var maxTopConstraint:CGFloat = 0
    var viewModel: KHoverViewModel = KHoverViewModel()
    
    @IBOutlet private weak var DraggableViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var dragArea: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DraggableViewTopConstraint.constant = maxTopConstraint

        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(draggedAreaMove))
        self.dragArea.addGestureRecognizer(gestureRecognizer)
        
        setupViewModel()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupViewModel() {
        viewModel.bounceBack = { [weak self] in
            UIView.animate(withDuration: 0.1) {
                self?.DraggableViewTopConstraint.constant = self?.maxTopConstraint ?? 36
                
                self?.view.needsUpdateConstraints()
                self?.view.layoutIfNeeded()
                self?.view.setNeedsLayout()
            }
        }
        
        viewModel.dismissView = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        viewModel.updatePosition = { [weak self] gestureRecognizer in
            let translation = gestureRecognizer.translation(in: self?.view)
            self?.DraggableViewTopConstraint.constant = translation.y
        }
        
        viewModel.touchReleased = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.touchUpAction(currentPosition: weakSelf.DraggableViewTopConstraint.constant, frameHeight: weakSelf.view.frame.height)
        }
    }
    
    @objc private func draggedAreaMove(_ gestureRecognizer: UIPanGestureRecognizer) {
        viewModel.touchDragAction(gestureRecognizer)
    }
    
}

extension KHoverViewController {
    static func showHoverView(parent source: UIViewController, gapFromTop: CGFloat = 60) {
        let hoverViewController = KHoverViewController(nibName: "KHoverViewController", bundle: nil)
        hoverViewController.modalPresentationStyle = .overCurrentContext
        hoverViewController.maxTopConstraint = gapFromTop
        source.present(hoverViewController, animated: true, completion: nil)
    }
}
