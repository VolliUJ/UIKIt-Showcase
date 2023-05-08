
import UIKit
import SnapKit

class SectionHeaderTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SectionHeaderTableViewCell"
    
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
                
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            
            make.top.greaterThanOrEqualTo(contentView).offset(4)
            make.bottom.lessThanOrEqualTo(contentView).offset(-4)
            
            make.height.equalTo(60)
        }
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        
        contentView.backgroundColor = UIColor.lightGray
        selectionStyle = .none
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

