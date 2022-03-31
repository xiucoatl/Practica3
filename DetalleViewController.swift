//
//  DetalleViewController.swift
//  practica3
//
//  Created by DISMOV on 29/03/22.
//

import UIKit

class DetalleViewController: UIViewController {
    
    var tecladoArriba = false
    let scroll = UIScrollView()
    

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var ingredientes: UITextView!
    @IBOutlet weak var instrucciones: UITextView!
    
    var detalleDrink = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.backgroundColor = .systemBlue
        let gesto = UITapGestureRecognizer(target: self, action:#selector(desactivaTeclado))
        scroll.addGestureRecognizer(gesto)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for view in scroll.subviews {
            if view is UITextField {
                let text = view as! UILabel
                text.textColor = .blue
                text.backgroundColor = .lightGray
            }
        }
        
        nombre.text = detalleDrink["name"] as? String ?? ""
        ingredientes.text = detalleDrink["ingredients"] as? String ?? ""
        instrucciones.text = detalleDrink["directions"] as? String ?? ""
        imagen.image = UIImage(named: detalleDrink["image"] as? String ?? "")
        
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoAparece(_ :)), name:UIResponder.keyboardDidShowNotification, object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tecladoDesaparece(_ :)), name:UIResponder.keyboardWillHideNotification, object:nil)
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        /*NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            nom.topAnchor.constraint(equalTo:scroll.topAnchor, constant: 50),
            nom.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            nom.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            nom.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            app.topAnchor.constraint(equalTo:nom.bottomAnchor, constant: 50),
            app.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            app.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            app.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            apm.topAnchor.constraint(equalTo:app.bottomAnchor, constant: 50),
            apm.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            apm.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            apm.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            tel.topAnchor.constraint(equalTo:apm.bottomAnchor, constant: 50),
            tel.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            tel.trailingAnchor.constraint(equalTo: scroll.frameLayoutGuide.trailingAnchor, constant: -20),
            tel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            mel.topAnchor.constraint(equalTo:tel.bottomAnchor, constant: 50),
            mel.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 20),
            mel.widthAnchor.constraint(equalToConstant: 150),
            mel.heightAnchor.constraint(equalToConstant: 50)
        ])*/
        // el objeto contentView es el que determina si se necesita hacer scroll
        scroll.contentLayoutGuide.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: 0).isActive = true
        scroll.contentLayoutGuide.heightAnchor.constraint(equalTo:scroll.frameLayoutGuide.heightAnchor, constant: 20).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // me desuscribo del NC para no recibir notificaciones si no es la vista activa
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func desactivaTeclado() {
        self.view.endEditing(true)
    }
    
    @objc func tecladoAparece(_ notif: Notification) {
        print ("up")
        if tecladoArriba {
            return
        }
        tecladoArriba = true
        // Obtenemos el tamaño final del teclado
        if let tamanioTeclado = (notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // aumentamos el tamaño del content, para que haga scroll
            scroll.contentSize.height += tamanioTeclado.height
        }
    }
    
    @objc func tecladoDesaparece(_ notif: Notification) {
        if !tecladoArriba {
            return
        }
        tecladoArriba = false
        // Obtenemos el tamaño final del teclado
        if let tamanioTeclado = (notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // reducimos el tamaño del content, para que ya no haga scroll cuando se oculte el teclado
            scroll.contentSize.height -= tamanioTeclado.height
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
