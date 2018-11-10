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
    let viewModel = PlaceViewModel()
    
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
        let input = PlaceViewModel.Input(searchQuery: searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged())
        
        let output = viewModel.transform(input: input)
        
        output.searchResult
            .observeOn(MainScheduler.instance)
            .catchError { error -> Observable<[Place]> in
                if let jerror = error as? JError {
                    self.warningLabel.text = jerror.description()
                }
                return Observable.just([])
            }
            .bind(to: tableView.rx.items(cellIdentifier: "PlaceCell", cellType: PlaceCell.self)) {
            (index, item, cell) in
            cell.place = item
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: {
            indexPath in
            self.delegate?.didSelectPlace(self.viewModel.places[indexPath.row])
           self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        output.indicator.drive(onNext: {
            value in
            self.activityIndicator.isHidden = value
        }).disposed(by: disposeBag)
    
        output.errorTrigger.drive(onNext: {
            error in
            self.warningLabel.isEnabled = (error == nil) ? true : false
            self.warningLabel.text = error?.localizedDescription
        }).disposed(by: disposeBag)
    }
    
    @IBAction func onDone(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

