
import Foundation
import PromiseKit
import UIKit

protocol MarcinMotorbikeViewModelDelegate: AnyObject {
    func fetchMotorbike(name: String) -> Promise<Motorbike?>
}

class MarcinMotorbikeViewModel: DataValidatable {
    private weak var delegate: MarcinMotorbikeViewModelDelegate?
    private let name: String
    private var motorbike: Motorbike?

    private var title: [Item] {
        guard let motorbike = motorbike else { return [] }
        return [.title(title: motorbike.fullName)]
    }

    private var image: [Item] {
        guard let image = motorbike?.image else { return [] }
        return [.image(image: image)]
    }

    private var details: [Item] {
        guard let motorbike = motorbike else { return [] }
        return [.details(name: motorbike.details)]
    }

    private var description: [Item] {
        guard let description = motorbike?.description else { return [] }
        return [.description(description: description)]
    }

    convenience init(motorbike: Motorbike,
                     delegate: MarcinMotorbikeViewModelDelegate? = nil) {
        self.init(name: motorbike.fullName, motorbike: motorbike, delegate: delegate)
    }

    init(name: String,
         motorbike: Motorbike? = nil,
         delegate: MarcinMotorbikeViewModelDelegate? = nil) {
        self.motorbike = motorbike
        self.name = name
        self.delegate = delegate
    }

    func fetchData() -> Promise<Bool> {
        guard let delegate = delegate else { return .value(false) }

        return firstly {
            delegate.fetchMotorbike(name: name)
        }.then { [weak self] motorbike -> Promise<Bool> in
            guard let self = self else { return .value(false) }

            self.motorbike = motorbike
            return .value(true)
        }.recover { _ -> Promise<Bool> in
            return .value(false)
        }
    }

    func validate() -> Promise<Bool> {
        guard motorbike != nil else {
            return fetchData()
        }
        return .value(true)
    }

    func createDisplayItems() -> [Item] {
        var displayItems: [Item] = []
        displayItems.append(contentsOf: title)
        displayItems.append(contentsOf: image)
        displayItems.append(contentsOf: details)
        displayItems.append(contentsOf: description)
        return displayItems
    }
}

extension MarcinMotorbikeViewModel {
    enum Item {
        case title(title: String)
        case image(image: UIImage)
        case details(name: String)
        case description(description: String)
    }
}
