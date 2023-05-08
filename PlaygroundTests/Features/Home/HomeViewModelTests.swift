//
//  HomeViewModelTests.swift
//  PlaygroundTests
//
//  Created by Marcin Golli on 05/05/2023.
//


import Foundation
import Nimble
import Quick

@testable import Playground

class HomeViewModelTests: QuickSpec {
    override func spec() {
        var delegate: MockHomeViewModelDelegate!
        var viewModel: HomeViewModel!
        
        beforeEach {
            delegate = MockHomeViewModelDelegate()
            viewModel = HomeViewModel(delegate: delegate)
        }
        
        describe("Display Items") {
            it("List has 5 elements") {
                let displayItems = viewModel.createDisplayItems()
                expect(displayItems.count).to(equal(5))
            }
            
            it("First element is welcome item") {
                let displayItem = viewModel.createDisplayItems()[0]
                expect(displayItem).to(equal(.welcome))
            }
            
            it("Second element is welcomeDescription item") {
                let displayItem = viewModel.createDisplayItems()[1]
                expect(displayItem).to(equal(.welcomeDescription))
            }
            
            it("Third element is separator item") {
                let displayItem = viewModel.createDisplayItems()[2]
                expect(displayItem).to(equal(.separator))
            }
            
            it("Fourth element is header item") {
                let displayItem = viewModel.createDisplayItems()[3]
                expect(displayItem).to(equal(.header))
            }
            
            it("Fifth element is marcin item") {
                let displayItem = viewModel.createDisplayItems()[4]
                expect(displayItem).to(equal(.marcin))
            }
        }
        
        describe("Delegate Methods") {
            it("didSelectMarcin called") {
                viewModel.didSelectMarcin()
                expect(delegate.didSelectMarcinCalled).to(beTrue())
            }
        }
    }
}
