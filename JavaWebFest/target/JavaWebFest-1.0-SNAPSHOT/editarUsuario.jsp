<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>
<%
    Usuario uCheck=(Usuario)session.getAttribute("usuarioSesion");
    if(!"admin".equalsIgnoreCase(uCheck!=null?uCheck.getRol():"")) { response.sendRedirect("listaEvento.jsp"); return; }
    String idStr=request.getParameter("id"); Usuario ue=null;
    if(idStr!=null) ue=BaseDatos.buscarUsuarioPorId(Integer.parseInt(idStr));
    if(ue==null) { response.sendRedirect("listaUsers.jsp"); return; }
%>
<div class="page-hdr"><div class="container"><h1><i class="bi bi-person-gear" style="margin-right:12px"></i>Editar Usuario</h1><p>Modificando: <strong style="color:var(--gold2)"><%= ue.getNombre() %></strong></p></div></div>
<div class="container py-4" style="max-width:600px">
  <div class="nf-card">
    <div class="nf-card-hdr"><i class="bi bi-pencil" style="margin-right:8px"></i>Usuario #<%= ue.getIdUsuario() %></div>
    <div class="nf-card-body">
      <form action="ServletUsuarios" method="POST">
        <input type="hidden" name="accion" value="editar">
        <input type="hidden" name="id" value="<%= ue.getIdUsuario() %>">
        <div style="display:grid;grid-template-columns:2fr 1fr;gap:14px">
          <div class="nf-field"><label class="nf-label">Nombre *</label><input type="text" class="nf-input" name="nombre" value="<%= ue.getNombre() %>" required></div>
          <div class="nf-field"><label class="nf-label">Edad *</label><input type="number" class="nf-input" name="edad" value="<%= ue.getEdad() %>" min="1" required></div>
        </div>
        <div class="nf-field"><label class="nf-label">Correo *</label><input type="email" class="nf-input" name="correo" value="<%= ue.getCorreo() %>" required></div>
        <div class="nf-field"><label class="nf-label">Contraseña</label>
          <div class="nf-input-group"><input type="password" class="nf-input" name="contrasena" id="pe" value="<%= ue.getContrasena() %>"><button type="button" class="nf-input-btn" onclick="tp('pe','ie')"><i class="bi bi-eye" id="ie"></i></button></div>
        </div>
        <div class="nf-field"><label class="nf-label">Rol *</label>
          <select class="nf-select" name="rol" required>
            <option value="admin" <%="admin".equalsIgnoreCase(ue.getRol())?"selected":""%>>Administrador</option>
            <option value="organizador" <%="organizador".equalsIgnoreCase(ue.getRol())?"selected":""%>>Organizador</option>
            <option value="asistente" <%="asistente".equalsIgnoreCase(ue.getRol())||"usuario".equalsIgnoreCase(ue.getRol())?"selected":""%>>Asistente</option>
          </select>
        </div>
        <hr class="nf-line">
        <div style="display:flex;gap:12px;justify-content:flex-end">
          <a href="listaUsers.jsp" class="btn btn-ghost">Cancelar</a>
          <button type="submit" class="btn btn-amber btn-lg"><i class="bi bi-check-lg"></i>Actualizar</button>
        </div>
      </form>
    </div>
  </div>
</div>
<script>function tp(id,ic){var i=document.getElementById(id),e=document.getElementById(ic);i.type=i.type==='password'?'text':'password';e.className=i.type==='text'?'bi bi-eye-slash':'bi bi-eye'}</script>
<%@include file="/lib/footer.jsp"%>
"%>