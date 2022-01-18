//
//  PokemonListVIewModel.swift
//  PokemonSearchAPP-MVVM-RxSwift
//
//  Created by IwasakIYuta on 2022/01/18.
//

import Foundation
import RxSwift
import UIKit


class PokemonListViewModel {
    
    var pokemonViewModels = [PokemonViewModel]()
    
    //PokemonViewModelsにデータを追加する処理
     func addPokemonViewModel(_ vm: PokemonViewModel) {
        pokemonViewModels.append(vm)
    }
    //これでデータの数を取得
    func numberOfRows(_ section: Int) -> Int {
        return pokemonViewModels.count
    }
    
    //これで特定の情報の取得に成功する
    func modelAt(_ index: Int) -> PokemonViewModel {
        return pokemonViewModels[index]
    }
}

//一つのボケモンデータを作成する
class PokemonViewModel {
    
    let pokemon: PokemonResponse
    
    //初期化にPokemonResponseが必要(JSONがswiftに変更されたクラス)
    init(pokemon: PokemonResponse ) {
        
        self.pokemon = pokemon
        
    }

}

extension PokemonViewModel {
    //それぞれObservableで返す事ができる
    var name: Observable<String> {
        Observable<String>.just(pokemon.name)
    }
    var pokemonImageUrl: Observable<UIImage?> {
        
        guard let imageUrl = URL(string: pokemon.sprites.frontDefault) else { fatalError("imageurl not found") }
        do {
        let imagedata = try Data(contentsOf: imageUrl)
            return Observable<UIImage?>.just(UIImage(data: imagedata))
        } catch {
            print(error.localizedDescription)
        }
        return Observable<UIImage?>.just(UIImage())
    }
    
    var types: Observable<String> {
        return pokemon.types.count > 1 ? Observable.just(pokemon.types.first!.type.name + "," + pokemon.types.last!.type.name) : Observable.just(pokemon.types.first!.type.name)
    }
    
}
