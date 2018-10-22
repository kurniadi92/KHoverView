//
//  KHoverViewModel.swift
//  KHoverView
//
//  Created by Kurniadi on 21/10/18.
//  Copyright © 2018 Kurniadi. All rights reserved.
//

enum DragState : Int {

    case possible
    case began
    case changed
    case ended
    case cancelled
    case failed
}

import Foundation
import UIKit

struct KHoverViewModel {
    
    private var dismissAction: () -> () = {}
    private var bounceAction: () -> () = {}
    
    mutating func dismissView(action: @escaping ()->() ) {
        dismissAction = action
    }
    
    mutating func bounceBack(action: @escaping ()->() ) {
        bounceAction = action
    }
    
    func isNeedToUpdateDragPosition(state: DragState) -> Bool {
        return state == .began || state == .changed
    }
    
    func isTouchUp(state: DragState) -> Bool {
        return state == .ended
    }
    
    func touchUpAction(currentPosition:CGFloat , frameHeight: CGFloat){
        if(currentPosition > frameHeight / 2) {
            dismissAction()
        } else {
            bounceAction()
        }
    }
}
