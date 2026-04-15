package servlet;

import Modelo.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServletEventos", urlPatterns = {"/ServletEventos"})
public class ServletEventos extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if("agregar".equals(accion)){
            String nombreEvento = request.getParameter("nombreEvento");
            String descripcion = request.getParameter("descripcion");
            String categoria = request.getParameter("categoria");
            String lugar = request.getParameter("lugar");
            String fechaStr = request.getParameter("fecha");
            String hora = request.getParameter("hora");
            String capacidadStr = request.getParameter("capacidad");
            int capacidad = 0;
            if(capacidadStr != null && !capacidadStr.isEmpty()){
                capacidad = Integer.parseInt(capacidadStr);
            }
        if(nombreEvento != null && descripcion != null && categoria != null && lugar!= null && fechaStr != null && hora != null){
            /*Evento e = new Evento(nombreEvento, fecha, hora, categoria, descripcion, capacidad){
                
            } */
            
        }    
            
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
