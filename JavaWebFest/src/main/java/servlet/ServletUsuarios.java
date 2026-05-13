package servlet;

import Modelo.*;
import java.io.*;
import java.nio.file.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ServletUsuarios", urlPatterns = {"/ServletUsuarios"})
public class ServletUsuarios extends HttpServlet {

    // Ruta del archivo de persistencia (relativa al servidor)
    private static final String RUTA_ARCHIVO = System.getProperty("user.home") + "/festnar_usuarios.txt";

    @Override
    public void init() throws ServletException {
        super.init();
        cargarUsuariosDesdeArchivo();
        // Usuario admin por defecto si no hay ninguno
        if (BaseDatos.listaUsuarios.isEmpty()) {
            Usuario admin = new Usuario("Administrador", 30, "admin@festnar.com", "admin123", "admin");
            admin.registrarUsuario("Administrador", 30, "admin123", "admin", "admin@festnar.com");
            guardarUsuariosEnArchivo();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        // ── LOGIN ──────────────────────────────────────────
        if ("login".equals(accion)) {
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            Usuario encontrado = Usuario.iniciarSesion(correo, contrasena);
            if (encontrado != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuarioSesion", encontrado);
                session.setMaxInactiveInterval(60 * 60); // 1 hora
                response.sendRedirect("listaEvento.jsp");
            } else {
                request.setAttribute("errorLogin", "Correo o contraseña incorrectos.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            return;
        }

        // ── CERRAR SESION ──────────────────────────────────
        if ("cerrarSesion".equals(accion)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("index.jsp");
            return;
        }

        // ── REGISTRAR (auto-registro desde registroUsers.jsp) ──
        if ("registrar".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            String edadStr = request.getParameter("edad");
            String rol = request.getParameter("rol");

            int edad = 0;
            try { edad = Integer.parseInt(edadStr); } catch (Exception ignored) {}

            if (nombre == null || correo == null || contrasena == null || rol == null
                    || nombre.isEmpty() || correo.isEmpty() || contrasena.isEmpty() || edad <= 0) {
                request.setAttribute("errorRegistro", "Todos los campos son obligatorios.");
                request.getRequestDispatcher("registroUsers.jsp").forward(request, response);
                return;
            }

            Usuario nuevo = new Usuario(nombre, edad, correo, contrasena, rol);
            boolean ok = nuevo.registrarUsuario(nombre, edad, contrasena, rol, correo);

            if (ok) {
                guardarUsuariosEnArchivo();
                // Generar reporte de nuevo registro
                generarReporteRegistro(nuevo);
                HttpSession session = request.getSession();
                session.setAttribute("usuarioSesion", nuevo);
                response.sendRedirect("listaEvento.jsp");
            } else {
                request.setAttribute("errorRegistro", "El correo ya está registrado o los datos son inválidos.");
                request.getRequestDispatcher("registroUsers.jsp").forward(request, response);
            }
            return;
        }

        // ── AGREGAR (admin agrega usuario manualmente) ─────
        if ("agregar".equals(accion)) {
            verificarAdmin(request, response);
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            String edadStr = request.getParameter("edad");
            String rol = request.getParameter("rol");

            int edad = 0;
            try { edad = Integer.parseInt(edadStr); } catch (Exception ignored) {}

            Usuario u = new Usuario(nombre, edad, correo, contrasena, rol);
            boolean registrado = u.registrarUsuario(nombre, edad, contrasena, rol, correo);

            if (registrado) {
                guardarUsuariosEnArchivo();
                response.sendRedirect("listaUsers.jsp");
            } else {
                request.setAttribute("errorUsuario", "El correo ya existe o los datos son inválidos.");
                request.getRequestDispatcher("adminUsers.jsp").forward(request, response);
            }
            return;
        }

        // ── ELIMINAR ───────────────────────────────────────
        if ("eliminar".equals(accion)) {
            verificarAdmin(request, response);
            int id = Integer.parseInt(request.getParameter("id"));
            BaseDatos.eliminarUsers(id);
            guardarUsuariosEnArchivo();
            response.sendRedirect("listaUsers.jsp");
            return;
        }

        // ── EDITAR ─────────────────────────────────────────
        if ("editar".equals(accion)) {
            verificarAdmin(request, response);
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String contrasena = request.getParameter("contrasena");
            int edad = Integer.parseInt(request.getParameter("edad"));
            String rol = request.getParameter("rol");

            Usuario usuarioEditar = BaseDatos.buscarUsuarioPorId(id);
            if (usuarioEditar != null) {
                usuarioEditar.setNombre(nombre);
                usuarioEditar.setCorreo(correo);
                usuarioEditar.setContraseña(contrasena);
                usuarioEditar.setEdad(edad);
                usuarioEditar.setRol(rol);
            }
            guardarUsuariosEnArchivo();
            response.sendRedirect("listaUsers.jsp");
            return;
        }

        response.sendRedirect("index.jsp");
    }

    // ── ARCHIVOS TXT ───────────────────────────────────────────────────────────

    /**
     * Guarda todos los usuarios en usuarios.txt
     * Formato CSV: id|nombre|edad|correo|contrasena|rol
     */
    private void guardarUsuariosEnArchivo() {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(RUTA_ARCHIVO, false))) {
            bw.write("# FestNar - Usuarios registrados");
            bw.newLine();
            bw.write("# id|nombre|edad|correo|contrasena|rol");
            bw.newLine();
            for (Usuario u : BaseDatos.listaUsuarios) {
                bw.write(u.getIdUsuario() + "|" + u.getNombre() + "|" + u.getEdad()
                        + "|" + u.getCorreo() + "|" + u.getContraseña() + "|" + u.getRol());
                bw.newLine();
            }
        } catch (IOException e) {
            System.err.println("[FestNar] Error guardando usuarios: " + e.getMessage());
        }
    }

    /**
     * Carga usuarios desde usuarios.txt al iniciar el servidor
     */
    private void cargarUsuariosDesdeArchivo() {
        File f = new File(RUTA_ARCHIVO);
        if (!f.exists()) return;
        try (BufferedReader br = new BufferedReader(new FileReader(f))) {
            String linea;
            while ((linea = br.readLine()) != null) {
                if (linea.startsWith("#") || linea.trim().isEmpty()) continue;
                String[] partes = linea.split("\\|");
                if (partes.length >= 6) {
                    int edad = Integer.parseInt(partes[2]);
                    Usuario u = new Usuario(partes[1], edad, partes[3], partes[4], partes[5]);
                    // Verificar que no exista ya
                    boolean existe = false;
                    for (Usuario ex : BaseDatos.listaUsuarios)
                        if (ex.getCorreo().equals(partes[3])) { existe = true; break; }
                    if (!existe) BaseDatos.listaUsuarios.add(u);
                }
            }
        } catch (IOException e) {
            System.err.println("[FestNar] Error cargando usuarios: " + e.getMessage());
        }
    }

    /**
     * Genera un reporte de registro de un usuario (txt adicional)
     */
    private void generarReporteRegistro(Usuario u) {
        String rutaReporte = System.getProperty("user.home") + "/festnar_reporte_registro.txt";
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(rutaReporte, true))) {
            bw.write("=================================================");
            bw.newLine();
            bw.write("  NUEVO REGISTRO - FestNar");
            bw.newLine();
            bw.write("=================================================");
            bw.newLine();
            bw.write("  Nombre  : " + u.getNombre());
            bw.newLine();
            bw.write("  Correo  : " + u.getCorreo());
            bw.newLine();
            bw.write("  Rol     : " + u.getRol());
            bw.newLine();
            bw.write("  Fecha   : " + java.time.LocalDateTime.now().toString());
            bw.newLine();
            bw.write("=================================================");
            bw.newLine();
            bw.newLine();
        } catch (IOException e) {
            System.err.println("[FestNar] Error generando reporte: " + e.getMessage());
        }
    }

    // ── HELPERS ────────────────────────────────────────────────────────────────

    private void verificarAdmin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuarioSesion") : null;
        if (u == null || !"admin".equalsIgnoreCase(u.getRol())) {
            response.sendRedirect("listaEvento.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }
}
