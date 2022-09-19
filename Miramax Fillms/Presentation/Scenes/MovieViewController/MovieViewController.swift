//
//  MovieViewController.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 12/09/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

class MovieViewController: BaseViewController<MovieViewModel> {
    
    // MARK: - Outlets + Views
    
    @IBOutlet weak var appToolbar: AppToolbar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var btnSearch: UIButton!

    // MARK: - Properties
    
    private var movieViewDataItems: [MovieViewData] = []
    
    private let retryGenreViewTriggerS = PublishRelay<Void>()
    private let retryUpComingViewTriggerS = PublishRelay<Void>()
    private let movieSelectTriggerS = PublishRelay<Movie>()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configView() {
        super.configView()
        
        btnSearch = UIButton(type: .system)
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        btnSearch.setImage(UIImage(named: "ic_toolbar_search"), for: .normal)
        
        appToolbar.delegate = self
        appToolbar.rightButtons = [btnSearch]
        
        let gridCollectionViewLayout = GridCollectionViewLayout()
        gridCollectionViewLayout.rowSpacing = 32.0
        gridCollectionViewLayout.delegate = self
        collectionView.collectionViewLayout = gridCollectionViewLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 16.0, left: 0.0, bottom: 16.0, right: 0.0)
        collectionView.register(cellWithClass: GenreHorizontalListCell.self)
        collectionView.register(cellWithClass: MovieHorizontalListCell.self)
        collectionView.register(cellWithClass: SelfieWithMovieCell.self)
        collectionView.register(cellWithClass: TabSelectionCell.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = MovieViewModel.Input(
            toSearchTrigger: btnSearch.rx.tap.asDriver(),
            retryGenreTrigger: retryGenreViewTriggerS.asDriverOnErrorJustComplete(),
            retryUpComingTrigger: retryUpComingViewTriggerS.asDriverOnErrorJustComplete(),
            movieSelectTrigger: movieSelectTriggerS.asDriverOnErrorJustComplete()
        )
        let output = viewModel.transform(input: input)
        
        output.movieViewDataItems
            .drive(onNext: { [weak self] items in
                guard let self = self else { return }
                self.movieViewDataItems = items
                self.collectionView.reloadData()
            })
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - AppToolbarDelegate

extension MovieViewController: AppToolbarDelegate {
    func appToolbar(onBackButtonTapped button: UIButton) {
        
    }
}

// MARK: - UICollectionViewDataSource

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieViewDataItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieViewData = movieViewDataItems[indexPath.row]
        switch movieViewData {
        case .genreViewState(viewState: let viewState):
            let cell = collectionView.dequeueReusableCell(withClass: GenreHorizontalListCell.self, for: indexPath)
            cell.bind(viewState)
            cell.delegate = self
            return cell
        case .upComingViewState(viewState: let viewState):
            let cell = collectionView.dequeueReusableCell(withClass: MovieHorizontalListCell.self, for: indexPath)
            cell.bind(viewState, headerTitle: "Upcoming")
            cell.delegate = self
            return cell
        case .selfieWithMovie:
            let cell = collectionView.dequeueReusableCell(withClass: SelfieWithMovieCell.self, for: indexPath)
            cell.delegate = self
            return cell
        case .tabSelection:
            let cell = collectionView.dequeueReusableCell(withClass: TabSelectionCell.self, for: indexPath)
            cell.bind(["Top rating", "News", "Trending"], selectIndex: 1)
            return cell
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension MovieViewController: UICollectionViewDelegate {
    
}

// MARK: - GridCollectionViewLayoutDelegate

extension MovieViewController: GridCollectionViewLayoutDelegate {
    func numberOfColumns(_ collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, columnSpanForItemAt index: GridIndex, indexPath: IndexPath) -> Int {
        let movieViewData = movieViewDataItems[indexPath.row]
        switch movieViewData {
        case .genreViewState, .upComingViewState, .selfieWithMovie, .tabSelection:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt index: GridIndex, indexPath: IndexPath) -> CGFloat {
        let movieViewData = movieViewDataItems[indexPath.row]
        switch movieViewData {
        case .genreViewState:
            return 50.0
        case .upComingViewState:
            return 200.0
        case .selfieWithMovie:
            return 190.0
        case .tabSelection:
            return 40.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForRow row: Int, inSection section: Int) -> GridCollectionViewLayout.RowHeight {
        .maxItemHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForSupplementaryView kind: GridCollectionViewLayout.ElementKind, at section: Int) -> CGFloat? {
        nil
    }
    
    func collectionView(_ collectionView: UICollectionView, alignmentForSection section: Int) -> GridCollectionViewLayout.Alignment {
        .center
    }
    
}

// MARK: - MovieGenreListCellDelegate

extension MovieViewController: GenreHorizontalListCellDelegate {
    func genreHorizontalListRetryButtonTapped() {
        retryGenreViewTriggerS.accept(())
    }
    
    func genreHorizontalList(onItemTapped genre: Genre) {
        
    }
    
}

// MARK: - MovieHorizontalListCellDelegate

extension MovieViewController: MovieHorizontalListCellDelegate {
    func movieHorizontalListRetryButtonTapped() {
        retryUpComingViewTriggerS.accept(())
    }
    
    func movieHorizontalList(onItemTapped item: PresenterModelType) {
        if let movie = item as? Movie {
            movieSelectTriggerS.accept(movie)
        }
    }
    
    func movieHorizontalListSeeMoreButtonTapped() {
        
    }
}

// MARK: - SelfieWithMovieCellDelegate

extension MovieViewController: SelfieWithMovieCellDelegate {
    func selfieWithMovieCellChooseFrameButtonTapped() {
        
    }
}

// MARK: - TabSelectionCellDelegate

extension MovieViewController: TabSelectionCellDelegate {
    func tabSelectionCell(onTabSelected index: Int) {
        
    }
}
