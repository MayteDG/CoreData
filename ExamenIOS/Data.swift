//
//  Data.swift
//  ExamenIOS
//
//  Created by Mayte Dominguez on 10/29/18.
//  Copyright © 2018 Mayte Dominguez. All rights reserved.
//

import Foundation
import UIKit

class ParSalida {
    var code : Int = 0
    var hashError : Bool = false
    var valueResponse : String = ""
}

class  descarga {
    func descargar ( URL: String ) -> String {
        
        
        
        return "Descargado"
    }
    
    func descargar2(_ url: String, handler: @escaping (String)-> () ) {
        
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("FileZip.zip")
        
        //se descomprime y extrae el texto.
        //me falto tiempo para probar, pero el metodo posterior a la llamada del bloque descarga un archivo y lo coloca en los documetnos de la aplicacion
         handler("Texto Obtenido de el Zip")
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: url)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    
                    //guardamos el archivo en los docuentos
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    print(tempLocalUrl)
                    
                    
                    handler("Texto Obtenido de el Zip")
                    
                    //el siguiente codigo obtiene un elemento de los documents y los usa, me falto adaptarlo para decomprimir el zip despues de descargado y leer el texto del archivo que se descomprime.
                    /*
                    let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
                    let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
                    let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
                    
                    if let dirPath          = paths.first
                    {
                        let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("downloadedFile3.jpg")
                        print(imageURL)
                        let image    = UIImage(contentsOfFile: imageURL.path)
                        // Do whatever you want with the image
                    }
                    */
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()
        
    }
}


