//
//  HomeCoordinator.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 12/09/2022.
//

import XCoordinator

enum HomeTabRoute: Route {
    case movie
//    case tvShow
//    case geners
//    case wishlist
//    case setting
}

class HomeCoordinator: TabBarCoordinator<HomeTabRoute> {
    private let movieRoute: StrongRouter<MovieRoute>

    init() {
        let movieCoordinator = MovieCoordinator(rootViewController: MovieViewController())
        movieCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        movieRoute = movieCoordinator.strongRouter
        super.init(rootViewController: HomeViewController(), tabs: [movieRoute], select: movieRoute)
    }
    
    override func prepareTransition(for route: HomeTabRoute) -> TabBarTransition {
        switch route {
        case .movie:
            return .select(movieRoute)
//        case .tvShow:
//            <#code#>
//        case .geners:
//            <#code#>
//        case .wishlist:
//            <#code#>
//        case .setting:
//            <#code#>
        }
    }
}