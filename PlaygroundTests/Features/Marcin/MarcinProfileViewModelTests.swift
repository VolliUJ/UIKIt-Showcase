
import Foundation
import Nimble
import Quick

@testable import Playground

class MarcinProfileViewModelTests: QuickSpec {
    override func spec() {
        var delegate: MockMarcinProfileViewModelDelegate!
        var viewModel: MarcinProfileViewModel!
        var profile: MarcinProfile!

        beforeEach {
            let apiProfile = MockMarcinProfile.mockMarcinProfile(id: "API")
            delegate = MockMarcinProfileViewModelDelegate(profile: apiProfile)
        }

        context("View Model has existing data") {
            beforeEach {
                profile = MockMarcinProfile.mockMarcinProfile(id: "EXISTING")
                viewModel = MarcinProfileViewModel(profile: profile, delegate: delegate)
                let _ = viewModel.validate()
            }

            describe("Display Items") {
                it("List has 4 elements") {
                    let displayItems = viewModel.createDisplayItems()
                    expect(displayItems.count).to(equal(4))
                }
                
                it("First element is intro item with correct values") {
                    let displayItem = viewModel.createDisplayItems()[0]
                    
                    if case let .intro(image, header, description) = displayItem {
                        expect(image).toNot(beNil())
                        expect(header).to(equal(profile.name))
                        expect(description).to(equal(profile.role))
                    } else {
                        fail("Expected .intro(UIImage, String, String) but got <\(displayItem)>")
                    }
                }
                
                it("Second element is detail item with correct subject and answer") {
                    let displayItem = viewModel.createDisplayItems()[1]
                    let profileDetails = profile.details.first!
                    
                    if case let .detail(subject, answer) = displayItem {
                        expect(subject).to(equal(profileDetails.key))
                        expect(answer).to(equal(profileDetails.value))
                    } else {
                        fail("Expected .detail(String, String) but got <\(displayItem)>")
                    }
                }
                
                it("Third element is header item with correct text") {
                    let displayItem = viewModel.createDisplayItems()[2]
                    
                    if case let .header(title) = displayItem {
                        expect(title).to(equal(Texts.motorbikeSectionHeader))
                    } else {
                        fail("Expected .header(String) but got <\(displayItem)>")
                    }
                }
                
                it("Fourth element is motorbike item with correct model") {
                    let displayItem = viewModel.createDisplayItems()[3]
                    
                    if case let .motorbike(motorbike) = displayItem {
                        expect(motorbike.details).to(equal(profile.motorbikes[0].details))
                    } else {
                        fail("Expected .motorbike(Motorbike) but got <\(displayItem)>")
                    }
                }
            }
        }

        context("View Model has NOT existing data") {
            beforeEach {
                profile = MockMarcinProfile.mockMarcinEmptyProfile()
                viewModel = MockMarcinProfileViewModel(profile: profile, delegate: delegate)
                (viewModel as! MockMarcinProfileViewModel).fetchDataExceptation = self.expectation(description: "didFetchData")
                let _ = viewModel.validate()
                self.waitForExpectations(timeout: 10)
            }

            describe("Display Items") {
                it("List has 4 elements") {
                    let displayItems = viewModel.createDisplayItems()
                    expect(displayItems.count).to(equal(4))
                }
                
                it("First element is intro item with correct values") {
                    let displayItem = viewModel.createDisplayItems()[0]
                    
                    if case let .intro(image, header, description) = displayItem {
                        expect(image).toNot(beNil())
                        expect(header).to(equal(delegate.profile.name))
                        expect(description).to(equal(delegate.profile.role))
                    } else {
                        fail("Expected .intro(UIImage, String, String) but got <\(displayItem)>")
                    }
                }
                
                it("Second element is detail item with correct subject and answer") {
                    let displayItem = viewModel.createDisplayItems()[1]
                    let profileDetails = delegate.profile.details.first!
                    
                    if case let .detail(subject, answer) = displayItem {
                        expect(subject).to(equal(profileDetails.key))
                        expect(answer).to(equal(profileDetails.value))
                    } else {
                        fail("Expected .detail(String, String) but got <\(displayItem)>")
                    }
                }
                
                it("Third element is header item with correct text") {
                    let displayItem = viewModel.createDisplayItems()[2]
                    
                    if case let .header(title) = displayItem {
                        expect(title).to(equal(Texts.motorbikeSectionHeader))
                    } else {
                        fail("Expected .header(String) but got <\(displayItem)>")
                    }
                }
                
                it("Fourth element is motorbike item with correct model") {
                    let displayItem = viewModel.createDisplayItems()[3]

                    if case let .motorbike(motorbike) = displayItem {
                        expect(motorbike.details).to(equal(delegate.profile.motorbikes[0].details))
                    } else {
                        fail("Expected .motorbike(Motorbike) but got <\(displayItem)>")
                    }
                }
            }
        }
    }
}
