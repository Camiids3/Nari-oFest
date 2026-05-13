<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>
<%
    Usuario uSesion = (Usuario) session.getAttribute("usuarioSesion");
    String rolU = (uSesion != null) ? uSesion.getRol() : "";
    boolean puedeEditar = "admin".equalsIgnoreCase(rolU) || "organizador".equalsIgnoreCase(rolU);
    String buscar = request.getParameter("buscar");
    String catFiltro = request.getParameter("categoria");
%>
<div class="page-hdr">
  <div class="container" style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px">
    <div>
      <h1><i class="bi bi-calendar-event" style="margin-right:12px"></i>Eventos Culturales</h1>
      <p><%= BaseDatos.listaEventos.size() %> eventos registrados</p>
    </div>
    <% if (puedeEditar) { %>
    <a href="adminEvento.jsp" class="btn btn-gold"><i class="bi bi-plus-circle"></i>Nuevo Evento</a>
    <% } %>
  </div>
</div>
<div class="container py-4">
  <!-- FILTRO -->
  <div class="nf-filter">
    <div class="nf-filter-group">
      <label class="nf-label">Buscar evento</label>
      <input type="text" class="nf-input" id="fBuscar" placeholder="Nombre del evento..." value="<%= buscar != null ? buscar : "" %>" oninput="filtrar()">
    </div>
    <div class="nf-filter-group" style="max-width:200px">
      <label class="nf-label">Categori�a</label>
      <input type="text" class="nf-input" id="fCat" placeholder="Musica, Arte..." value="<%= catFiltro != null ? catFiltro : "" %>" oninput="filtrar()">
    </div>
    <button onclick="document.getElementById('fBuscar').value='';document.getElementById('fCat').value='';filtrar()" class="btn btn-ghost" style="align-self:flex-end">
      <i class="bi bi-x-circle"></i>Limpiar
    </button>
  </div>

  <% if (!puedeEditar) { %>

  <div id="evGrid" style="display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:20px">
    <%
      for (Evento e : BaseDatos.listaEventos) {
        boolean ok = true;
        if (buscar != null && !buscar.isEmpty() && !e.getNombreEvento().toLowerCase().contains(buscar.toLowerCase())) ok = false;
        if (catFiltro != null && !catFiltro.isEmpty() && !e.getCategoria().toLowerCase().contains(catFiltro.toLowerCase())) ok = false;
        if (!ok) continue;
    %>
    <div class="ev-card"
         data-nombre="<%= e.getNombreEvento().toLowerCase() %>"
         data-cat="<%= e.getCategoria().toLowerCase() %>">
      <div class="ev-card-top">
        <span class="ev-cat"><%= e.getCategoria() %></span>
        <h5><%= e.getNombreEvento() %></h5>
      </div>
      <div class="ev-card-body">
        <div class="ev-meta"><i class="bi bi-calendar3"></i><span><%= e.getFecha() %> &nbsp;&nbsp; <%= e.getHora() %></span></div>
        <div class="ev-meta"><i class="bi bi-geo-alt"></i><span><%= e.getUbicacion() %></span></div>
        <div class="ev-meta"><i class="bi bi-people"></i><span>Capacidad: <%= e.getCapacidadMax() %> personas</span></div>
        <p class="ev-desc"><%= e.getDescripcion() %></p>
      </div>
    </div>
    <% } %>
  </div>

  <% } else { %>
  <!-- ═══ ADMIN/ORGANIZADOR — TABLA ═══ -->
  <div class="nf-table-wrap">
    <table class="nf-table" id="evTable">
      <thead><tr><th>#</th><th>Nombre</th><th>Categoría</th><th>Fecha</th><th>Lugar</th><th>Cap.</th><th>Acciones</th></tr></thead>
      <tbody>
        <% for (Evento e : BaseDatos.listaEventos) {
          boolean ok = true;
          if (buscar != null && !buscar.isEmpty() && !e.getNombreEvento().toLowerCase().contains(buscar.toLowerCase())) ok = false;
          if (catFiltro != null && !catFiltro.isEmpty() && !e.getCategoria().toLowerCase().contains(catFiltro.toLowerCase())) ok = false;
          if (!ok) continue;
        %>
        <tr data-nombre="<%= e.getNombreEvento().toLowerCase() %>" data-cat="<%= e.getCategoria().toLowerCase() %>">
          <td><span style="font-weight:700;color:var(--gold)">#<%= e.getIdEvento() %></span></td>
          <td style="font-weight:600"><%= e.getNombreEvento() %></td>
          <td><span class="badge badge-organizador"><%= e.getCategoria() %></span></td>
          <td style="color:var(--muted);font-size:.85rem"><i class="bi bi-calendar3" style="color:var(--gold);margin-right:4px"></i><%= e.getFecha() %></td>
          <td style="color:var(--muted);font-size:.85rem"><i class="bi bi-geo-alt" style="color:var(--red);margin-right:4px"></i><%= e.getUbicacion() %></td>
          <td style="font-weight:600"><%= e.getCapacidadMax() %></td>
          <td>
            <div style="display:flex;gap:6px">
              <form action="editarEvento.jsp" method="GET" style="display:inline">
                <input type="hidden" name="IdEvento" value="<%= e.getIdEvento() %>">
                <button class="btn btn-amber btn-sm"><i class="bi bi-pencil"></i></button>
              </form>
              <form action="ServletEventos" method="POST" style="display:inline" onsubmit="return confirm('�Eliminar?')">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="IdEvento" value="<%= e.getIdEvento() %>">
                <button class="btn btn-red btn-sm"><i class="bi bi-trash"></i></button>
              </form>
            </div>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
  <% } %>

  <% if (BaseDatos.listaEventos.isEmpty()) { %>
  <div style="text-align:center;padding:60px 0;color:var(--muted)">
    <div style="font-size:3.5rem;opacity:.2;margin-bottom:12px"></div>
    <p>No hay eventos registrados </p>
    <% if (puedeEditar) { %><a href="adminEvento.jsp" class="btn btn-gold" style="margin-top:16px"><i class="bi bi-plus-circle"></i>Crear primer evento</a><% } %>
  </div>
  <% } %>
</div>
<script>
function filtrar(){
  var b=document.getElementById('fBuscar').value.toLowerCase();
  var c=document.getElementById('fCat').value.toLowerCase();
  var items=document.querySelectorAll('[data-nombre]');
  items.forEach(function(el){
    var nb=el.dataset.nombre.includes(b);
    var cb=c===''||el.dataset.cat.includes(c);
    el.style.display=(nb&&cb)?'':'none';
  });
}
</script>
<%@include file="/lib/footer.jsp"%>
