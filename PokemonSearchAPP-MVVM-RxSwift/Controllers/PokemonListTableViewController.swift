//
//  PokemonListTableViewController.swift
//  PokemonSearchAPP-MVVM-RxSwift
//
//  Created by IwasakIYuta on 2022/01/16.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class PokemonListTableViewController: UITableViewController {

    let disposeBag = DisposeBag()

    private var pokemonListVM = PokemonListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        pokemonListVM.numberOfRows(section)
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonTableViewCell
        
        let pokemonVM = pokemonListVM.modelAt(indexPath.row)
        
        pokemonVM.name.asDriver(onErrorJustReturn: "").drive(cell.imagenmaeLabel.rx.text)
            .disposed(by: disposeBag)
    
        pokemonVM.types.asDriver(onErrorJustReturn: "")
            .drive(cell.typeLabel.rx.text)
            .disposed(by: disposeBag)

        pokemonVM.pokemonImageUrl.asDriver(onErrorJustReturn: UIImage())
            .drive(cell.searchImage.rx.image)
            .disposed(by: disposeBag)
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        guard let pokemonSearchViewController = nav.viewControllers.first as? PokemonSearchViewController else {
            fatalError("PokemonSearchViewController not found")
        }
        pokemonSearchViewController.pokemonSubjectObservable.subscribe { [ weak self ] pokemonViewModel in
            
            guard let pokemonViewModel = pokemonViewModel.element else { return print("error") }
        
            
            self?.pokemonListVM.addPokemonViewModel(pokemonViewModel)
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }.disposed(by: disposeBag)
    }
    


    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
