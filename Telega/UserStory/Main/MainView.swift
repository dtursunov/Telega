import UIKit

protocol MainViewProtocol: AnyObject {
    func reloadData()
   
}

final class MainView: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let textfield = UITextField()
    
    private let presenter: MainPresenterProtocol
    
    init(presenter: MainPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Books"
        
        textfield.addTarget(self, action: #selector(editingDidChange), for: .editingChanged)
        textfield.borderStyle  = .roundedRect
        view.addSubview(textfield)
        textfield.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        tableView.register(cellType: MainViewCell.self)
    }
    
    @objc 
    private func editingDidChange(_ textfield: UITextField) {
        presenter.search(text: textfield.text)
    }
}

extension MainView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath)
    }
}

extension MainView: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.getNumberOfRows()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let item = presenter.getItem(at: indexPath)
        let cell = tableView.dequeueCell(MainViewCell.self, for: indexPath)
        cell.configureCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}

extension MainView: MainViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}
