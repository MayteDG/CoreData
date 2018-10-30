//
//  VCMostrarTable.swift
//  ExamenIOS
//
//  Created by Mayte Dominguez on 10/29/18.
//  Copyright © 2018 Mayte Dominguez. All rights reserved.
//

import UIKit
import CoreData

class VCMostrarTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var resp : [Respuestas] = []
    @IBOutlet weak var tabView: UITableView!
    
    func conexion() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      tabView.register(UINib(nibName: "TVCRespuestas", bundle: nil), forCellReuseIdentifier: "TVCRespuestas")
       tabView.dataSource = self
       tabView.dataSource = self
        mostrarDatos()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return resp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "TVCRespuestas", for: indexPath) as! TVCRespuestas
        
        let respuesta = resp[indexPath.row]
        cell.lblID?.text = String(respuesta.id)
        cell.lblNombre?.text = respuesta.nombre
        cell.lblFechadeNac?.text = respuesta.fechaNac
        cell.LblPosicion?.text = respuesta.posicion
        cell.lblAlias?.text = respuesta.alias
        
        
        return cell
    }
    
    private func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let contexto = conexion()
        let res = resp[indexPath.row]
        
        if editingStyle == .delete {
            contexto.delete(res)
            
            do{
                try contexto.save()
            }catch let error as NSError{
                print("no borro", error)
            }
            
        }
        
        mostrarDatos()
        tabView.reloadData()
        
    }
    
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
