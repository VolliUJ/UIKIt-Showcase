
import UIKit
import SnapKit

class ImageTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ImageTableViewCell"
    
    let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(customImageView)
        
        customImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(contentView)
            make.bottom.lessThanOrEqualTo(contentView).offset(-8)
            make.height.equalTo(120)
        }
        
        selectionStyle = .none
    }
    
    func configure(image: UIImage?) {
        customImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customImageView.image = nil
    }
}

