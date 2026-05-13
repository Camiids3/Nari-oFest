<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Modelo.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="./styles/style.css">
    <title>NariñoFest</title>
</head>
<body>
<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion");
    String rol = (usuarioSesion != null) ? usuarioSesion.getRol() : "";
    boolean esAdmin = "admin".equalsIgnoreCase(rol);
    boolean esOrganizador = "organizador".equalsIgnoreCase(rol);
    String uri = request.getRequestURI();
    boolean esPublica = uri.contains("index.jsp") || uri.contains("login.jsp") || uri.contains("registroUsers.jsp");
    if (usuarioSesion == null && !esPublica) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<nav class="nf-nav">
  <div class="container" style="max-width:1200px;margin:0 auto;padding:0 20px;">
    <div style="display:flex;align-items:center;min-height:62px;gap:16px;width:100%">
      <a class="nf-brand" href="index.jsp">Nariño<em>Fest</em></a>
      <div class="nf-links" style="display:flex;align-items:center;gap:2px;flex:1">
        <% if (usuarioSesion != null) { %>
        <a href="listaEvento.jsp" class="nf-link"><i class="bi bi-calendar-event"></i>Eventos</a>
        <% if (esAdmin || esOrganizador) { %>
        <a href="adminEvento.jsp" class="nf-link"><i class="bi bi-plus-circle"></i>Nuevo Evento</a>
        <% } %>
        <% if (esAdmin) { %>
        <div class="nf-dropdown">
          <a href="#" class="nf-link"><i class="bi bi-people"></i>Usuarios <i class="bi bi-chevron-down" style="font-size:.65rem;margin-left:2px"></i></a>
          <div class="nf-dropdown-menu">
            <a href="listaUsers.jsp" class="nf-dropdown-item"><i class="bi bi-list-ul"></i>Lista de Usuarios</a>
            <a href="adminUsers.jsp" class="nf-dropdown-item"><i class="bi bi-person-plus"></i>Agregar Usuario</a>
            <div class="nf-dropdown-sep"></div>
            <a href="ServletArchivos?accion=generarReporte" class="nf-dropdown-item"><i class="bi bi-file-earmark-text"></i>Generar Reporte</a>
          </div>
        </div>
        <% } %>
        <% } %>
      </div>
      <div class="nf-right">
        <% if (usuarioSesion != null) { %>
          <span class="nf-chip"><i class="bi bi-person-fill"></i><%= usuarioSesion.getNombre().split(" ")[0] %> &middot; <%= rol %></span>
          <a href="ServletUsuarios?accion=cerrarSesion" class="nf-btn nf-btn-outline"><i class="bi bi-box-arrow-right"></i>Salir</a>
        <% } else { %>
          <a href="login.jsp" class="nf-btn nf-btn-outline"><i class="bi bi-box-arrow-in-right"></i>Iniciar Sesión</a>
          <a href="registroUsers.jsp" class="nf-btn nf-btn-gold">Registrarse</a>
        <% } %>
      </div>
    </div>
  </div>
</nav>
<main>
