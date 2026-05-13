<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>
<%
    Usuario uCheck = (Usuario) session.getAttribute("usuarioSesion");
    if (!"admin".equalsIgnoreCase(uCheck != null ? uCheck.getRol() : "")) { response.sendRedirect("listaEvento.jsp"); return; }
    int ta=0,to=0,tAs=0;
    for (Usuario u : BaseDatos.listaUsuarios) {
        if ("admin".equalsIgnoreCase(u.getRol())) ta++;
        else if ("organizador".equalsIgnoreCase(u.getRol())) to++;
        else tAs++;
    }
    String buscarU = request.getParameter("buscar");
    String rolFiltro = request.getParameter("rol");
%>
<div class="page-hdr">
  <div class="container" style="display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px">
    <div>
      <h1><i class="bi bi-people" style="margin-right:12px"></i>Gestion de Usuarios</h1>
      <p>Administra los usuarios registrados en el sistema</p>
    </div>
    <div style="display:flex;gap:10px;flex-wrap:wrap">
      <a href="adminUsers.jsp" class="btn btn-gold"><i class="bi bi-person-plus"></i>Agregar</a>
      <a href="ServletArchivos?accion=generarReporte" class="btn btn-navy"><i class="bi bi-file-earmark-text"></i>Reporte TXT</a>
    </div>
  </div>
</div>
<div class="container py-4">
  <!-- STATS -->
  <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:16px;margin-bottom:22px">
    <div class="nf-stat"><div class="nf-stat-icon" style="background:#fff3d4"></div><div><h3><%= BaseDatos.listaUsuarios.size() %></h3><p>Total</p></div></div>
    <div class="nf-stat red"><div class="nf-stat-icon" style="background:#fdecea"></div><div><h3><%= ta %></h3><p>Administradores</p></div></div>
    <div class="nf-stat navy"><div class="nf-stat-icon" style="background:#e8ecf8"></div><div><h3><%= to %></h3><p>Organizadores</p></div></div>
    <div class="nf-stat green"><div class="nf-stat-icon" style="background:#e6f4ed"></div><div><h3><%= tAs %></h3><p>Asistentes</p></div></div>
  </div>
  <!-- FILTRO -->
  <div class="nf-filter">
    <div class="nf-filter-group">
      <label class="nf-label">Buscar usuario</label>
      <input type="text" class="nf-input" id="fU" placeholder="Nombre o correo..." value="<%= buscarU != null ? buscarU : "" %>" oninput="filtrarU()">
    </div>
    <div class="nf-filter-group" style="max-width:180px">
      <label class="nf-label">Rol</label>
      <select class="nf-select" id="fR" onchange="filtrarU()">
        <option value="">Todos</option>
        <option value="admin" <%= "admin".equals(rolFiltro)?"selected":"" %>>Admin</option>
        <option value="organizador" <%= "organizador".equals(rolFiltro)?"selected":"" %>>Organizador</option>
        <option value="asistente" <%= "asistente".equals(rolFiltro)?"selected":"" %>>Asistente</option>
      </select>
    </div>
    <button onclick="document.getElementById('fU').value='';document.getElementById('fR').value='';filtrarU()" class="btn btn-ghost" style="align-self:flex-end">
      <i class="bi bi-x-circle"></i>Limpiar
    </button>
  </div>
  <!-- TABLA -->
  <div class="nf-table-wrap">
    <table class="nf-table">
      <thead><tr><th>#</th><th>Usuario</th><th>Correo</th><th>Edad</th><th>Rol</th><th>Acciones</th></tr></thead>
      <tbody id="tbodyU">
        <%
          boolean hay = false;
          for (Usuario u : BaseDatos.listaUsuarios) {
            boolean ok = true;
            if (buscarU != null && !buscarU.isEmpty() && !u.getNombre().toLowerCase().contains(buscarU.toLowerCase()) && !u.getCorreo().toLowerCase().contains(buscarU.toLowerCase())) ok = false;
            if (rolFiltro != null && !rolFiltro.isEmpty() && !u.getRol().equalsIgnoreCase(rolFiltro)) ok = false;
            if (!ok) continue;
            hay = true;
        %>
        <tr data-nom="<%= u.getNombre().toLowerCase() %>" data-cor="<%= u.getCorreo().toLowerCase() %>" data-rol="<%= u.getRol().toLowerCase() %>">
          <td><span style="font-weight:700;color:var(--gold)">#<%= u.getIdUsuario() %></span></td>
          <td>
            <div style="display:flex;align-items:center;gap:10px">
              <div class="nf-avatar"><%= u.getNombre().substring(0,1).toUpperCase() %></div>
              <span style="font-weight:600"><%= u.getNombre() %></span>
            </div>
          </td>
          <td style="color:var(--muted);font-size:.86rem"><i class="bi bi-envelope" style="color:var(--gold);margin-right:4px"></i><%= u.getCorreo() %></td>
          <td style="font-weight:600"><%= u.getEdad() %></td>
          <td><span class="badge badge-<%= u.getRol().toLowerCase() %>"><%= u.getRol() %></span></td>
          <td>
            <div style="display:flex;gap:6px">
              <form action="editarUsuario.jsp" method="GET" style="display:inline">
                <input type="hidden" name="id" value="<%= u.getIdUsuario() %>">
                <button class="btn btn-amber btn-sm"><i class="bi bi-pencil"></i></button>
              </form>
              <form action="ServletUsuarios" method="POST" style="display:inline" onsubmit="return confirm('¿Eliminar a <%= u.getNombre() %>?')">
                <input type="hidden" name="accion" value="eliminar">
                <input type="hidden" name="id" value="<%= u.getIdUsuario() %>">
                <button class="btn btn-red btn-sm"><i class="bi bi-trash"></i></button>
              </form>
            </div>
          </td>
        </tr>
        <% } %>
        <% if (!hay) { %>
        <tr><td colspan="6" style="text-align:center;padding:30px;color:var(--muted)"><i class="bi bi-person-x" style="margin-right:6px"></i>No hay usuarios que coincidan</td></tr>
        <% } %>
      </tbody>
    </table>
  </div>
</div>
<script>
function filtrarU(){
  var b=document.getElementById('fU').value.toLowerCase();
  var r=document.getElementById('fR').value.toLowerCase();
  document.querySelectorAll('#tbodyU tr[data-nom]').forEach(function(tr){
    var nb=tr.dataset.nom.includes(b)||tr.dataset.cor.includes(b);
    var rb=r===''||tr.dataset.rol===r;
    tr.style.display=(nb&&rb)?'':'none';
  });
}
</script>
<%@include file="/lib/footer.jsp"%>
