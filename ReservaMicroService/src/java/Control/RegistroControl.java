/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Control;

import DAO.RegistroDAO;
import DAO.RegistroDAOPostgre;
import Modelo.RegistroDTO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 *
 * @author amart
 */



@WebServlet("/RegistroControl")
public class RegistroControl extends HttpServlet {
    
    private RegistroDAO registroDAO = new RegistroDAOPostgre();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener los parámetros del formulario
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String rol = request.getParameter("rol");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validar que las contraseñas coincidan
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("index.jsp?error=password_mismatch");
            return;
        }
        
        // Crear el DTO con los datos del usuario
        RegistroDTO registroDTO = new RegistroDTO(nombre, email, telefono, rol, password);
        
        // Intentar insertar el registro
        int resultado = registroDAO.insertarRegistro(registroDTO);
        
        if (resultado > 0) {
            // Registro exitoso - Crear sesión para el usuario
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("nombre", nombre);
            session.setAttribute("rol", rol);
            
            // Redirigir según el rol
            if ("conductor".equals(rol)) {
                response.sendRedirect("registro-vehiculo.jsp");
            } else if ("pasajero".equals(rol)) {
                response.sendRedirect("dashboard-pasajero.jsp");
            }
        } else {
            // Si falla el registro (email ya existe)
            response.sendRedirect("index.jsp?error=exists");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirigir al formulario de registro si acceden por GET
        response.sendRedirect("index.jsp");
    }
}
