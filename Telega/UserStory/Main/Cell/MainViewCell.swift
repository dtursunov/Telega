//
//  MainViewCell.swift
//  Telega
//
//  Created by Diyor Tursunov on 09/02/24.
//

import UIKit
import Kingfisher
import SnapKit

extension UITableViewCell {
    fileprivate enum Constant {
        static let imageSize: CGSize = .init(width: 36, height: 36)
        static let containerOffset: UIEdgeInsets = .init(top: 4, left: 16, bottom: 4, right: 16)
    }
    
    struct Model {
        let bookId: String
        let title: String
        let detail: String
        let imageUrl: String?
    }
}

final class MainViewCell: UITableViewCell {
    
    private let bookImageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let titlesStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.layer.cornerRadius = Constant.imageSize.height / 2
        bookImageView.clipsToBounds = true
        contentView.addSubview(bookImageView)

        bookImageView.snp.makeConstraints {
            $0.size.equalTo(Constant.imageSize)
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        titlesStack.axis = .vertical
        titlesStack.alignment = .fill
        titlesStack.addArrangedSubview(titleLabel)
        titlesStack.addArrangedSubview(detailLabel)
        contentView.addSubview(titlesStack)
        titlesStack.snp.makeConstraints { make in
            make.leading.equalTo(bookImageView.snp.trailing).offset(16)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        
        detailLabel.font = .systemFont(ofSize: 12)
        detailLabel.textColor = .label
        
    }
    
    func configureCell(with item: Model) {
        titleLabel.text = item.title
        detailLabel.text = item.detail
        detailLabel.isHidden = item.detail.isEmpty
        if
            let imageUrl = item.imageUrl,
            let url = URL(string: imageUrl) {
            bookImageView.kf.setImage(with: url)
        } else {
            bookImageView.image = .init(systemName: "folder")
        }
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
    }
}
