<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Modelo.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="./styles/style.css">
  <title>NariñoFest</title>
  <style>
    body{background:var(--navy);margin:0;font-family:'Outfit',sans-serif}
    .hero{min-height:100vh;display:flex;flex-direction:column;position:relative;overflow:hidden}
    /* Fondo con patrón diagonal sutil */
    .hero::before{content:'';position:absolute;inset:0;
      background:
        radial-gradient(ellipse at 80% 20%,rgba(184,41,26,.18) 0%,transparent 50%),
        radial-gradient(ellipse at 10% 80%,rgba(200,136,42,.12) 0%,transparent 50%),
        linear-gradient(160deg,#0d1b3e 0%,#162040 60%,#1a2548 100%);
    }
    /* Líneas decorativas */
    .hero::after{content:'';position:absolute;top:0;right:0;width:1px;height:100%;
      background:linear-gradient(to bottom,transparent,var(--gold),transparent);opacity:.3}
    .hero-nav{position:relative;z-index:10;display:flex;align-items:center;justify-content:space-between;padding:20px 60px;border-bottom:1px solid rgba(200,136,42,.15)}
    .hero-brand{font-family:'Cormorant Garamond',serif;font-size:1.7rem;font-weight:700;color:var(--gold);text-decoration:none}
    .hero-brand em{color:var(--red2);font-style:italic}
    .hero-body{flex:1;display:flex;align-items:center;position:relative;z-index:5;padding:60px}
    .hero-text{max-width:620px}
    .hero-eyebrow{font-size:.72rem;font-weight:700;letter-spacing:3px;text-transform:uppercase;color:var(--red2);margin-bottom:20px;display:flex;align-items:center;gap:10px}
    .hero-eyebrow::before{content:'';width:30px;height:2px;background:var(--red2)}
    .hero-title{font-family:'Cormorant Garamond',serif;font-size:clamp(3.5rem,7vw,6rem);font-weight:700;color:var(--white);line-height:1;margin-bottom:12px}
    .hero-title em{color:var(--gold);font-style:italic}
    .hero-subtitle{color:rgba(200,136,42,.8);font-size:.85rem;font-weight:600;letter-spacing:2px;text-transform:uppercase;margin-bottom:24px}
    .hero-desc{color:rgba(255,255,255,.55);font-size:.96rem;line-height:1.7;margin-bottom:40px;max-width:480px}
    .hero-actions{display:flex;gap:14px;flex-wrap:wrap}
    .hero-btn-main{background:var(--gold);color:var(--navy);font-weight:700;padding:14px 36px;border-radius:10px;font-size:.95rem;border:none;text-decoration:none;display:inline-flex;align-items:center;gap:8px;transition:all .2s}
    .hero-btn-main:hover{background:var(--gold2);transform:translateY(-2px);box-shadow:0 8px 24px rgba(200,136,42,.4)}
    .hero-btn-sec{background:transparent;color:rgba(255,255,255,.75);border:1.5px solid rgba(255,255,255,.25);padding:14px 32px;border-radius:10px;font-size:.95rem;text-decoration:none;display:inline-flex;align-items:center;gap:8px;transition:all .2s}
    .hero-btn-sec:hover{border-color:var(--gold);color:var(--gold2)}
    /* Elemento visual derecho */
    .hero-visual{position:absolute;right:60px;top:50%;transform:translateY(-50%);opacity:.08;pointer-events:none;font-size:28rem;line-height:1;user-select:none}
    /* Sección inferior */
    .features{background:var(--cream);padding:80px 60px}
    .feat-label{font-size:.7rem;font-weight:700;letter-spacing:3px;text-transform:uppercase;color:var(--red);margin-bottom:12px}
    .feat-title{font-family:'Cormorant Garamond',serif;font-size:2.4rem;font-weight:700;color:var(--navy);margin-bottom:8px}
    .feat-title em{color:var(--gold);font-style:italic}
    .feat-sub{color:var(--muted);font-size:.9rem;margin-bottom:50px;max-width:500px}
    .feat-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px}
    .feat-card{background:var(--white);border-radius:16px;padding:28px 24px;box-shadow:0 2px 16px rgba(13,27,62,.08);border-top:4px solid transparent;transition:all .22s}
    .feat-card:hover{transform:translateY(-4px);box-shadow:0 10px 32px rgba(13,27,62,.14)}
    .feat-card.gc{border-top-color:var(--gold)}.feat-card.rc{border-top-color:var(--red)}.feat-card.nc{border-top-color:var(--navy3)}
    .feat-icon{font-size:2.2rem;margin-bottom:14px;display:block}
    .feat-card h5{font-family:'Cormorant Garamond',serif;font-size:1.15rem;font-weight:700;color:var(--navy);margin-bottom:8px}
    .feat-card p{font-size:.84rem;color:var(--muted);line-height:1.6;margin:0}
    /* Roles */
    .roles{background:var(--navy2);padding:70px 60px;border-top:3px solid var(--gold);border-bottom:3px solid var(--gold)}
    .roles-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-top:40px}
    .role-box{background:rgba(255,255,255,.04);border:1px solid rgba(200,136,42,.2);border-radius:16px;padding:28px 20px;text-align:center;transition:all .2s}
    .role-box:hover{background:rgba(200,136,42,.08);border-color:rgba(200,136,42,.5);transform:translateY(-3px)}
    .role-box span.em{font-size:2.6rem;display:block;margin-bottom:12px}
    .role-box h6{font-family:'Cormorant Garamond',serif;font-size:1.1rem;color:var(--gold);margin-bottom:8px;font-weight:700}
    .role-box p{font-size:.82rem;color:rgba(255,255,255,.5);line-height:1.55;margin:0}
    .role-box ul{list-style:none;padding:0;margin:10px 0 0;text-align:left}
    .role-box ul li{font-size:.78rem;color:rgba(255,255,255,.45);padding:3px 0;display:flex;align-items:center;gap:6px}
    .role-box ul li::before{content:'→';color:var(--gold);font-size:.7rem;flex-shrink:0}
    /* CTA */
    .cta{background:linear-gradient(135deg,var(--navy) 0%,var(--navy3) 100%);padding:70px 60px;text-align:center;border-top:3px solid var(--gold)}
    .cta h2{font-family:'Cormorant Garamond',serif;font-size:2.2rem;color:var(--white);margin-bottom:10px}
    .cta h2 em{color:var(--gold);font-style:italic}
    .cta p{color:rgba(255,255,255,.55);margin-bottom:30px;font-size:.9rem}
    .nf-footer{background:var(--navy);border-top:3px solid var(--gold);color:rgba(255,255,255,.4);text-align:center;padding:24px;font-size:.82rem}
    .nf-footer strong{color:var(--gold)}
    @media(max-width:768px){
      .hero-body,.hero-nav,.features,.roles,.cta{padding-left:24px;padding-right:24px}
      .hero-title{font-size:3.5rem}.feat-grid,.roles-grid{grid-template-columns:1fr}
      .hero-visual{display:none}
    }
  </style>
