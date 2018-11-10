//
//  PlaceViewModel.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/2/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import RxSwift
import RxCocoa
import GooglePlaces

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class PlaceViewModel: ViewModelType {
    
    let googlePlaceService: GooglePlaceServiceProtocol
    let indicator: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    let errorTrigger: BehaviorRelay<Error?> = BehaviorRelay(value: nil)
    var places: [Place] = []
    var placeEdit: Place?
    
    init (googlePlaceService: GooglePlaceServiceProtocol = GooglePlaceService()) {
        self.googlePlaceService = googlePlaceService
    }
    
    struct Input {
        let searchQuery: Observable<String>
    }
    
    struct Output {
        let searchResult: Observable<[Place]>
        let indicator: Driver<Bool>
        let errorTrigger: Driver<Error?>
    }
    
    func transform(input: PlaceViewModel.Input) -> PlaceViewModel.Output {
        
        let handleGetPlace = Observable.combineLatest(input.searchQuery, Observable.just(isUserEnableService), Observable.just(Reachability.isConnectedToNetwork()))
        
        let result = handleGetPlace
            .flatMapLatest { (query, isUserEnableService ,isNetworkAvailable) -> Observable<[Place]> in
                if !isNetworkAvailable {
                    self.errorTrigger.accept(JError.noInternetConnection)
                    return Observable.just([])
                } else if !isUserEnableService {
                    self.errorTrigger.accept(JError.userNotAllowUsingLocation)
                    return Observable.just([])
                } else {
                    return query.isEmpty ? self.getPlacesAtCurrentLocation() : self.getPlaces(withQuery: query)
                }
            }
        
        return Output(searchResult: result, indicator: indicator.asDriver(), errorTrigger: errorTrigger.asDriver())
    }
    
    private func getPlacesAtCurrentLocation() -> Observable<[Place]> {
        return googlePlaceService.getCurrentPlaces()
            .do(onNext: { places in
                self.places = places
                self .indicator.accept(true)
            }, onError: { error in
                self.errorTrigger.accept(error)
                self.indicator.accept(true)
            })
    }
    
    private func getPlaces(withQuery query: String) -> Observable<[Place]> {
        return googlePlaceService.getPlaces(with: query)
            .do(onNext: { places in
                self.places = places
                self.indicator.accept(true)
            }, onError: { error in
                self.errorTrigger.accept(error)
                self.indicator.accept(true)
            })
    }
    
    var isUserEnableService: Bool {
        if let _ = checkUserEnableService() {
            return false
        }
        return true
    }
    func checkUserEnableService() -> Error? {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                return NSError(domain: "User have not enable location service yet", code: 101, userInfo: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                return nil
            }
        } else {
            print("Location services are not enabled")
            return NSError(domain: "Location services are not enabled", code: 100, userInfo: nil)
        }
    }
}
