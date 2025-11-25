/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;


import Modelo.RegistroDTO;
import java.util.List;

/**
 *
 * @author amart
 */
public interface RegistroDAO {
     int insertarRegistro(RegistroDTO ob);
     RegistroDTO consultarRegistro(int id);
     List<RegistroDTO> listarTodos();
     public int borrar(int id);
}
