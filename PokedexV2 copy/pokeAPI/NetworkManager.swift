//
//  NetworkManager.swift
//  PokedexV2
//
//  Created by Quinn Wienke on 7/26/23.
//

import Foundation
import UIKit

//MARK: Set up network request using this pattern
/*
 Set up your data model
 Specify your URL
 Construct the request
 Execute the request in a data task
 */

//HTTP enum... Use this later in request method
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}



//Here is making the request. NetworkManager is being used to handle the api request and communication logic.
class NetworkManager {
    static let shared = NetworkManager()
    ///allows NetworkManager to be used throughout rest of app
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    ///Base URL for applicaion minus the {id or name} section
    var pokemon: PokemonData?
    ///stores the pokemon that we fetch from the api
    
    
    func getPokemon(with searchText: String) {
        ///this is gettting the pokemon that is wanted in a type of string, When this is called that string will be passed into the url to fetch the correct pokemon from the api
        
        let requestURL = baseURL.appendingPathComponent(searchText)
        ///This line is creating a new URL called requestURL that takes the original URL (baseURL) that was created earlier and using appendigPathComponent in order to take the searchText string created above to add to the last part of the URL in order to get the correct request from the API. (ex:http://poke-api.vapor.cloud/api/v2/pokemon/butterfree)
        var request = URLRequest(url: requestURL)
        ///URLRequest is used to encapsulate the information needed to make a specefic request to a URL. It also allows you to chage specefic parts of the URL. THis is useful because in order to use a search function with the API you need to modiy the end of the URL. the request takes this and accepts the URL as input.
        request.httpMethod = HTTPMethod.get.rawValue
        ///using the HTTPMethod used earlier, this is defining that the request is needed to be used as a get
        ///

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            ///This line is calling the dataTask method, which takes the contents of a URL and turns it into a data object( which helps in the reading and writing of data as well as the ability to convert to a string) in order to pass in our 'request' as the input.
            ///the three values, data, _, error, are used. Data is used to get back the response from the api. the second is just left out where as error is uesd to hadle any errors. These are called below to tell the computer what to do.
            if let error = error {
                print("Error fetching pokemon: \(error)")
                return
            }
            guard let data = data else { return }
            ///These 2 lines check to see if there are any errors or if there is any data present. If both of these complete then the next step is started
        
            //Decode JSON to a swift objetct
            ///Assuming there is no error and there is data then this code will run.
            do {
                let pokemon = try JSONDecoder().decode(PokemonData.self, from: data)
                ///This proprety is created in order to accept the data from the request. This is why the pokemon struct needed to conform to decodable.
                self.pokemon = pokemon
                print(pokemon.name)
                
                //convert results to a dictionary to be used in swift
                var pokemonDictionary: [String: String] = [:]
                for pokemon in pokemon.results {
                    pokemonDictionary[pokemon.name] = pokemon.url
                }
                
                print(pokemonDictionary)
                
            } catch {
                print("Error decoding Pokemon: \(error)")
                return
            }
        
        }.resume()
    }

}


