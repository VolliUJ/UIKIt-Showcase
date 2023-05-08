
import PromiseKit
import UIKit

final class MarcinMotorbikeViewController: UITableViewController {
    private var viewModel: MarcinMotorbikeViewModel
    private(set) var displayItems: [MarcinMotorbikeViewModel.Item] = []

    init(viewModel: MarcinMotorbikeViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension MarcinMotorbikeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = displayItems[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: item.displayItem.reuseIdentifier, for: indexPath)
        item.displayItem.configure(cell)
        return cell
    }
}

// MARK: Display Items
fileprivate extension MarcinMotorbikeViewModel.Item {
    var displayItem: DisplayItem {
        switch self {
        case let .title(title):
            return .title(title: title)
        case let .image(image):
            return .image(image: image)
        case let .details(name):
            return .sectionHeader(title: name)
        case let .description(description):
            return .text(text: description)
        }
    }
}
