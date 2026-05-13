<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>
<%
    Usuario uCheck = (Usuario) session.getAttribute("usuarioSesion");
    String rolCheck = (uCheck != null) ? uCheck.getRol() : "";
    if (!"admin".equalsIgnoreCase(rolCheck) && !"organizador".equalsIgnoreCase(rolCheck)) { response.sendRedirect("listaEvento.jsp"); return; }
    String idStr = request.getParameter("IdEvento");
    Evento eventoEditar = null;
    if (idStr != null) { int id = Integer.parseInt(idStr); for (Evento ev : BaseDatos.listaEventos) if (ev.getIdEvento() == id) { eventoEditar = ev; break; } }
    if (eventoEditar == null) { response.sendRedirect("listaEvento.jsp"); return; }
%>
<div class="page-hdr">
  <div class="container">
    <h1><i class="bi bi-pencil-square" style="margin-right:12px"></i>Editar Evento</h1>
    <p>Modificando: <strong style="color:var(--gold2)"><%= eventoEditar.getNombreEvento() %></strong></p>
  </div>
</div>
<div class="container py-4" style="max-width:760px">
  <div class="nf-card">
    <div class="nf-card-hdr"><i class="bi bi-pencil" style="margin-right:8px"></i>Evento #<%= eventoEditar.getIdEvento() %></div>
    <div class="nf-card-body">
      <form action="ServletEventos" method="POST">
        <input type="hidden" name="accion" value="editar">
        <input type="hidden" name="IdEvento" value="<%= eventoEditar.getIdEvento() %>">
        <div class="nf-field"><label class="nf-label">Nombre del evento *</label><input type="text" class="nf-input" name="nombreEvento" value="<%= eventoEditar.getNombreEvento() %>" required></div>
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px">
          <div class="nf-field"><label class="nf-label">Categori­a *</label>
            <select class="nf-select" name="categoria" required>
              <% String[] cats = {"Musica","Arte","Teatro","Danza","Cine","Literatura","Gastronomi­a","Cultura","Otro"};
                 for (String c : cats) { %><option <%= c.equals(eventoEditar.getCategoria()) ? "selected" : "" %>><%= c %></option><% } %>
            </select>
          </div>
          <div class="nf-field"><label class="nf-label">Lugar *</label><input type="text" class="nf-input" name="lugar" value="<%= eventoEditar.getUbicacion() %>" required></div>
        </div>
        <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:16px">
          <div class="nf-field"><label class="nf-label">Fecha *</label><input type="date" class="nf-input" name="fecha" value="<%= eventoEditar.getFecha() %>" required></div>
          <div class="nf-field"><label class="nf-label">Hora</label><input type="time" class="nf-input" name="hora" value="<%= eventoEditar.getHora() %>"></div>
          <div class="nf-field"><label class="nf-label">Capacidad</label><input type="number" class="nf-input" name="capacidad" value="<%= eventoEditar.getCapacidadMax() %>" min="1"></div>
        </div>
        <div class="nf-field"><label class="nf-label">Descripcion *</label><textarea class="nf-textarea" name="descripcion" required><%= eventoEditar.getDescripcion() %></textarea></div>
        <hr class="nf-line">
        <div style="display:flex;gap:12px;justify-content:flex-end">
          <a href="listaEvento.jsp" class="btn btn-ghost">Cancelar</a>
          <button type="submit" class="btn btn-amber btn-lg"><i class="bi bi-check-lg"></i>Actualizar</button>
        </div>
      </form>
    </div>
  </div>
</div>
<%@include file="/lib/footer.jsp"%>
