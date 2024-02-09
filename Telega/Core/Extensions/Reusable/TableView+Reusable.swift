import UIKit

extension UITableView {
    public func register(cellType: (some UITableViewCell & Reusable).Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    public func dequeueCell<Cell: UITableViewCell & Reusable>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        let dequeuedCell = dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath)
        guard let typedCell = dequeuedCell as? Cell else {
            fatalError(
                "Wrong cell type \(String(describing: dequeuedCell.self)) for identifier \(cell.reuseIdentifier)"
            )
        }
        return typedCell
    }
}
