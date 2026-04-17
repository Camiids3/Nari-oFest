<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>
<div class="container mt-4">

    <!-- Editar Usuario -->
    <h2>Editar Usuario</h2>
    <%
        String idStr = request.getParameter("id");
        Usuario usuarioEditar = null;
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            for (Usuario u : BaseDatos.listaUsuarios) {
                if (u.getIdUsuario() == id) {
                    usuarioEditar = u;
                    break;
                }
            }
        }
    %>
    <form action="ServletUsuarios" method="POST" class="mb-5">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="id" value="<%= usuarioEditar.getIdUsuario()%>"/>

        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre" value="<%= usuarioEditar.getNombre()%>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="correo" value="<%= usuarioEditar.getCorreo()%>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="contraseña" value="<%= usuarioEditar.getContraseña()%>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Edad</label>
            <input type="number" class="form-control" name="edad" value="<%= usuarioEditar.getEdad()%>" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Rol</label>
            <select class="form-select" name="rol" required>
                <option value="admin" <%= usuarioEditar.getRol().equals("admin") ? "selected" : ""%>>Administrador</option>
                <option value="organizador" <%= usuarioEditar.getRol().equals("organizador") ? "selected" : ""%>>Organizador</option>
                <option value="usuario" <%= usuarioEditar.getRol().equals("usuario") ? "selected" : ""%>>Usuario</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="listaUsers.jsp" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
<%@include file="/lib/footer.jsp"%>