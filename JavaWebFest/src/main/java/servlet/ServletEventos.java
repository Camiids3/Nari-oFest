package servlet;

import Modelo.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
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
        if ("agregar".equals(accion)) {
            String nombreEvento = request.getParameter("nombreEvento");
            String descripcion = request.getParameter("descripcion");
            String categoria = request.getParameter("categoria");
            String lugar = request.getParameter("lugar");
            String fechaStr = request.getParameter("fecha");
            String hora = request.getParameter("hora");
            String capacidadStr = request.getParameter("capacidad");
            int capacidad = 0;
            if (capacidadStr != null && !capacidadStr.isEmpty()) {
                capacidad = Integer.parseInt(capacidadStr);
            }
            if (nombreEvento != null && descripcion != null && categoria != null && lugar != null && fechaStr != null && hora != null) {
                Evento e = new Evento(nombreEvento, fechaStr, hora, categoria, lugar, descripcion, true, capacidad, null);
                BaseDatos.listaEventos.add(e);
                response.sendRedirect("listaEvento.jsp");

            }

        }
        if ("eliminar".equals(accion)) {
            int idEventos = Integer.parseInt(request.getParameter("IdEvento"));
            BaseDatos.eliminarEvento(idEventos);
            response.sendRedirect("listaEvento.jsp");
        }
        if ("editar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("IdEvento"));
            for (Evento e : BaseDatos.listaEventos) {
                if (e.getIdEvento() == id) {
                    e.setNombreEvento(request.getParameter("nombreEvento"));
                    e.setDescripcion(request.getParameter("descripcion"));
                    e.setCategoria(request.getParameter("categoria"));
                    e.setUbicacion(request.getParameter("lugar"));

                    // Fecha en formato yyyy-MM-dd
                    String fechaStr = request.getParameter("fecha");
                    if (fechaStr != null && !fechaStr.isEmpty()) {
                        LocalDate fecha = LocalDate.parse(fechaStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                        e.setFecha(fecha.format(DateTimeFormatter.ISO_LOCAL_DATE));
                    }

                    // Hora en formato HH:mm
                    String horaStr = request.getParameter("hora");
                    if (horaStr != null && !horaStr.isEmpty()) {
                        LocalTime hora = LocalTime.parse(horaStr, DateTimeFormatter.ofPattern("HH:mm"));
                        e.setHora(hora.format(DateTimeFormatter.ofPattern("HH:mm")));
                    }

                    String capacidadStr = request.getParameter("capacidad");
                    if (capacidadStr != null && !capacidadStr.isEmpty()) {
                        e.setCapacidadMax(Integer.parseInt(capacidadStr));
                    }
                    break;
                }
            }
            response.sendRedirect("listaEvento.jsp");
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
