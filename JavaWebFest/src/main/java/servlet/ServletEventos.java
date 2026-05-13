package servlet;

import Modelo.*;
import java.io.*;
import java.time.*;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ServletEventos", urlPatterns = {"/ServletEventos"})
public class ServletEventos extends HttpServlet {

    private static final String RUTA_ARCHIVO = System.getProperty("user.home") + "/festnar_eventos.txt";

    @Override
    public void init() throws ServletException {
        super.init();
        cargarEventosDesdeArchivo();
        // Evento de ejemplo si no hay ninguno
        if (BaseDatos.listaEventos.isEmpty()) {
            Evento demo = new Evento("Festival Carnaval de Negros y Blancos",
                    "2026-01-05", "10:00", "Cultura",
                    "Centro Histórico de Pasto", "El carnaval más importante del sur de Colombia.",
                    true, 5000, null);
            BaseDatos.listaEventos.add(demo);
            guardarEventosEnArchivo();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        // Verificar que tenga sesión
        HttpSession session = request.getSession(false);
        Usuario usuarioSesion = (session != null) ? (Usuario) session.getAttribute("usuarioSesion") : null;

        // ── AGREGAR ──────────────────────────────────────────
        if ("agregar".equals(accion)) {
            if (!puedeEditar(usuarioSesion)) {
                response.sendRedirect("listaEvento.jsp");
                return;
            }
            String nombreEvento = request.getParameter("nombreEvento");
            String descripcion = request.getParameter("descripcion");
            String categoria = request.getParameter("categoria");
            String lugar = request.getParameter("lugar");
            String fechaStr = request.getParameter("fecha");
            String hora = request.getParameter("hora");
            String capacidadStr = request.getParameter("capacidad");

            int capacidad = 0;
            try { capacidad = Integer.parseInt(capacidadStr); } catch (Exception ignored) {}

            if (nombreEvento == null || descripcion == null || categoria == null
                    || lugar == null || fechaStr == null || hora == null
                    || nombreEvento.isEmpty()) {
                request.setAttribute("errorEvento", "Todos los campos son obligatorios.");
                request.getRequestDispatcher("adminEvento.jsp").forward(request, response);
                return;
            }

            Evento e = new Evento(nombreEvento, fechaStr, hora, categoria, lugar,
                    descripcion, true, capacidad, usuarioSesion);
            BaseDatos.listaEventos.add(e);
            guardarEventosEnArchivo();
            response.sendRedirect("listaEvento.jsp");
            return;
        }

        if ("eliminar".equals(accion)) {
            if (!puedeEditar(usuarioSesion)) {
                response.sendRedirect("listaEvento.jsp");
                return;
            }
            int id = Integer.parseInt(request.getParameter("IdEvento"));
            BaseDatos.eliminarEvento(id);
            guardarEventosEnArchivo();
            response.sendRedirect("listaEvento.jsp");
            return;
        }

   
        if ("editar".equals(accion)) {
            if (!puedeEditar(usuarioSesion)) {
                response.sendRedirect("listaEvento.jsp");
                return;
            }
            int id = Integer.parseInt(request.getParameter("IdEvento"));
            for (Evento e : BaseDatos.listaEventos) {
                if (e.getIdEvento() == id) {
                    e.setNombreEvento(request.getParameter("nombreEvento"));
                    e.setDescripcion(request.getParameter("descripcion"));
                    e.setCategoria(request.getParameter("categoria"));
                    e.setUbicacion(request.getParameter("lugar"));

                    String fechaStr = request.getParameter("fecha");
                    if (fechaStr != null && !fechaStr.isEmpty()) {
                        e.setFecha(fechaStr);
                    }
                    String horaStr = request.getParameter("hora");
                    if (horaStr != null && !horaStr.isEmpty()) {
                        e.setHora(horaStr);
                    }
                    String capStr = request.getParameter("capacidad");
                    if (capStr != null && !capStr.isEmpty()) {
                        e.setCapacidadMax(Integer.parseInt(capStr));
                    }
                    break;
                }
            }
            guardarEventosEnArchivo();
            response.sendRedirect("listaEvento.jsp");
            return;
        }

        response.sendRedirect("listaEvento.jsp");
    }


    private void guardarEventosEnArchivo() {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(RUTA_ARCHIVO, false))) {
            bw.write("# FestNar - Eventos");
            bw.newLine();
            bw.write("# id|nombre|fecha|hora|categoria|ubicacion|descripcion|estado|capacidad");
            bw.newLine();
            for (Evento e : BaseDatos.listaEventos) {
                bw.write(e.getIdEvento() + "|"
                        + e.getNombreEvento() + "|"
                        + e.getFecha() + "|"
                        + e.getHora() + "|"
                        + e.getCategoria() + "|"
                        + e.getUbicacion() + "|"
                        + e.getDescripcion().replace("|", ";") + "|"
                        + e.isEstado() + "|"
                        + e.getCapacidadMax());
                bw.newLine();
            }
        } catch (IOException ex) {
            System.err.println("[FestNar] Error guardando eventos: " + ex.getMessage());
        }
    }

    /**
     * Carga eventos desde eventos.txt al iniciar
     */
    private void cargarEventosDesdeArchivo() {
        File f = new File(RUTA_ARCHIVO);
        if (!f.exists()) return;
        try (BufferedReader br = new BufferedReader(new FileReader(f))) {
            String linea;
            while ((linea = br.readLine()) != null) {
                if (linea.startsWith("#") || linea.trim().isEmpty()) continue;
                String[] p = linea.split("\\|");
                if (p.length >= 9) {
                    boolean estado = Boolean.parseBoolean(p[7]);
                    int capacidad = Integer.parseInt(p[8]);
                    Evento e = new Evento(p[1], p[2], p[3], p[4], p[5], p[6], estado, capacidad, null);
                    BaseDatos.listaEventos.add(e);
                }
            }
        } catch (IOException ex) {
            System.err.println("[FestNar] Error cargando eventos: " + ex.getMessage());
        }
    }

    // ── HELPERS ────────────────────────────────────────────────────────────────

    private boolean puedeEditar(Usuario u) {
        if (u == null) return false;
        return "admin".equalsIgnoreCase(u.getRol()) || "organizador".equalsIgnoreCase(u.getRol());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }
}
