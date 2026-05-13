<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Modelo.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="./styles/style.css">
  <title>NariñoFest — Registrarse</title>
  <style>
    body{background:linear-gradient(160deg,#0d1b3e 0%,#162040 55%,#1a2548 100%);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:30px 16px;position:relative;overflow:hidden}
    body::before{content:'🎪';position:absolute;left:-20px;bottom:-30px;font-size:18rem;opacity:.04;pointer-events:none;line-height:1}
    body::after{content:'';position:absolute;left:0;top:0;right:0;height:3px;background:linear-gradient(90deg,var(--red),var(--gold))}
    .reg-wrap{width:100%;max-width:500px;position:relative;z-index:1}
    .reg-logo{text-align:center;margin-bottom:24px}
    .reg-logo h1{font-family:'Cormorant Garamond',serif;font-size:2.5rem;font-weight:700;color:var(--gold);margin:0;line-height:1}
    .reg-logo h1 em{color:var(--red2);font-style:italic}
    .reg-logo p{color:rgba(255,255,255,.4);font-size:.82rem;margin-top:6px}
    .reg-card{background:var(--white);border-radius:20px;padding:36px 34px;box-shadow:0 30px 80px rgba(0,0,0,.5);border-top:4px solid var(--gold)}
    .reg-card h2{font-family:'Cormorant Garamond',serif;font-size:1.35rem;color:var(--navy);text-align:center;margin-bottom:5px}
    .reg-card .sub{text-align:center;color:var(--muted);font-size:.82rem;margin-bottom:22px;padding-bottom:18px;border-bottom:1px solid var(--cream2)}
    .row2{display:grid;grid-template-columns:1fr 1fr 1fr;gap:14px}
    .row3{display:grid;grid-template-columns:2fr 1fr;gap:14px}
    .reg-foot{text-align:center;margin-top:18px;font-size:.82rem;color:rgba(255,255,255,.4)}
    .reg-foot a{color:var(--gold2);text-decoration:none;font-weight:600}
    .reg-foot a:hover{color:var(--gold)}
    .back-link{display:block;text-align:center;margin-top:12px;color:rgba(255,255,255,.3);font-size:.77rem;text-decoration:none}
    .back-link:hover{color:rgba(255,255,255,.6)}
    /* Rol cards */
    .rol-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:10px;margin-top:2px}
    .rol-radio input[type="radio"]{display:none}
    .rol-lbl{display:flex;flex-direction:column;align-items:center;padding:14px 10px;border:2px solid var(--cream3);border-radius:10px;cursor:pointer;transition:all .18s;background:var(--cream);text-align:center}
    .rol-lbl:hover{border-color:var(--gold);background:#fff}
    .rol-radio input:checked + .rol-lbl{border-color:var(--gold);background:#fffbf0;box-shadow:0 0 0 3px rgba(200,136,42,.14)}
    .rol-em{font-size:1.7rem;display:block;margin-bottom:5px}
    .rol-nm{font-weight:700;font-size:.85rem;color:var(--navy)}
    .rol-ds{font-size:.73rem;color:var(--muted);margin-top:2px;line-height:1.3}
  </style>
</head>
<body>
<div class="reg-wrap">
  <div class="reg-logo">
    <h1>Nariño<em>Fest</em></h1>
    <p>Crea tu cuenta para unirte</p>
  </div>
  <div class="reg-card">
    <h2>Registro Nuevo Usuario</h2>
    <p class="sub">Completa todos los datos para crear tu cuenta</p>
    <% String error = (String) request.getAttribute("errorRegistro"); %>
    <% if (error != null) { %>
    <div class="nf-alert nf-alert-danger"><i class="bi bi-exclamation-circle-fill"></i><%= error %></div>
    <% } %>
    <form action="ServletUsuarios" method="POST">
      <input type="hidden" name="accion" value="registrar">
      <div class="row3 nf-field">
        <div>
          <label class="nf-label">Nombre completo *</label>
          <input type="text" class="nf-input" name="nombre" placeholder="Carlos Andrade" required>
        </div>
        <div>
          <label class="nf-label">Edad *</label>
          <input type="number" class="nf-input" name="edad" placeholder="25" min="1" max="120" required>
        </div>
      </div>
      <div class="nf-field">
        <label class="nf-label">Correo Electrónico *</label>
        <input type="email" class="nf-input" name="correo" placeholder="correo@ejemplo.com" required>
        <p class="nf-hint">Será tu identificador único en el sistema</p>
      </div>
      <div class="row2 nf-field">
        <div>
          <label class="nf-label">Contraseña *</label>
          <div class="nf-input-group">
            <input type="password" class="nf-input" name="contrasena" id="pw" minlength="4" required>
            <button type="button" class="nf-input-btn" onclick="tp('pw','ei')"><i class="bi bi-eye" id="ei"></i></button>
          </div>
        </div>
        <div>
          <label class="nf-label">Confirmar *</label>
          <input type="password" class="nf-input" id="pw2" placeholder="Repetir contraseña">
        </div>
      </div>
      <div class="nf-field">
        <label class="nf-label">¿Cómo participas? *</label>
        <div class="rol-grid">
          <label class="rol-radio">
            <input type="radio" name="rol" value="asistente" required>
            <span class="rol-lbl">
              <span class="rol-em">🎟️</span>
              <span class="rol-nm">Asistente</span>
              <span class="rol-ds">Ver eventos</span>
            </span>
          </label>
          <label class="rol-radio">
            <input type="radio" name="rol" value="organizador">
            <span class="rol-lbl">
              <span class="rol-em">🎤</span>
              <span class="rol-nm">Organizador</span>
              <span class="rol-ds">Gestionar eventos</span>
            </span>
          </label>
          <label class="rol-radio">
            <input type="radio" name="rol" value="admin">
            <span class="rol-lbl">
              <span class="rol-em">🛠️</span>
              <span class="rol-nm">Administrador</span>
              <span class="rol-ds">Control total</span>
            </span>
          </label>
        </div>
      </div>
      <button type="submit" class="btn btn-green btn-w100" style="padding:13px;font-size:.95rem">
        <i class="bi bi-person-check"></i>Registrarse
      </button>
      <a href="index.jsp" class="btn btn-ghost btn-w100" style="padding:11px;font-size:.88rem;margin-top:8px;justify-content:center">Cancelar</a>
    </form>
  </div>
  <p class="reg-foot">¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión</a></p>
  <a href="index.jsp" class="back-link"><i class="bi bi-arrow-left" style="margin-right:4px"></i>Volver al inicio</a>
</div>
<script>function tp(id,ic){var i=document.getElementById(id),e=document.getElementById(ic);i.type=i.type==='password'?'text':'password';e.className=i.type==='text'?'bi bi-eye-slash':'bi bi-eye'}</script>
</body></html>
