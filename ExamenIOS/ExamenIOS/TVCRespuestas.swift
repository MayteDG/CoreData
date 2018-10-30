//
//  TVCRespuestas.swift
//  ExamenIOS
//
//  Created by Mayte Dominguez on 10/29/18.
//  Copyright © 2018 Mayte Dominguez. All rights reserved.
//

import UIKit

class TVCRespuestas: UITableViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var LblPosicion: UILabel!
    @IBOutlet weak var lblFechadeNac: UILabel!
    @IBOutlet weak var lblAlias: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
