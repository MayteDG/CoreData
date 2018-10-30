//
//  VCCoreData.swift
//  ExamenIOS
//
//  Created by Mayte Dominguez on 10/29/18.
//  Copyright © 2018 Mayte Dominguez. All rights reserved.
//

import UIKit
import CoreData

class VCCoreData: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
   
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtfechadeNacimiento: UITextField!
    @IBOutlet weak var txtPosicion: UITextField!
    @IBOutlet weak var txtalias: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     showDatePicker()
    
    }
    
    func conexionCoreData () -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    //Configuración DatePicker
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Aceptar", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtfechadeNacimiento.inputAccessoryView = toolbar
        txtfechadeNacimiento.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtfechadeNacimiento.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func btnGuardar(_ sender: Any) {
      
        let contexto = conexionCoreData()
        
        let entidaddeRespuestas = NSEntityDescription.entity(forEntityName: "Respuestas", in: contexto)
        
        let nuevaRespuesta = NSManagedObject(entity: entidaddeRespuestas!, insertInto: contexto)
        
        let ID = Int16(txtID.text!)
    
        nuevaRespuesta.setValue( ID , forKey: "id")
        nuevaRespuesta.setValue( txtNombre.text , forKey: "nombre")
        nuevaRespuesta.setValue(txtfechadeNacimiento.text, forKey: "fechaNac")
        nuevaRespuesta.setValue(txtPosicion.text, forKey: "posicion")
        nuevaRespuesta.setValue(txtalias.text, forKey: "alias")
        
        do {
            try contexto.save()
            print ("Guardado")
            txtID.text = "" // INT
            txtNombre.text = "" //String
            txtfechadeNacimiento.text = "" //Date
            txtPosicion.text = "" //String
            txtalias.text = ""  // String
        } catch let error as NSError {
            print("No se pudo guardar",error)
        }
    }
    

}
