<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>
<% if (!"admin".equalsIgnoreCase(((Usuario)session.getAttribute("usuarioSesion"))!=null?((Usuario)session.getAttribute("usuarioSesion")).getRol():"")) { response.sendRedirect("listaEvento.jsp"); return; } %>
<div class="page-hdr"><div class="container"><h1><i class="bi bi-person-plus" style="margin-right:12px"></i>Agregar Usuario</h1><p>Registra un nuevo usuario en el sistema</p></div></div>
<div class="container py-4" style="max-width:600px">
  <% String err=(String)request.getAttribute("errorUsuario"); if(err!=null){ %><div class="nf-alert nf-alert-danger"><i class="bi bi-exclamation-circle-fill"></i><%= err %></div><% } %>
  <div class="nf-card">
    <div class="nf-card-hdr"><i class="bi bi-person-badge" style="margin-right:8px"></i>Datos del Usuario</div>
    <div class="nf-card-body">
      <form action="ServletUsuarios" method="POST">
        <input type="hidden" name="accion" value="agregar">
        <div style="display:grid;grid-template-columns:2fr 1fr;gap:14px">
          <div class="nf-field"><label class="nf-label">Nombre completo *</label><input type="text" class="nf-input" name="nombre" placeholder="Nombre completo" required></div>
          <div class="nf-field"><label class="nf-label">Edad *</label><input type="number" class="nf-input" name="edad" placeholder="25" min="1" max="120" required></div>
        </div>
        <div class="nf-field"><label class="nf-label">Correo Electronico *</label><input type="email" class="nf-input" name="correo" placeholder="correo@ejemplo.com" required></div>
        <div class="nf-field"><label class="nf-label">Contraseña *</label>
          <div class="nf-input-group"><input type="password" class="nf-input" name="contrasena" id="pa" required><button type="button" class="nf-input-btn" onclick="tp('pa','ia')"><i class="bi bi-eye" id="ia"></i></button></div>
        </div>
        <div class="nf-field"><label class="nf-label">Rol *</label>
          <select class="nf-select" name="rol" required>
            <option value="">Seleccionar...</option>
            <option value="admin">Administrador</option>
            <option value="organizador">Organizador</option>
            <option value="asistente">Asistente</option>
          </select>
        </div>
        <hr class="nf-line">
        <div style="display:flex;gap:12px;justify-content:flex-end">
          <a href="listaUsers.jsp" class="btn btn-ghost">Cancelar</a>
          <button type="submit" class="btn btn-gold btn-lg"><i class="bi bi-person-check"></i>Guardar</button>
        </div>
      </form>
    </div>
  </div>
</div>
<script>function tp(id,ic){var i=document.getElementById(id),e=document.getElementById(ic);i.type=i.type==='password'?'text':'password';e.className=i.type==='text'?'bi bi-eye-slash':'bi bi-eye'}</script>
<%@include file="/lib/footer.jsp"%>
ter.jsp"%>