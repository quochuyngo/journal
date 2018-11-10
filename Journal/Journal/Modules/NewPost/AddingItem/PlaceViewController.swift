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
    @IBOutlet weak var warningLabel: UILabel!
    
    let disposeBag = DisposeBag()
    let viewModel = PlaceViewModel(placesClient: GMSPlacesClient(), indicator: BehaviorRelay<Bool>(value: false), warningError: BehaviorRelay<Bool>(value: true))
    
    weak var delegate: PlaceViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        searchBar.becomeFirstResponder()
        if let place = viewModel.placeEdit {
            searchBar.text = place.title
        }
        bindingViewModel()
    }
    
    deinit {
        print("deinit PlaceVC")
    }

    func bindingViewModel() {
        let searchResult = searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<[Place]> in
                guard let strongSelf = self else { return Observable.just([])}
                
                return query.isEmpty ? strongSelf.viewModel.getCurrentPlace() : strongSelf.viewModel.fectchPlaces(withQuery: query)
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
    
        viewModel.warningError.asDriver().drive(onNext: {
            value in
            self.warningLabel.isHidden = value
        }).disposed(by: disposeBag)
    }
    
    @IBAction func onDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
