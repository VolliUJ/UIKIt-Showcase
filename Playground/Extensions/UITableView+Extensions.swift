
import UIKit

extension UITableView {
    func registerUIFrameworkNibs() {
        register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.reuseIdentifier)
        register(ImageTitleSubtitleTableViewCell.self, forCellReuseIdentifier: ImageTitleSubtitleTableViewCell.reuseIdentifier)
        register(SectionHeaderTableViewCell.self, forCellReuseIdentifier: SectionHeaderTableViewCell.reuseIdentifier)
        register(SeparatorTableViewCell.self, forCellReuseIdentifier: SeparatorTableViewCell.reuseIdentifier)
        register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.reuseIdentifier)
        register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
    }
}
