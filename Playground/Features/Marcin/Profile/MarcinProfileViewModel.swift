
import Foundation
import PromiseKit
import UIKit

protocol MarcinProfileViewModelDelegate: AnyObject {
    func fetchMarcinProfile() -> Promise<MarcinProfile>
    func didSelectMotorbike(motorbike: Motorbike)
}

class MarcinProfileViewModel: DataValidatable {
    private var profile: MarcinProfile
    private weak var delegate: MarcinProfileViewModelDelegate?

    private var intro: [Item] {
        return [.intro(image: profile.image, header: profile.name, description: profile.role)]
    }

    private var details: [Item] {
        return profile.details.map { .detail(subject: $0.key, answer: $0.value) }
    }

    private var motorbikes: [Item] {
        profile.motorbikes.map { .motorbike(motorbike: $0) }
    }

    private var motorbikesSection: [Item] {
        var items: [Item] = [.header(title: Texts.motorbikeSectionHeader)]
        items.append(contentsOf: motorbikes)
        return items
    }

    init(profile: MarcinProfile,
         delegate: MarcinProfileViewModelDelegate? = nil) {
        self.profile = profile
        self.delegate = delegate
    }

    func validate() -> Promise<Bool> {
        guard !profile.details.isEmpty, !profile.motorbikes.isEmpty else {
            return fetchData()
        }
        
        return .value(true)
    }

    func fetchData() -> Promise<Bool> {
        guard let delegate = delegate else { return .value(false) }

        return firstly {
            delegate.fetchMarcinProfile()
        }.then { [weak self] profile -> Promise<Bool> in
            guard let self = self else { return .value(false) }

            self.profile = profile
            return .value(true)
        }.recover { _ -> Promise<Bool> in
            return .value(false)
        }
    }

    func createDisplayItems() -> [Item] {
        var items: [Item] = []
        items.append(contentsOf: intro)
        items.append(contentsOf: details)
        items.append(contentsOf: motorbikesSection)
        return items
    }
    
    func didSelect(motorbike: Motorbike) {
        delegate?.didSelectMotorbike(motorbike: motorbike)
    }
}

extension MarcinProfileViewModel {
    enum Item {
        case intro(image: UIImage?, header: String, description: String)
        case detail(subject: String, answer: String)
        case header(title: String)
        case motorbike(motorbike: Motorbike)
    }
}
