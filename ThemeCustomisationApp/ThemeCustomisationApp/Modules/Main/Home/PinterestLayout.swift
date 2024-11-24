//
//  PinterestLayout.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 24/11/2024.
//

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForItemAt indexPath: IndexPath,
        with width: CGFloat
    ) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
    // Delegate to get dynamic heights
    weak var delegate: PinterestLayoutDelegate?

    // Cache to store calculated attributes
    private var cache: [UICollectionViewLayoutAttributes] = []

    // Content size
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width
    }

    // Configurable properties
    var numberOfColumns = 2
    var cellPadding: CGFloat = 6

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func prepare() {
        guard let collectionView = collectionView else { return }
        cache.removeAll()
        contentHeight = 0

        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var columnHeights = Array(repeating: CGFloat(0), count: numberOfColumns)
        var columnIndex = 0

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            let width = columnWidth - (2 * cellPadding)
            let height = delegate?.collectionView(
                collectionView,
                heightForItemAt: indexPath,
                with: width
            ) ?? 180
            let frame = CGRect(
                x: xOffset[columnIndex],
                y: columnHeights[columnIndex],
                width: columnWidth,
                height: height
            )
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            contentHeight = max(contentHeight, frame.maxY)
            columnHeights[columnIndex] += height
            columnIndex = columnHeights.firstIndex(of: columnHeights.min() ?? 0) ?? 0
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