</head>
<body>
<%  Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSesion"); %>

<section class="hero">
  <!-- NAV -->
  <nav class="hero-nav">
    <a class="hero-brand" href="index.jsp">Nariño<em>Fest</em></a>
    <div style="display:flex;gap:10px;align-items:center">
      <% if (usuarioSesion != null) { %>
        <span style="color:rgba(200,136,42,.8);font-size:.82rem;font-weight:600"><i class="bi bi-person-fill" style="margin-right:5px"></i><%= usuarioSesion.getNombre().split(" ")[0] %></span>
        <a href="listaEvento.jsp" class="hero-btn-main" style="padding:9px 22px;font-size:.85rem"><i class="bi bi-grid"></i>Ir al sistema</a>
        <a href="ServletUsuarios?accion=cerrarSesion" class="hero-btn-sec" style="padding:9px 20px;font-size:.83rem"><i class="bi bi-box-arrow-right"></i>Salir</a>
      <% } else { %>
        <a href="login.jsp" class="hero-btn-sec" style="padding:9px 22px;font-size:.85rem"><i class="bi bi-box-arrow-in-right"></i>Iniciar Sesión</a>
        <a href="registroUsers.jsp" class="hero-btn-main" style="padding:9px 22px;font-size:.85rem">Registrarse</a>
      <% } %>
    </div>
  </nav>

  <!-- HERO BODY -->
  <div class="hero-body">
    <div class="hero-text">
      <div class="hero-eyebrow">Sistema de Gestión de Eventos Culturales</div>
      <h1 class="hero-title">Nariño<br><em>Fest</em></h1>
      <p class="hero-subtitle">Nariño, Colombia &nbsp;·&nbsp; Vive tu cultura</p>
      <p class="hero-desc">Plataforma web para organizar, gestionar y explorar los eventos culturales del departamento de Nariño. Música, arte, teatro y tradición — todo en un solo lugar.</p>
      <div class="hero-actions">
        <% if (usuarioSesion == null) { %>
        <a href="registroUsers.jsp" class="hero-btn-main"><i class="bi bi-person-plus"></i>Crear cuenta</a>
        <a href="login.jsp" class="hero-btn-sec"><i class="bi bi-box-arrow-in-right"></i>Iniciar sesión</a>
        <% } else { %>
        <a href="listaEvento.jsp" class="hero-btn-main"><i class="bi bi-calendar-event"></i>Ver Eventos</a>
        <% } %>
      </div>
    </div>
    <div class="hero-visual">🎭</div>
  </div>
