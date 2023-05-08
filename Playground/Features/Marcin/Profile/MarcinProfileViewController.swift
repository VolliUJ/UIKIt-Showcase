
import PromiseKit
import UIKit

final class MarcinProfileViewController: UITableViewController, Deinitcallable {
    var onDeinit: (() -> Void)?
    
    private var viewModel: MarcinProfileViewModel
    private(set) var displayItems: [MarcinProfileViewModel.Item] = []

    init(viewModel: MarcinProfileViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        onDeinit?()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()
        validateViewModel()
    }

    fileprivate func configureView() {
        view.backgroundColor = .white
    }

    fileprivate func configureTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()

        tableView.registerUIFrameworkNibs()
    }

    func validateViewModel() {
        firstly {
            viewModel.validate()
        }.done { [weak self] valid in
            guard valid else { return }

            self?.render()
        }.catch { _ in
            print("Error validating model data")
        }
    }

    func render() {
        displayItems = viewModel.createDisplayItems()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}

extension MarcinProfileViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = displayItems[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: item.displayItem.reuseIdentifier, for: indexPath)
        item.displayItem.configure(cell)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = displayItems[indexPath.row]

        switch item {
        case let .motorbike(motorbike):
            viewModel.didSelect(motorbike: motorbike)
        default:
            break
        }
    }
}

// MARK: Display Items
fileprivate extension MarcinProfileViewModel.Item {
    var displayItem: DisplayItem {
        switch self {
        case let .intro(image, header, description):
            return .imageTitleDescription(title: header, subtitle: description, image: image)

        case let .detail(subject, answer):
            return .title(title: subject, subtitle: answer)

        case let .header(title):
            return .sectionHeader(title: title)

        case let .motorbike(motorbike):
            return .title(title: motorbike.fullName, subtitle: motorbike.description)
        }
    }
}
