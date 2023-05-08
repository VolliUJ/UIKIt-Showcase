
import UIKit
import SnapKit

class ImageTitleSubtitleTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ImageTitleSubtitleTableViewCell"
    
    let cellImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cellImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.centerY.equalTo(contentView)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(cellImageView.snp.right).offset(16)
            make.top.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(cellImageView.snp.right).offset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.right.equalTo(contentView).offset(-16)
            make.bottom.equalTo(contentView).offset(-16)
        }
        
//        NSLayoutConstraint.activate([
//            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            cellImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            cellImageView.widthAnchor.constraint(equalToConstant: 40),
//            cellImageView.heightAnchor.constraint(equalToConstant: 40),
//
//            titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
//            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//
//            subtitleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 16),
//            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
//            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
//        ])
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = UIColor.gray
        selectionStyle = .none
    }
    
    func configure(image: UIImage?, title: String, subtitle: String) {
        cellImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
