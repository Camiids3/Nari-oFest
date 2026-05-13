<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>
<%
    Usuario uCheck = (Usuario) session.getAttribute("usuarioSesion");
    String rolCheck = (uCheck != null) ? uCheck.getRol() : "";
    if (!"admin".equalsIgnoreCase(rolCheck) && !"organizador".equalsIgnoreCase(rolCheck)) { response.sendRedirect("listaEvento.jsp"); return; }
%>
<div class="page-hdr">
  <div class="container">
    <h1><i class="bi bi-plus-circle" style="margin-right:12px"></i>Agregar Evento</h1>
    <p>Registra un nuevo evento cultural en el sistema</p>
  </div>
</div>
<div class="container py-4" style="max-width:760px">
  <% String err = (String) request.getAttribute("errorEvento"); if (err != null) { %>
  <div class="nf-alert nf-alert-danger"><i class="bi bi-exclamation-circle-fill"></i><%= err %></div>
  <% } %>
  <div class="nf-card">
    <div class="nf-card-hdr"><i class="bi bi-calendar-plus" style="margin-right:8px"></i>Datos del Evento</div>
    <div class="nf-card-body">
      <form action="ServletEventos" method="POST">
        <input type="hidden" name="accion" value="agregar">
        <div class="nf-field"><label class="nf-label">Nombre del evento *</label><input type="text" class="nf-input" name="nombreEvento" placeholder="Ej: Festival de Jazz del Galeras" required></div>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px">
          <div class="nf-field"><label class="nf-label">Categori­a *</label>
            <select class="nf-select" name="categoria" required>
              <option value="">Seleccionar...</option>
              <option>Musica</option><option>Arte</option><option>Teatro</option><option>Danza</option>
              <option>Cine</option><option>Literatura</option><option>Gastronomi­a</option><option>Cultura</option><option>Otro</option>
            </select>
          </div>
          <div class="nf-field"><label class="nf-label">Lugar *</label><input type="text" class="nf-input" name="lugar" placeholder="Teatro Agustin Agualongo" required></div>
        </div>
        <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:16px">
          <div class="nf-field"><label class="nf-label">Fecha *</label><input type="date" class="nf-input" name="fecha" required></div>
          <div class="nf-field"><label class="nf-label">Hora *</label><input type="time" class="nf-input" name="hora" required></div>
          <div class="nf-field"><label class="nf-label">Capacidad *</label><input type="number" class="nf-input" name="capacidad" placeholder="500" min="1" required></div>
        </div>
        <div class="nf-field"><label class="nf-label">Descripcion *</label><textarea class="nf-textarea" name="descripcion" placeholder="Describe el evento..." required></textarea></div>
        <hr class="nf-line">
        <div style="display:flex;gap:12px;justify-content:flex-end">
          <a href="listaEvento.jsp" class="btn btn-ghost">Cancelar</a>
          <button type="submit" class="btn btn-gold btn-lg"><i class="bi bi-check-lg"></i>Guardar Evento</button>
        </div>
      </form>
    </div>
  </div>
</div>
<%@include file="/lib/footer.jsp"%>
