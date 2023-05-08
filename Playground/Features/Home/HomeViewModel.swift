
import Foundation
import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func didSelectMarcin()
}

class HomeViewModel {
    private weak var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func createDisplayItems() -> [Item] {
        return [.welcome,
                .welcomeDescription,
                .separator,
                .header,
                .marcin
                ]
    }
    
    func didSelectMarcin() {
        delegate?.didSelectMarcin()
    }
}

extension HomeViewModel {
    enum Item {
        case welcome
        case welcomeDescription
        case header
        case separator
        case marcin
    }
}
