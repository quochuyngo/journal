//
//  PlaceViewController.swift
//  Journal
//
//  Created by Quoc Huy Ngo on 5/5/18.
//  Copyright © 2018 Huy Ngo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GooglePlaces

protocol PlaceViewControllerDelegate: class {
    func didSelectPlace(_ place: Place)
}
class PlaceViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    let disposeBag = DisposeBag()
    let viewModel = PlaceViewModel(placesClient: GMSPlacesClient(), indicator: BehaviorRelay<Bool>(value: false))
    
    var delegate: PlaceViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        bindingViewModel()
    }

    func bindingViewModel() {
        let searchResult = searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Place]> in
                return query.isEmpty ? self.viewModel.getCurrentPlace() : self.viewModel.fectchPlaces(withQuery: query)
            }.observeOn(MainScheduler.instance)
        
        searchResult.bind(to: tableView.rx.items(cellIdentifier: "PlaceCell", cellType: PlaceCell.self)) {
            (index, item, cell) in
            cell.place = item
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: {
            indexPath in
            self.delegate?.didSelectPlace(self.viewModel.places[indexPath.row])
           self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        viewModel.indicator.asDriver().drive(onNext: {
            value in
            self.activityIndicator.isHidden = value
        }).disposed(by: disposeBag)
    }
    
    @IBAction func onDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
