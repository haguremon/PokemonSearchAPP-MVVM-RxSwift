//
//  ViewController.swift
//  PokemonSearchAPP-MVVM-RxSwift
//
//  Created by IwasakIYuta on 2022/01/16.
//

import UIKit
import RxSwift
import RxCocoa

class PokemonSearchViewController: UIViewController {
    
    private let pokemonSubject = PublishSubject<PokemonViewModel>()
       
       //購読できるようにする
    var pokemonSubjectObservable: Observable<PokemonViewModel> {
           pokemonSubject.asObserver()
       }
    
    let pokemonListVM = PokemonListViewModel()
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var idTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    @IBAction func search(_ sender: Any) {
        
        guard let pokemonid = idTextField.text else { return }
        
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonid)") {
            let resource = Resource<PokemonResponse>(url: url)
            URLRequest.load(resource: resource)
                .map { pokemonResponse -> PokemonViewModel in
                    return PokemonViewModel(pokemon: pokemonResponse)
                }.subscribe { [ weak self ] pokemonVM in
                    self?.pokemonSubject.onNext(pokemonVM)
                }.disposed(by: disposeBag)

            dismiss(animated: true)
        }
        
    
    }
    

}

