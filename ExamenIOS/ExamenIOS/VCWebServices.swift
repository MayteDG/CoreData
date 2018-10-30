//
//  VCWebServices.swift
//  ExamenIOS
//
//  Created by Mayte Dominguez on 10/29/18.
//  Copyright © 2018 Mayte Dominguez. All rights reserved.
//

import UIKit

class VCWebServices: UIViewController {
    
    @IBOutlet weak var lblview: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

    }
    override func viewDidAppear(_ animated: Bool) {
         getJson()
    }
    
    func getJson (){
        guard let url = URL (string: "http://trade.upaxer.com/ws/webresources/generic/getData")
            else {return}
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data,response, error) in
            if let response = response {
                print (response)
            }
            if let data = data {
                print(data)
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    print(json)
                    
                }catch {
                    
                  // no pude acceder a el sevicio no me respondio, entonces voy a simular que me respondio de manera correcta, usando los modelos de datos y la descripcion de la respuesta del servicio que me muestran en el manual para poder completar el ejemplo.
                    
 
                    var parametros = ParSalida()
                    parametros.code = 123
                    parametros.hashError = true
                    parametros.valueResponse = "URLdeZIp"
                    
                    self.descargaZip(parSalida: parametros)
                   
                    
                    print(error)
                }
            }
            }.resume()
        
        var parametros = ParSalida()
        parametros.code = 123
        parametros.hashError = true
        parametros.valueResponse = "URLdeZIp"
        
        self.descargaZip(parSalida: parametros)
        
    }
    
    func descargaZip(parSalida: ParSalida){
        var obDescarga:descarga = descarga()
        
        obDescarga.descargar2(parSalida.valueResponse, handler: { (textoDecomprimido:String) in
            
            DispatchQueue.main.async {
                self.lblview.text = textoDecomprimido
                
            }})
        
        
    }
    
   

}
