//
//  VCCollection.swift
//  ExamenIOS
//
//  Created by Adrian Pascual Dominguez on 11/22/18.
//  Copyright © 2018 Adrian Pascual Dominguez. All rights reserved.
//

import UIKit
import CoreData

class VCCollection: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
  
    var resp : [Respuestas] = []
    
    @IBOutlet weak var collection: UICollectionView!
    
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
     
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      collection.delegate = self
      collection.dataSource = self
      collection.register(UINib(nibName: "CVCell", bundle: nil), forCellWithReuseIdentifier: "CVCell")
   
        
       /* let layout = self.regresaConfiguraciondeELEmentosdelCollection()
        collection.collectionViewLayout = layout*/
        
        mostrarDatos()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
        
       
        let otra = resp[indexPath.row]
        cell.lblNombre.text = otra.value(forKeyPath: "nombre") as? String
        cell.lblApellido.text = otra.value(forKeyPath: "posicion") as? String
       
        print (otra)
        return cell
    }
    
  /*
    func regresaConfiguraciondeELEmentosdelCollection()-> UICollectionViewLayout{
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        //layout.minimumInteritemSpacing = 0.1
        let size = CGSize(width: collection.frame.size.width, height: collection.frame.size.height)
        layout.sectionInset = UIEdgeInsets (top: 0, left: 5, bottom: 0, right: 5)
        layout.itemSize = size
        
        
        return layout
        
    }*/
    

    func mostrarDatos(){
        let contexto = conexion()
        
        let fetchRequest : NSFetchRequest<Respuestas> = Respuestas.fetchRequest()
        
        do {
            resp = try contexto.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("no mostro nada", error)
        }
     
    }
    

}
