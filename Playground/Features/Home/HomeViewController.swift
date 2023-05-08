
import UIKit

final class HomeViewController: UITableViewController, Deinitcallable {
    var onDeinit: (() -> Void)?
    
    private var viewModel: HomeViewModel
    private(set) var displayItems: [HomeViewModel.Item] = []

    init(viewModel: HomeViewModel) {
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

        render()
    }

    fileprivate func configureView() {
        view.backgroundColor = .white
    }

    fileprivate func configureTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView()
        tableView.registerUIFrameworkNibs()
    }

    func render() {
        displayItems = viewModel.createDisplayItems()
        tableView.reloadData()
    }
}

extension HomeViewController {
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
        case .marcin:
            viewModel.didSelectMarcin()
        default:
            break
        }
    }
}

extension HomeViewModel.Item {
    var displayItem: DisplayItem {
        switch self {
        case .welcome:
            return .title(title: Texts.homeTitle, subtitle: Texts.homeSubtitle)
        case .welcomeDescription:
            return .text(text: Texts.homeWelcomeDescription)
        case .header:
            return .sectionHeader(title: Texts.homeHeader)
        case .separator:
            return .separator(height: Values.homeSeparatorHeight)
        case .marcin:
            return .imageTitleDescription(title: Texts.marcinName, subtitle: Texts.marcinRole, image: Images.marcinAvatar)
        }
    }
}
