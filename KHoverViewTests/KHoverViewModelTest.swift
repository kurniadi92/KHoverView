//
//  KHoverViewModelTest.swift
//  KHoverViewTests
//
//  Created by Kurniadi on 21/10/18.
//  Copyright © 2018 Kurniadi. All rights reserved.
//

import XCTest

@testable import KHoverView

class KHoverViewModelTest: XCTestCase {

    func testTouchUpActionTriggerDismissViewWhenCurrentPositionMoreThanHalfVCHeight() {
        
        let expectation = self.expectation(description: "Expect Dismiss View Triggered")
        var kHoverViewModel = KHoverViewModel()
    
        kHoverViewModel.dismissView = {
            expectation.fulfill()
        }
        
        kHoverViewModel.touchUpAction(currentPosition: 60, frameHeight: 100)
        self.waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func testTouchUpActionTriggerBounceBackViewWhenCurrentPositionLessThanHalfVCHeight() {
        
        let expectation = self.expectation(description: "Expect Dismiss View Triggered")
        var kHoverViewModel = KHoverViewModel()
        
        kHoverViewModel.bounceBack = {
            expectation.fulfill()
        }
        
        kHoverViewModel.touchUpAction(currentPosition: 20, frameHeight: 100)
        self.waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func testTouchDragActionTriggerUpdatePostionWhenStateBegan() {
        let uiPanGestureExpected = UIPanGestureRecognizer()
        uiPanGestureExpected.state = .began
        
        let expectation = self.expectation(description: "Expect update position Triggered")
        var kHoverViewModel = KHoverViewModel()
        
        kHoverViewModel.updatePosition = { uiPanGesture in
            XCTAssertEqual(uiPanGesture, uiPanGestureExpected)
            expectation.fulfill()
        }
        
        kHoverViewModel.touchDragAction(uiPanGestureExpected)
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTouchDragActionTriggerUpdatePostionWhenStateChanged() {
        let uiPanGestureExpected = UIPanGestureRecognizer()
        uiPanGestureExpected.state = .changed
        
        let expectation = self.expectation(description: "Expect update position Triggered")
        var kHoverViewModel = KHoverViewModel()
        
        kHoverViewModel.updatePosition = { uiPanGesture in
            XCTAssertEqual(uiPanGesture, uiPanGestureExpected)
            expectation.fulfill()
        }
        
        kHoverViewModel.touchDragAction(uiPanGestureExpected)
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTouchDragActionTriggerTouchReleasedWhenStateEnded() {
        let uiPanGestureExpected = UIPanGestureRecognizer()
        uiPanGestureExpected.state = .ended
        
        let expectation = self.expectation(description: "Expect touch released Triggered")
        var kHoverViewModel = KHoverViewModel()
        
        kHoverViewModel.touchReleased = {
            expectation.fulfill()
        }
        
        kHoverViewModel.touchDragAction(uiPanGestureExpected)
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTouchDragNotTriggerAnythingStateFailedCanceledAndPossible() {
        let actionStateDictionary: Dictionary<Int,String> = [UIPanGestureRecognizer.State.possible.rawValue: "possible",
                                                             UIPanGestureRecognizer.State.failed.rawValue: "failed",
                                                             UIPanGestureRecognizer.State.cancelled.rawValue: "cancelled"]
        
        let notActionedState:[UIPanGestureRecognizer.State] = [UIPanGestureRecognizer.State.possible,
                                                             UIPanGestureRecognizer.State.failed,
                                                             UIPanGestureRecognizer.State.cancelled]
        
        for state in notActionedState {
            let uiPanGestureExpected = UIPanGestureRecognizer()
            uiPanGestureExpected.state = state

            var kHoverViewModel = KHoverViewModel()
            
            kHoverViewModel.touchReleased = {
                XCTAssert(false, "state \(actionStateDictionary[state.rawValue]!) cannot trigger touch release")
            }
            
            kHoverViewModel.updatePosition = { uiPanGesture in
                XCTAssert(false, "state \(actionStateDictionary[state.rawValue]!) cannot trigger update position")
            }
            
            kHoverViewModel.bounceBack = {
                XCTAssert(false, "state \(actionStateDictionary[state.rawValue]!) cannot trigger bounce back")
            }
            
            kHoverViewModel.dismissView = {
                XCTAssert(false, "state \(actionStateDictionary[state.rawValue]!) cannot trigger dismiss view")
            }
            
            kHoverViewModel.touchDragAction(uiPanGestureExpected)
        }
    }
}
