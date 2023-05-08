
import UIKit

enum DisplayItem {
    case imageTitleDescription(title: String, subtitle: String, image: UIImage?)
    case image(image: UIImage)
    case sectionHeader(title: String)
    case separator(height: CGFloat)
    case text(text: String)
    case title(title: String, subtitle: String? = nil)
    
    var reuseIdentifier: String {
        switch self {
        case .imageTitleDescription: return ImageTitleSubtitleTableViewCell.reuseIdentifier
        case .image: return ImageTableViewCell.reuseIdentifier
        case .sectionHeader: return SectionHeaderTableViewCell.reuseIdentifier
        case .separator: return SeparatorTableViewCell.reuseIdentifier
        case .text: return TextTableViewCell.reuseIdentifier
        case .title: return TitleTableViewCell.reuseIdentifier
        }
    }
    
    func configure(_ cell: UITableViewCell) {
        switch self {
        case let .imageTitleDescription(title, subtitle, image):
            (cell as? ImageTitleSubtitleTableViewCell)?.configure(image: image, title: title, subtitle: subtitle)
        case let .image(image):
            (cell as? ImageTableViewCell)?.configure(image: image)
        case .sectionHeader(let title):
            (cell as? SectionHeaderTableViewCell)?.configure(title: title)
        case .separator(let height):
            (cell as? SeparatorTableViewCell)?.configure(height: height)
        case .text(let text):
            (cell as? TextTableViewCell)?.configure(text: text)
        case .title(let title, let subtitle):
            (cell as? TitleTableViewCell)?.configure(title: title, subtitle: subtitle)
        }
    }
}
