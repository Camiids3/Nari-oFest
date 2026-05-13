package servlet;

import Modelo.*;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Servlet de manejo de archivos y generación de reportes.
 * Genera reportes TXT con BufferedWriter usando usuarios.txt, eventos.txt y reporte.txt
 */
@WebServlet(name = "ServletArchivos", urlPatterns = {"/ServletArchivos"})
public class ServletArchivos extends HttpServlet {

    private static final String RUTA_BASE = System.getProperty("user.home") + "/";
    private static final String RUTA_USUARIOS = RUTA_BASE + "festnar_usuarios.txt";
    private static final String RUTA_EVENTOS = RUTA_BASE + "festnar_eventos.txt";
    private static final String RUTA_REPORTE = RUTA_BASE + "festnar_reporte.txt";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Solo admin puede generar reportes
        HttpSession session = request.getSession(false);
        Usuario usuarioSesion = (session != null) ? (Usuario) session.getAttribute("usuarioSesion") : null;

        if (usuarioSesion == null || !"admin".equalsIgnoreCase(usuarioSesion.getRol())) {
            response.sendRedirect("listaEvento.jsp");
            return;
        }

        String accion = request.getParameter("accion");

        // ── GENERAR REPORTE COMPLETO ──────────────────────────────────────────
        if ("generarReporte".equals(accion)) {
            generarReporteCompleto(usuarioSesion);
            request.setAttribute("mensajeReporte",
                    "Reporte generado exitosamente en: " + RUTA_REPORTE);
            response.sendRedirect("listaUsers.jsp?reporte=ok");
            return;
        }

        // ── DESCARGAR REPORTE ─────────────────────────────────────────────────
        if ("descargarReporte".equals(accion)) {
            generarReporteCompleto(usuarioSesion);
            File reporte = new File(RUTA_REPORTE);
            if (reporte.exists()) {
                response.setContentType("text/plain; charset=UTF-8");
                response.setHeader("Content-Disposition",
                        "attachment; filename=\"festnar_reporte_" +
                        LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmm"))
                        + ".txt\"");
                try (BufferedReader br = new BufferedReader(new FileReader(reporte));
                     PrintWriter pw = response.getWriter()) {
                    String linea;
                    while ((linea = br.readLine()) != null) {
                        pw.println(linea);
                    }
                }
            }
            return;
        }

