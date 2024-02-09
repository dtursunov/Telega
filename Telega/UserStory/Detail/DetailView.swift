//
//  DetailView.swift
//  Telega
//
//  Created by Diyor Tursunov on 09/02/24.
//

import UIKit
import Kingfisher

final class DetailView: UIViewController {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorsLabel = UILabel()
    private let bookIdLabel = UILabel()
    private let bookYearLabel = UILabel()
    private let containerView = UIStackView()
    
    let book: BookItem
    
    init(book: BookItem) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Telega"
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
        containerView.axis = .vertical
        containerView.alignment = .fill
        containerView.spacing = 8
        
        containerView.addArrangedSubview(imageView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(authorsLabel)
        containerView.addArrangedSubview(bookIdLabel)
        containerView.addArrangedSubview(bookYearLabel)
        containerView.addArrangedSubview(UIStackView())
            
        // Labels
        [titleLabel, authorsLabel, bookIdLabel, bookYearLabel].forEach { label in
            label.font = .systemFont(ofSize: 18)
            label.textColor = .label
            label.numberOfLines = 2
        }
        
        titleLabel.text = book.name
        authorsLabel.text = "Authors: \n\(String(describing: book.authors))"
        authorsLabel.numberOfLines = 0
        authorsLabel.isHidden = book.authors?.isEmpty ?? true
        bookIdLabel.text = "Book ID: \(String(describing: book.id))"
        bookYearLabel.text = "Published year: \(String(describing: book.publishedYear ?? ""))"
        
        // Image
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { $0.height.equalTo(UIScreen.main.bounds.height * 0.4)}
        guard let image = book.imageURL, let url = URL(string: image) else {
            imageView.image = .init(named: "DefaultBook")
            return
        }
        imageView.kf.setImage(with: url)
    }
    

}
