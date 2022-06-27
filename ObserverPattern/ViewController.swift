//
//  ViewController.swift
//  ObserverPattern
// https://www.youtube.com/watch?v=jFKuMb6kILU
//  Created by marco rodriguez on 27/06/22.
// Ejemplo de primer commit
//Este patron reacciona a los cambios que envia el subjet o sujeto observado
//Se puede anular la subscripcion

/*
 Subject-Observable
    attach(observer)
    detach(observer)
    notifuy()
 
 Subscriber-Observer
    update()
 */

import UIKit
import Combine //Este framework permite la programacion reactiva

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var viewModel = ViewModel()
    //Cuando se crea una subscripcion se debe de almacenar en algun lugar
    var anyCancellable: [AnyCancellable] = []
    var timer = Timer()
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptions()
        
        //Me debe permitir llamar a updateTitle
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTitle), userInfo: nil, repeats: true)
    }
    
    @objc func updateTitle(){
        count += 1
        if count > 10 {
            anyCancellable.removeAll() //se cancela la subscripcion
        }
        viewModel.updateTitle(title: "La vista aumento \(count) veces")
    }

    //Crear una suscripcion
    func subscriptions(){
        //Se esta suscribiendo
        //Evitar retencion de memoria [weak self]
        //.sink permite reaccionar a los cambios 
        viewModel.title.sink { _ in } receiveValue: {[weak self] title in
            
            self?.titleLabel.text = title
            self?.titleLabel.textColor = .blue
            
        }.store(in: &anyCancellable) //Voy a guardar la subscricion en la var anyCancellable
        
        // MARK: - Color
        viewModel.$color.sink { [weak self] color in
            self?.view.backgroundColor = color
        }.store(in: &anyCancellable) //si no se guarda no se le va a notificar
    }

}
//Dentro vamos a crear el subject o observable
class ViewModel {
    //Va a difundir la informacion
    var title = PassthroughSubject<String, Error>()
    @Published var color: UIColor = .blue
    
    
    func updateTitle(title: String){
        self.title.send(title)
        
        let colors: [UIColor] = [.black, .brown, .white, .orange, .red, .purple, .systemPink, .green, .darkGray, .systemCyan]
        color = colors[Int.random(in: 0..<colors.count)]
    }
    
}
