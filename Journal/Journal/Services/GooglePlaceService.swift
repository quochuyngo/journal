//
//  GooglePlaceService.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 9/28/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import GooglePlaces
import RxSwift
protocol GooglePlaceServiceProtocol {
    func getCurrentPlaces() -> Observable<[Place]>
    func getPlaces(with query: String) -> Observable<[Place]>
}

class GooglePlaceService: GooglePlaceServiceProtocol {
    let placesClient: GMSPlacesClient = GMSPlacesClient()
    
    func getCurrentPlaces() -> Observable<[Place]> {
        return Observable.create { observer -> Disposable in
            self.placesClient.currentPlace {
                (locations, error) in
                if let error = error {
                    observer.onError(error)
                    observer.onCompleted()
                }
                var places = [Place]()
                locations?.likelihoods.forEach {
                    likelihood in
                    places.append(Place(title: likelihood.place.name, address: likelihood.place.formattedAddress ?? ""))
                }
                observer.onNext(places)
                observer.onCompleted()
            }
            
            return Disposables.create {}
        }
    }
    
    func getPlaces(with query: String) -> Observable<[Place]> {
        return Observable.create { observer -> Disposable in
            self.placesClient.autocompleteQuery(query, bounds: nil, filter: nil) {
                (results, error) in
                if let error = error {
                    observer.onError(error)
                    observer.onCompleted()
                }
                guard let results = results else { return }
                let places = results.map { place in
                    Place(title: place.attributedPrimaryText.string, address: (place.attributedSecondaryText?.string)!)
                }
                observer.onNext(places)
                observer.onCompleted()
            }
            
            return Disposables.create {}
        }
    }
}
