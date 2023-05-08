
import UIKit
import SnapKit

class SeparatorTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SeparatorTableViewCell"
    
    let spacerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(spacerView)
        
        spacerView.backgroundColor = UIColor.clear
    }
    
    func configure(height: CGFloat) {
        spacerView.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.snp.removeConstraints()
    }
}
