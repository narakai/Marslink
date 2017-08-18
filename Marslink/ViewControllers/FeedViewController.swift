//
// Created by lai leon on 2017/8/17.
// Copyright (c) 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class FeedViewController: UIViewController {
    let loader = JournalEntryLoader()

    // 1
    let collectionView: IGListCollectionView = {
        // 2
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        // 3
        view.backgroundColor = UIColor.black
        return view
    }()

    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    let pathfinder = Pathfinder()

    override func viewDidLoad() {
        super.viewDidLoad()
        loader.loadLatest()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    //viewDidLayoutSubviews() is overridden, setting the collectionView frame to match the view bounds
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}




extension FeedViewController: IGListAdapterDataSource {
    // 1
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        var items: [IGListDiffable] = pathfinder.messages
        items += loader.entries as [IGListDiffable]
        return items
    }

    // 2
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is Message {
            return MessageSectionController()
        } else {
            return JournalSectionController()
        }
    }

    // 3
    func emptyView(for listAdapter: IGListAdapter) -> UIView? {
        return nil
    }
}
