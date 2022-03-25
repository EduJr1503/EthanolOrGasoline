//
//  ViewController.swift
//  EthanolOrGasoline
//
//  Created by Eduardo Junior on 23/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultadoLegenda: UILabel!
    @IBOutlet weak var precoAlcoolCampo: UITextField!
    @IBOutlet weak var precoGasolinaCampo: UITextField!
    
    
    @IBAction func calcularCombustivel(_ sender: Any) {
        
        if let precoAlcool = precoAlcoolCampo.text {
            if let precoGasolina = precoGasolinaCampo.text {
                
                //validar valores digitados
                let validaCampos = self.validarCampos(precoAlcool: precoAlcool, precoGasolina: precoGasolina)
                if validaCampos {
                    //calcular melhor combustível
                    self.calcularMelhorPreco(precoAlcool: precoAlcool, precoGasolina: precoGasolina)
                }else {
                    resultadoLegenda.text = "Digite os preços para calcular!"
                }
           }
        }
    }
    
    func calcularMelhorPreco(precoAlcool: String, precoGasolina: String){
        var precoAlcoolFiltrado = precoAlcool
        if (precoAlcoolFiltrado.contains(",")) {
            precoAlcoolFiltrado = precoAlcoolFiltrado.replacingOccurrences(of: ",", with: ".")
        }
        
        var precoGasolinaFiltrado = precoGasolina
        if (precoGasolinaFiltrado.contains(",")) {
            precoGasolinaFiltrado = precoGasolinaFiltrado.replacingOccurrences(of: ",", with: ".")
        }
        
        //converte valores textos para números
        if let valorAlcool = Double(precoAlcoolFiltrado) {
        if let valorGasolina = Double(precoGasolinaFiltrado) {
            
             /* Faz cálculo (precoAlcool/precogasolina)
             * Se resultado => 0.7 melhor utilizar gasolina
             * Senão melhor utilizar Álcool */
            
            let resultadoPreco = valorAlcool / valorGasolina
            if resultadoPreco >= 0.7 {
                self.resultadoLegenda.text = "Melhor utilizar Gasolina!"
            }else {
                self.resultadoLegenda.text = "Melhor utilizar Etanol!"
                }
            }
        }
    }
    
    func validarCampos(precoAlcool: String, precoGasolina: String) -> Bool {
        var camposValidados = true
        
        if precoAlcool.isEmpty {
            camposValidados = false
        }else if precoGasolina.isEmpty {
            camposValidados = false
        }
        return camposValidados
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

