//
//  ViewController.swift
//  ObserverPattern
//
//  Created by marco rodriguez on 27/06/22.
// Ejemplo de primer commit

import UIKit
import Combine //Este framework permite la programacion reactiva

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
    }

    //Crear una suscripcion
    func subscriptions(){
        viewModel.title.sink { _ in
            
        } receiveValue: { title in
            //Reaccionar a los cambios
        }

    }

}
//Dentro vamos a crear el subject o observable
class ViewModel {
    //Va a difundir la informacion
    var title = PassthroughSubject<String, Error>()
    
    var titulo: String!
    
    
    func updateTitle(title: String){
        self.title.send(title)
    }
    
}
