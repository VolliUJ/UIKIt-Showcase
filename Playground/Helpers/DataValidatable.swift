
import PromiseKit

protocol DataValidatable {
    func validate() -> Promise<Bool>
}
