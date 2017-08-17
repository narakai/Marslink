//
//  JournalSectionController.swift
//  Marslink
//
//  Created by lai leon on 2017/8/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import IGListKit

class JournalSectionController: IGListSectionController {
    var entry: JournalEntry!
    let solFormatter = SolFormatter()

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}


extension JournalSectionController: IGListSectionType {
    func numberOfItems() -> Int {
        return 2
    }

    func sizeForItem(at index: Int) -> CGSize {
        // 1 collectionContext is a weak variable and must be nullable
        guard let context = collectionContext, let entry = entry else { return .zero }
// 2
        let width = context.containerSize.width
// 3
        if index == 0 {
            return CGSize(width: width, height: 30)
        } else {
            return JournalEntryCell.cellSize(width: width, text: entry.text)
        }
    }

    func cellForItem(at index: Int) -> UICollectionViewCell {
        // 1
        let cellClass: AnyClass = index == 0 ? JournalEntryDateCell.self : JournalEntryCell.self
// 2
        let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
// 3
        if let cell = cell as? JournalEntryDateCell {
            cell.label.text = "SOL \(solFormatter.sols(fromDate: entry.date))"
        } else if let cell = cell as? JournalEntryCell {
            cell.label.text = entry.text
        }
        return cell
    }

    func didUpdate(to object: Any) {
        entry = object as? JournalEntry
    }

    func didSelectItem(at index: Int) {
    }
}