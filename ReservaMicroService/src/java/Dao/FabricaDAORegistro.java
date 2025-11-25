/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author amart
 */
public class FabricaDAORegistro extends FabricaDAO {

    @Override
    public RegistroDAO crearRegistroDAO(String tipo) {

        if ("POSTGRE".equalsIgnoreCase(tipo)) {
            return new RegistroDAOPostgre();
        } else {
            return new RegistroDAOMongo();
        }

        
    }
}
