# Miramax Films iOS Clean Architecture

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-) [![Build CI](https://github.com/hoc081098/ComicReaderApp_MVI_Coroutine_RxKotlin_Jetpack/actions/workflows/build.yml/badge.svg)](https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/actions/workflows/AppBuild.yml) [![Releases](https://img.shields.io/github/release/nextcloud/ios.svg)](https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/releases/latest) [![SwiftLint](https://github.com/nextcloud/ios/actions/workflows/lint.yml/badge.svg)](https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/actions/workflows/SwiftLint.yml)

# Content
- [Screenshots](#screenshots)
- [Project features](#project-features)
- [Technologies](#technologies)
- [Server and API](#server-and-api)

# Screenshots
<pre>
<img src="https://raw.githubusercontent.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/main/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-22%20at%2014.15.02.png" width="250">&nbsp; <img src="https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/blob/main/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-22%20at%2014.15.04.png?raw=true" width="250">&nbsp; <img src="https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/blob/main/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-22%20at%2014.15.06.png?raw=true" width="250">&nbsp; <img src="https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/blob/main/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-22%20at%2014.15.09.png?raw=true" width="250">&nbsp; <img src="https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/blob/main/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-22%20at%2014.15.15.png?raw=true" width="250">&nbsp; <img src="https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/blob/main/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-22%20at%2014.18.05.png?raw=true" width="250">&nbsp; <img src="https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/blob/main/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-22%20at%2014.16.44.png?raw=true" width="250">&nbsp; <img src="https://github.com/chotchachi/Miramax-Films-iOS-Clean-Architecture/blob/main/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-02-22%20at%2014.16.47.png?raw=true" width="250">&nbsp;
</pre>

# Project features
- [x] General Features: Top rated, Upcoming, Now playing, Popular Movies. Popular, Top rated, On the air, Airing today TV Shows
- [x] Search Movie, TV Show and People
- [x] Discover with filters or definable values
- [x] View Movie, TV Show details: Primary info, cast, crew, images, plot keywords, release information, trailers, similar movies, v.v
- [x] View TV Show Season & Episode
- [x] View People details: Primary info, credits (movie, TV and combined), images
- [x] View list Genre
- [x] Bookmark Movie, TV Show or People
- [ ] View Movie, TV Show reviews

# Technologies
- [x] Clean architecture with MVVM
- [x] Dependency injection [Swinject](https://github.com/Swinject/Swinject)
- [x] Coordinator Pattern [XCoordinator](https://github.com/QuickBirdEng/XCoordinator)
- [x] Reactive Programming [RxSwift](https://github.com/ReactiveX/RxSwift)
- [x] [Alamofire](https://github.com/Alamofire/Alamofire) with Network abstraction layer [Moya](https://github.com/Moya/Moya)
- [x] [Realm](https://github.com/realm/realm-swift) database with [RxRealm](https://github.com/RxSwiftCommunity/RxRealm) extensions
- [x] JSON Object mapping [ObjectMapper](https://github.com/tristanhimmelman/ObjectMapper)
- [x] Programmatically UI [SnapKit](https://github.com/SnapKit/SnapKit)
- [ ] Google ads implementation, can be enabled/disabled from settings ([Firebase AdMob](https://firebase.google.com/docs/admob/ios/quick-start))
- [ ] Add tests

# Server and API
The Movie DB: https://api.themoviedb.org/