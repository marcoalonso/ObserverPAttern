//
//  ViewController.swift
//  ObserverPattern
//
//  Created by marco rodriguez on 27/06/22.
// Ejemplo de primer commit
//Este patron reacciona a los cambios que envia el subjet o sujeto observado


import UIKit
import Combine //Este framework permite la programacion reactiva

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var viewModel = ViewModel()
    //Cuando se crea una subscripcion se debe de almacenar en algun lugar
    var anyCancellable: [AnyCancellable] = []
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        
        //Me debe permitir llamar a updateTitle
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTitle), userInfo: nil, repeats: true)
    }
    
    @objc func updateTitle(){
        viewModel.updateTitle(title: "Marco Alonso")
    }

    //Crear una suscripcion
    func subscriptions(){
        //Se esta suscribiendo
        //Evitar retencion de memoria [weak self]
        
        viewModel.title.sink { _ in } receiveValue: {[weak self] title in
            //Reaccionar a los cambios
            self?.titleLabel.text = title
            self?.titleLabel.textColor = .blue
            
        }.store(in: &anyCancellable) //Voy a guardar la subscricion en la var anyCancellable

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
