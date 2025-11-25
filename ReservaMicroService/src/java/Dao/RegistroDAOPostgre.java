/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Modelo.RegistroDTO;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RegistroDAOPostgre implements RegistroDAO {

   private static final String URL = "jdbc:postgresql://localhost:5432/BaseSisMovilidad";
    private static final String USER = "postgres";
    private static final String PASSWORD = "123456";

    public RegistroDAOPostgre() {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // ---------------------------------------------------------
    // INSERTAR REGISTRO (USUARIO)
    // ---------------------------------------------------------
    @Override
    public int insertarRegistro(RegistroDTO registro) {

        // Primero verificar si el email ya existe
        if (emailExiste(registro.getEmail())) {
            return 0; // Email ya existe, no se puede registrar
        }

        String sql = "INSERT INTO usuarios (nombre, email, telefono, rol, password) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, registro.getNombre());
            ps.setString(2, registro.getEmail());
            ps.setString(3, registro.getTelefono());
            ps.setString(4, registro.getRol());
            ps.setString(5, registro.getPassword()); // Idealmente hasheada

            return ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error insertando registro");
            e.printStackTrace();
        }
        return 0;
    }

    // ---------------------------------------------------------
    // CONSULTAR REGISTRO POR ID
    // ---------------------------------------------------------
    @Override
    public RegistroDTO consultarRegistro(int id) {

        String sql = "SELECT * FROM usuarios WHERE id = ?";
        RegistroDTO registro = null;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                registro = new RegistroDTO(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("email"),
                        rs.getString("telefono"),
                        rs.getString("rol"),
                        rs.getString("password")
                );
            }

        } catch (SQLException e) {
            System.out.println("Error consultando registro");
            e.printStackTrace();
        }

        return registro;
    }

    // ---------------------------------------------------------
    // LISTAR TODOS LOS REGISTROS
    // ---------------------------------------------------------
    @Override
    public List<RegistroDTO> listarTodos() {

        String sql = "SELECT * FROM usuarios";
        List<RegistroDTO> lista = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                RegistroDTO registro = new RegistroDTO(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("email"),
                        rs.getString("telefono"),
                        rs.getString("rol"),
                        rs.getString("password")
                );

                lista.add(registro);
            }

        } catch (SQLException e) {
            System.out.println("Error listando registros");
            e.printStackTrace();
        }

        return lista;
    }

    // ---------------------------------------------------------
    // BORRAR REGISTRO
    // ---------------------------------------------------------
    @Override
    public int borrar(int id) {
        String sql = "DELETE FROM usuarios WHERE id = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error eliminando registro");
            e.printStackTrace();
        }

        return 0;
    }

    // ---------------------------------------------------------
    // MÉTODOS AUXILIARES (NO EN LA INTERFAZ)
    // ---------------------------------------------------------
    
    // Verificar si email ya existe
    public boolean emailExiste(String email) {

        String sql = "SELECT COUNT(*) FROM usuarios WHERE email = ?";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.out.println("Error verificando email");
            e.printStackTrace();
        }

        return false;
    }

    // Consultar por email (útil para login)
    public RegistroDTO consultarPorEmail(String email) {

        String sql = "SELECT * FROM usuarios WHERE email = ?";
        RegistroDTO registro = null;

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                registro = new RegistroDTO(
                        rs.getInt("id"),
                        rs.getString("nombre"),
                        rs.getString("email"),
                        rs.getString("telefono"),
                        rs.getString("rol"),
                        rs.getString("password")
                );
            }

        } catch (SQLException e) {
            System.out.println("Error consultando por email");
            e.printStackTrace();
        }

        return registro;
    }

}

