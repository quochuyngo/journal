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

class PlaceViewModel {
    let placesClient: GMSPlacesClient!
    let indicator: BehaviorRelay<Bool>
    var places: [Place] = []
    init (placesClient: GMSPlacesClient, indicator: BehaviorRelay<Bool>) {
        self.placesClient = placesClient
        self.indicator = indicator
    }
    
    func getCurrentPlace() -> Observable<[Place]> {
        indicator.accept(false)
        return Observable.create { observer -> Disposable in
            self.placesClient.currentPlace {
                (locations, error) in
                if let error = error {
                    self.indicator.accept(true)
                    observer.onError(error)
                    observer.onCompleted()
                }
                var places = [Place]()
                locations?.likelihoods.forEach {
                    likelihood in
                    places.append(Place(title: likelihood.place.name, address: likelihood.place.formattedAddress ?? ""))
                }
                self.indicator.accept(true)
                self.places = places
                observer.onNext(places)
                observer.onCompleted()
            }
            return Disposables.create {}
        }
    }
    
    func fectchPlaces(withQuery query: String) -> Observable<[Place]> {
        return Observable.create { observer -> Disposable in
           self.indicator.accept(false)
           self.placesClient.autocompleteQuery(query, bounds: nil, filter: nil) {
            (results, error) in
                if let error = error {
                    self.indicator.accept(true)
                    observer.onError(error)
                    observer.onCompleted()
                }
                guard let results = results else { return }
                let places = results.map { place in
                    Place(title: place.attributedPrimaryText.string, address: (place.attributedSecondaryText?.string)!)
                }
                self.indicator.accept(true)
                self.places = places
                observer.onNext(places)
                observer.onCompleted()
            }
            return Disposables.create {}
        }
    }
}
