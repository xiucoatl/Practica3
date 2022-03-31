//
//  ViewController.swift
//  practica3
//
//  Created by DISMOV on 29/03/22.
//

import UIKit

class ViewController: UITableViewController {

    var datos = [[String:Any]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        obtenInfo()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoQueYoQuiera", for: indexPath)
        let elDict = datos[indexPath.row]
        cell.textLabel?.text = elDict["name"] as? String ?? "\(indexPath.row)"
        cell.imageView?.image = UIImage(named: "drink")
        return cell
    }
    

    func obtenInfo() {
        // encuentra la ubicación en tiempo de ejecución de un archivo agregado al proyecto
        if let rutaAlArchivo = Bundle.main.url(forResource: "Drinks", withExtension: "plist") {
            do {
                let bytes = try Data(contentsOf: rutaAlArchivo)
                let tmp = try PropertyListSerialization.propertyList(from: bytes, options: .mutableContainers, format:nil)
                datos = tmp as! [[String:Any]]
            }
            catch {
                // manejar el error
                print (error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detalle", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nuevoVC = segue.destination as! DetalleViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            let DetalleDrink = datos[indexPath.row]
            nuevoVC.detalleDrink = DetalleDrink
            print(DetalleDrink)
        }
    }
    
}
