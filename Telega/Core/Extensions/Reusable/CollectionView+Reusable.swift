import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell & Reusable>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    public func dequeueReusableCell<
        Cell: UICollectionViewCell & Reusable
    >(
        _: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: Cell.reuseIdentifier, for: indexPath
        ) as? Cell else {
            assertionFailure("Can't dequeue a \(Cell.reuseIdentifier)")
            return Cell()
        }
        return cell
    }

    public func registerHeader<ReusableView: UICollectionReusableView & Reusable>(_: ReusableView.Type) {
        register(
            ReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ReusableView.reuseIdentifier
        )
    }

    public func registerFooter<ReusableView: UICollectionReusableView & Reusable>(_: ReusableView.Type) {
        register(
            ReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: ReusableView.reuseIdentifier
        )
    }

    public func dequeueReusableSupplementaryView<ReusableView: UICollectionReusableView & Reusable>(
        _: ReusableView.Type,
        for indexPath: IndexPath
    ) -> ReusableView {
        guard let supplementaryView = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ReusableView.reuseIdentifier,
            for: indexPath
        ) as? ReusableView else {
            fatalError("Can't dequeueReusableSupplementaryView for id: \(ReusableView.reuseIdentifier)")
        }
        return supplementaryView
    }

    public func dequeueReusableSupplementaryHeaderView<ReusableView: UICollectionReusableView & Reusable>(
        _: ReusableView.Type,
        for indexPath: IndexPath
    ) -> ReusableView {
        guard let supplementaryView = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ReusableView.reuseIdentifier,
            for: indexPath
        ) as? ReusableView else {
            fatalError("Can't dequeueReusableSupplementaryView for id: \(ReusableView.reuseIdentifier)")
        }
        return supplementaryView
    }

    public func dequeueReusableSupplementaryFooterView<ReusableView: UICollectionReusableView & Reusable>(
        _: ReusableView.Type,
        for indexPath: IndexPath
    ) -> ReusableView {
        guard let supplementaryView = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: ReusableView.reuseIdentifier,
            for: indexPath
        ) as? ReusableView else {
            assertionFailure("Can't dequeueReusableSupplementaryView for id: \(ReusableView.reuseIdentifier)")
            return ReusableView()
        }
        return supplementaryView
    }
}
