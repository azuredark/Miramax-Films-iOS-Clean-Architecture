//
//  SelfieMovieViewController.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 15/10/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Domain
import SwifterSwift

fileprivate let kFrameCellPerRow: Int = 2

class SelfieMovieViewController: BaseViewController<SelfieMovieViewModel> {
    
    // MARK: - Outlets + Views
    
    @IBOutlet weak var appToolbar: AppToolbar!
    
    @IBOutlet weak var viewRecently: UIView!
    @IBOutlet weak var recentCollectionView: UICollectionView!
    
    @IBOutlet weak var tabLayout: TabLayout!
    @IBOutlet weak var frameCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var selfieFrameData: [SelfieFrame] = []
    
    private let selfieTabTriggerS = PublishRelay<SelfieMovieTab>()
    
    // MARK: - Lifecycle
    
    override func configView() {
        super.configView()
        
        configureAppToolbar()
        configureTabLayout()
        configureFrameCollectionView()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = SelfieMovieViewModel.Input(dismissTrigger: appToolbar.rx.backButtonTap.asDriver())
        let output = viewModel.transform(input: input)
        
        let frameDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SelfieFrame>> { datasource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withClass: SelfieFramePreviewCollectionViewCell.self, for: indexPath)
            cell.bind(item)
            return cell
        }
        
        output.selfieFrameData
            .do(onNext: { [weak self] items in
                self?.selfieFrameData = items
            })
            .map { [SectionModel(model: "", items: $0)] }
            .drive(frameCollectionView.rx.items(dataSource: frameDataSource))
            .disposed(by: rx.disposeBag)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        frameCollectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - Private functions

extension SelfieMovieViewController {
    private func configureAppToolbar() {
        appToolbar.title = "selfie_movie".localized
        appToolbar.showBackButton = true
    }
    
    private func configureTabLayout() {
        tabLayout.titles = SelfieMovieTab.allCases.map { $0.title }
        tabLayout.scrollStyle = .scrollable
        tabLayout.delegate = self
        tabLayout.selectionTitle(index: SelfieMovieTab.defaultTab.index ?? 1, animated: false)
    }
    
    private func configureFrameCollectionView() {
        let collectionViewLayout = CollectionViewWaterfallLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        collectionViewLayout.minimumColumnSpacing = 16.0
        collectionViewLayout.minimumInteritemSpacing = 16.0
        collectionViewLayout.delegate = self
        frameCollectionView.collectionViewLayout = collectionViewLayout
        frameCollectionView.register(cellWithClass: SelfieFramePreviewCollectionViewCell.self)
    }
}

// MARK: - TabLayoutDelegate

extension SelfieMovieViewController: TabLayoutDelegate {
    func didSelectAtIndex(_ index: Int) {
        if let tab = SelfieMovieTab.element(index) {
            selfieTabTriggerS.accept(tab)
        }
    }
}

// MARK: - CollectionViewWaterfallLayoutDelegate

extension SelfieMovieViewController: CollectionViewWaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard let image = try? UIImage(url: selfieFrameData[indexPath.row].previewURL),
              let collectionViewLayout = collectionView.collectionViewLayout as? CollectionViewWaterfallLayout else { return .zero }
        
        let imageRatio = image.size.height / image.size.width
        
        let marginsAndInsets = collectionViewLayout.sectionInset.left
        + collectionViewLayout.sectionInset.right
        + CGFloat(collectionViewLayout.minimumColumnSpacing) * CGFloat(kFrameCellPerRow - 1)
        
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(kFrameCellPerRow)).rounded(.down)
        let itemHeight = itemWidth * imageRatio
        + 38.0 // apply button height with padding top
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}