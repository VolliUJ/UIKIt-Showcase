
import Foundation
import Nimble
import Quick

@testable import Playground

class MarcinMotorbikeViewModelTests: QuickSpec {
    override func spec() {
        var delegate: MockMarcinMotorbikeViewModelDelegate!
        var viewModel: MarcinMotorbikeViewModel!
        var motorbike: Motorbike!
        
        beforeEach {
            motorbike = MockMarcinProfile.mockMotorbike(id: "EXISTING")
            let apiMotorbike = MockMarcinProfile.mockMotorbike(id: "API")
            delegate = MockMarcinMotorbikeViewModelDelegate(motorbike: apiMotorbike)
        }
        
        context("View Model has existing data") {
            beforeEach {
                viewModel = MockMarcinMotorbikeViewModel(name: motorbike.fullName,
                                                         motorbike: motorbike,
                                                         delegate: delegate)
                let _ = viewModel.validate()
            }
            
            describe("Display Items") {
                it("List has 4 elements") {
                    let displayItems = viewModel.createDisplayItems()
                    expect(displayItems.count).to(equal(4))
                }
                
                it("First element is title item with correct text") {
                    let displayItem = viewModel.createDisplayItems()[0]
                    
                    if case let .title(title) = displayItem {
                        expect(title).to(equal(motorbike.fullName))
                    } else {
                        fail("Expected .title(String) but got <\(displayItem)>")
                    }
                }
                
                it("Second element is Image item") {
                    let displayItem = viewModel.createDisplayItems()[1]
                    
                    if case let .image(image) = displayItem {
                        expect(image).toNot(beNil())
                    } else {
                        fail("Expected .image(UIImage) but got <\(displayItem)>")
                    }
                }
                
                it("Third element is details item with correct text") {
                    let displayItem = viewModel.createDisplayItems()[2]
                    
                    if case let .details(details) = displayItem {
                        expect(details).to(equal(motorbike.details))
                    } else {
                        fail("Expected .details(String) but got <\(displayItem)>")
                    }
                }
                
                it("Fourth element is description item with correct text") {
                    let displayItem = viewModel.createDisplayItems()[3]
                    
                    if case let .description(description) = displayItem {
                        expect(description).to(equal(motorbike.description))
                    } else {
                        fail("Expected .title(String) but got <\(displayItem)>")
                    }
                }
            }
        }
        
        context("View Model has NOT existing data") {
            beforeEach {
                viewModel = MockMarcinMotorbikeViewModel(name: delegate.motorbike.fullName,
                                                         motorbike: nil,
                                                         delegate: delegate)
                
                (viewModel as! MockMarcinMotorbikeViewModel).fetchDataExceptation = self.expectation(description: "didFetchData")
                let _ = viewModel.validate()
                self.waitForExpectations(timeout: 10)
            }
            
            describe("Display Items") {
                it("List has 4 elements") {
                    let displayItems = viewModel.createDisplayItems()
                    expect(displayItems.count).to(equal(4))
                }
                
                it("First element is title item with correct text") {
                    let displayItem = viewModel.createDisplayItems()[0]
                    
                    if case let .title(title) = displayItem {
                        expect(title).to(equal(delegate.motorbike.fullName))
                    } else {
                        fail("Expected .title(String) but got <\(displayItem)>")
                    }
                }
                
                it("Second element is Image item") {
                    let displayItem = viewModel.createDisplayItems()[1]
                    
                    if case let .image(image) = displayItem {
                        expect(image).toNot(beNil())
                    } else {
                        fail("Expected .image(UIImage) but got <\(displayItem)>")
                    }
                }
                
                it("Third element is details item with correct text") {
                    let displayItem = viewModel.createDisplayItems()[2]
                    
                    if case let .details(details) = displayItem {
                        expect(details).to(equal(delegate.motorbike.details))
                    } else {
                        fail("Expected .details(String) but got <\(displayItem)>")
                    }
                }
                
                it("Fourth element is description item with correct text") {
                    let displayItem = viewModel.createDisplayItems()[3]
                    
                    if case let .description(description) = displayItem {
                        expect(description).to(equal(delegate.motorbike.description))
                    } else {
                        fail("Expected .title(String) but got <\(displayItem)>")
                    }
                }
            }
        }
    }
}
