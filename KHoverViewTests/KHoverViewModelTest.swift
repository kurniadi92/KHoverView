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

    func testIsNeedToUpdateDragPositionWhenStateBeganReturnTrue() {
        let kHoverViewModel = KHoverViewModel()
    
        XCTAssertTrue(kHoverViewModel.isNeedToUpdateDragPosition(state: DragState.began))
        XCTAssertFalse(kHoverViewModel.isNeedToUpdateDragPosition(state: DragState.ended))
    }
    
    func testIsNeedToUpdateDragPositionWhenStateChangedReturnTrue() {
        let kHoverViewModel = KHoverViewModel()
        
        XCTAssertTrue(kHoverViewModel.isNeedToUpdateDragPosition(state: DragState.changed))
        XCTAssertFalse(kHoverViewModel.isNeedToUpdateDragPosition(state: DragState.ended))
        
    }
    
    func testIsTouchUpWhenStateEndedReturnTrue() {
        let kHoverViewModel = KHoverViewModel()
        
        XCTAssertTrue(kHoverViewModel.isTouchUp(state: DragState.ended))
        XCTAssertFalse(kHoverViewModel.isTouchUp(state: DragState.changed))
        XCTAssertFalse(kHoverViewModel.isTouchUp(state: DragState.began))
    }

    func testTouchUpActionTriggerDismissViewWhenCurrentPositionMoreThanHalfVCHeight() {
        
        let expectation = self.expectation(description: "Expect Dismiss View Triggered")
        var kHoverViewModel = KHoverViewModel()
    
        kHoverViewModel.dismissView() {
            expectation.fulfill()
        }
        
        kHoverViewModel.touchUpAction(currentPosition: 60, frameHeight: 100)
        self.waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func testTouchUpActionTriggerBounceBackViewWhenCurrentPositionLessThanHalfVCHeight() {
        
        let expectation = self.expectation(description: "Expect Dismiss View Triggered")
        var kHoverViewModel = KHoverViewModel()
        
        kHoverViewModel.bounceBack() {
            expectation.fulfill()
        }
        
        kHoverViewModel.touchUpAction(currentPosition: 20, frameHeight: 100)
        self.waitForExpectations(timeout: 1, handler: nil)
        
    }
}