        response.sendRedirect("listaUsers.jsp");
    }

    /**
     * Genera un reporte completo en reporte.txt con:
     * - Resumen general
     * - Lista de usuarios
     * - Lista de eventos
     * - Asociación eventos-asistentes (relación entre las dos clases)
     */
    private void generarReporteCompleto(Usuario generadoPor) {
        String fechaStr = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss"));

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(RUTA_REPORTE, false))) {

            // ── ENCABEZADO ─────────────────────────────────
            bw.write("╔══════════════════════════════════════════════════════╗");
            bw.newLine();
            bw.write("║         REPORTE GENERAL - FESTNAR                    ║");
            bw.newLine();
            bw.write("╚══════════════════════════════════════════════════════╝");
            bw.newLine();
            bw.write("  Generado el : " + fechaStr);
            bw.newLine();
            bw.write("  Generado por: " + generadoPor.getNombre()
                    + " (" + generadoPor.getRol() + ")");
            bw.newLine();
            bw.newLine();

            // ── RESUMEN ───────────────────────────────────
            int totalAdmin = 0, totalOrg = 0, totalAsist = 0;
            for (Usuario u : BaseDatos.listaUsuarios) {
                if ("admin".equalsIgnoreCase(u.getRol())) totalAdmin++;
                else if ("organizador".equalsIgnoreCase(u.getRol())) totalOrg++;
                else totalAsist++;
            }

            bw.write("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
            bw.newLine();
            bw.write("  RESUMEN GENERAL");
            bw.newLine();
            bw.write("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
            bw.newLine();
            bw.write(String.format("  Total usuarios    : %d", BaseDatos.listaUsuarios.size()));
            bw.newLine();
            bw.write(String.format("  - Administradores : %d", totalAdmin));
            bw.newLine();
            bw.write(String.format("  - Organizadores   : %d", totalOrg));
            bw.newLine();
            bw.write(String.format("  - Asistentes      : %d", totalAsist));
            bw.newLine();
            bw.write(String.format("  Total eventos     : %d", BaseDatos.listaEventos.size()));
            bw.newLine();
            bw.newLine();

            // ── LISTA DE USUARIOS ─────────────────────────
            bw.write("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
            bw.newLine();
            bw.write("  LISTA DE USUARIOS");
            bw.newLine();
            bw.write("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
            bw.newLine();
            bw.write(String.format("  %-4s %-25s %-30s %-5s %-12s",
                    "ID", "NOMBRE", "CORREO", "EDAD", "ROL"));
            bw.newLine();
            bw.write("  " + "─".repeat(80));
            bw.newLine();

            for (Usuario u : BaseDatos.listaUsuarios) {
                bw.write(String.format("  %-4d %-25s %-30s %-5d %-12s",
                        u.getIdUsuario(),
                        truncar(u.getNombre(), 24),
                        truncar(u.getCorreo(), 29),
                        u.getEdad(),
                        u.getRol()));
                bw.newLine();
            }
            bw.newLine();

            // ── LISTA DE EVENTOS ──────────────────────────
            bw.write("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
            bw.newLine();
            bw.write("  LISTA DE EVENTOS");
            bw.newLine();
            bw.write("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
            bw.newLine();

            for (Evento e : BaseDatos.listaEventos) {
                bw.write("  ┌─────────────────────────────────────────────────────");
                bw.newLine();
                bw.write("  │ ID       : " + e.getIdEvento());
                bw.newLine();
                bw.write("  │ Nombre   : " + e.getNombreEvento());
                bw.newLine();
                bw.write("  │ Categoría: " + e.getCategoria());
                bw.newLine();
                bw.write("  │ Fecha    : " + e.getFecha() + " a las " + e.getHora());
                bw.newLine();
                bw.write("  │ Lugar    : " + e.getUbicacion());
                bw.newLine();
                bw.write("  │ Capacidad: " + e.getCapacidadMax() + " personas");
                bw.newLine();
                bw.write("  │ Estado   : " + (e.isEstado() ? "Activo" : "Inactivo"));
                bw.newLine();

                // ASOCIACIÓN: mostrar asistentes del evento
                if (e.getListaAsistentes() != null && !e.getListaAsistentes().isEmpty()) {
                    bw.write("  │ Asistentes inscritos (" + e.getListaAsistentes().size() + "):");
                    bw.newLine();
                    for (Usuario a : e.getListaAsistentes()) {
                        bw.write("  │   · " + a.getNombre() + " - " + a.getCorreo());
                        bw.newLine();
                    }
                } else {
                    bw.write("  │ Asistentes: Ninguno inscrito aún");
                    bw.newLine();
                }
                bw.write("  └─────────────────────────────────────────────────────");
                bw.newLine();
            }

            // ── PIE ───────────────────────────────────────
            bw.newLine();
            bw.write("╔══════════════════════════════════════════════════════╗");
            bw.newLine();
            bw.write("║  FIN DEL REPORTE · FestNar © 2026                   ║");
            bw.newLine();
            bw.write("╚══════════════════════════════════════════════════════╝");
            bw.newLine();

            System.out.println("[FestNar] Reporte generado: " + RUTA_REPORTE);

        } catch (IOException ex) {
            System.err.println("[FestNar] Error generando reporte: " + ex.getMessage());
        }
    }

    private String truncar(String s, int max) {
        if (s == null) return "";
        return s.length() > max ? s.substring(0, max - 1) + "…" : s;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }
}
