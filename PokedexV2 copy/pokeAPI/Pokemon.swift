//
//  Pokemon.swift
//  PokedexV2
//
//  Created by Quinn Wienke on 7/26/23.
//

import Foundation

//Create struct to model data called from api
struct PokemonData: Decodable /* decodable allows you to decode the data from the external source, in this case the pokeapi, and be able to use it in ios */ {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let order: Int
    ///Create new constants
    let abilities: [Ability]
    let moves: [Move]
    let types: [PokeType]
    let results: [Pokemon]
    
    ///add sprites
    let sprites: Sprite
}

//Create structs for constants in order to pull them from the JSON
/// To do this we need to nest these structs. At the highest level the Pokemon struct is grabbing info for the abilities,
///next the Ability struct grabes the layer beneath to get the abilitiy dicrionary from the api.
struct Ability: Decodable {
    let ability: AbilityName
}
///Now inside the array at the first element we need to go one level deeper and gather the name info
struct AbilityName: Decodable {
    let name: String
}

struct Move: Decodable {
    let move: MoveName
}
struct MoveName: Decodable {
    let name: String
}

struct PokeType: Decodable {
    let type: TypeName
}
struct TypeName: Decodable {
    let name: String
}

struct Pokemon: Decodable {
    let name: String
    let url: String
}

///add the Sprite struct
struct Sprite: Decodable {
    let frontDefault: URL
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
