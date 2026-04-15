package servlet;

import Modelo.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ServletUsuarios extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("agregar".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String contraseña = request.getParameter("contraseña");
            String edadStr = request.getParameter("edad");
            int edad = 0;
            if (edadStr != null && !edadStr.isEmpty()) {
                edad = Integer.parseInt(edadStr);
            }
            String rol = request.getParameter("rol");

            if (nombre != null && correo != null && contraseña != null && rol != null) {
                Usuario u = new Usuario(nombre, edad, correo, contraseña, rol);
                boolean registrado = u.registrarUsuario(nombre, edad, contraseña, rol, correo);
                if (registrado) {
                    response.sendRedirect("listaUsers.jsp");
                } else {
                    response.sendRedirect("adminUsers.jsp");
                }

            }
        }
        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            BaseDatos.eliminarUsers(id);
            response.sendRedirect("listaUsers.jsp");

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
