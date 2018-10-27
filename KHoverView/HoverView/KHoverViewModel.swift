//
//  KHoverViewModel.swift
//  KHoverView
//
//  Created by Kurniadi on 21/10/18.
//  Copyright © 2018 Kurniadi. All rights reserved.
//

import Foundation
import UIKit

struct KHoverViewModel {
    
    var dismissView: () -> () = {}
    var bounceBack: () -> () = {}
    var updatePosition: (UIPanGestureRecognizer) -> () = { _ in }
    var touchReleased: () -> () = {}
    
    fileprivate func isNeedToUpdateDragPosition(state: UIPanGestureRecognizer.State) -> Bool {
        return state == .began || state == .changed
    }
    
    fileprivate func isTouchUp(state: UIPanGestureRecognizer.State) -> Bool {
        return state == .ended
    }
    
    func touchUpAction(currentPosition:CGFloat , frameHeight: CGFloat){
        if(currentPosition > frameHeight / 2) {
            dismissView()
        } else {
            bounceBack()
        }
    }
    
    func touchDragAction(_ gestureRecognizer:UIPanGestureRecognizer) {
        if isNeedToUpdateDragPosition(state: gestureRecognizer.state) {
            updatePosition(gestureRecognizer)
        } else if isTouchUp(state: gestureRecognizer.state) {
            touchReleased()
        }
    }
}