</section>

<!-- FEATURES -->
<section class="features">
  <div style="max-width:1100px;margin:0 auto">
    <p class="feat-label">¿Qué es NariñoFest?</p>
    <h2 class="feat-title">Gestión cultural <em>completa</em></h2>
    <p class="feat-sub">Sistema web Java con JSP + Servlets para administrar eventos y usuarios, con persistencia en archivos TXT.</p>
    <div class="feat-grid">
      <div class="feat-card gc"><span class="feat-icon">📅</span><h5>Gestión de Eventos</h5><p>Registra, edita y elimina eventos con nombre, fecha, lugar, categoría y capacidad.</p></div>
    </div>
  </div>
</section>

<!-- ROLES -->
<section class="roles">
  <div style="max-width:1100px;margin:0 auto;text-align:center">
    <p class="feat-label" style="color:var(--red2)">Tipos de usuario</p>
    <h2 class="feat-title" style="color:var(--white)">Tres roles, <em>un sistema</em></h2>
    <div class="roles-grid">
      <div class="role-box">
        <span class="em">🎟️</span>
        <h6>Asistente</h6>
        <p>Explora y consulta los eventos disponibles</p>
        <ul><li>Ver lista de eventos</li><li>Detalles de cada evento</li></ul>
      </div>
      <div class="role-box">
        <span class="em">🎤</span>
        <h6>Organizador</h6>
        <p>Crea y gestiona la cartelera cultural</p>
        <ul><li>Agregar eventos</li><li>Editar y eliminar eventos</li><li>Ver lista de eventos</li></ul>
      </div>
      <div class="role-box">
        <span class="em">🛡️</span>
        <h6>Administrador</h6>
        <p>Control total del sistema</p>
        <ul><li>Todo lo anterior</li><li>Gestionar usuarios</li><li>Generar reportes TXT</li></ul>
      </div>
    </div>
  </div>
</section>

<!-- CTA -->
<% if (usuarioSesion == null) { %>
<section class="cta">
  <h2>¿Listo para <em>empezar</em>?</h2>
  <p>Crea tu cuenta gratis o inicia sesión para acceder al sistema.</p>
  <div style="display:flex;gap:14px;justify-content:center;flex-wrap:wrap">
    <a href="registroUsers.jsp" class="hero-btn-main"><i class="bi bi-person-plus"></i>Crear cuenta</a>
    <a href="login.jsp" class="hero-btn-sec"><i class="bi bi-box-arrow-in-right"></i>Iniciar sesión</a>
  </div>
</section>
<% } %>

<footer class="nf-footer">
  <strong>NariñoFest</strong> &mdash; Sistema de Gestión de Eventos Culturales &middot;
  Simón Mejía &amp; Camilo Ojeda &middot; APO 3 © 2026
</footer>
</body></html>
