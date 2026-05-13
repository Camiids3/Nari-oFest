<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Modelo.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <link rel="stylesheet" href="./styles/style.css">
  <title>NariñoFest — Iniciar Sesión</title>
  <style>
    body{background:linear-gradient(160deg,#0d1b3e 0%,#162040 55%,#1a2548 100%);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:30px 16px;position:relative;overflow:hidden}
    body::before{content:'🎭';position:absolute;right:-30px;bottom:-40px;font-size:20rem;opacity:.04;pointer-events:none;line-height:1}
    body::after{content:'';position:absolute;left:0;top:0;right:0;height:3px;background:linear-gradient(90deg,var(--red),var(--gold))}
    .login-wrap{width:100%;max-width:430px;position:relative;z-index:1}
    .login-logo{text-align:center;margin-bottom:28px}
    .login-logo h1{font-family:'Cormorant Garamond',serif;font-size:3rem;font-weight:700;color:var(--gold);margin:0;line-height:1}
    .login-logo h1 em{color:var(--red2);font-style:italic}
    .login-logo p{color:rgba(255,255,255,.4);font-size:.82rem;margin-top:6px;letter-spacing:.5px}
    .login-card{background:var(--white);border-radius:20px;padding:38px 36px;box-shadow:0 30px 80px rgba(0,0,0,.5);border-top:4px solid var(--gold)}
    .login-card h2{font-family:'Cormorant Garamond',serif;font-size:1.45rem;color:var(--navy);text-align:center;margin-bottom:5px}
    .login-card .sub{text-align:center;color:var(--muted);font-size:.83rem;margin-bottom:26px;padding-bottom:22px;border-bottom:1px solid var(--cream2)}
    .login-foot{text-align:center;margin-top:20px;font-size:.83rem;color:rgba(255,255,255,.4)}
    .login-foot a{color:var(--gold2);text-decoration:none;font-weight:600}
    .login-foot a:hover{color:var(--gold);text-decoration:underline}
    .back-link{display:block;text-align:center;margin-top:14px;color:rgba(255,255,255,.3);font-size:.78rem;text-decoration:none}
    .back-link:hover{color:rgba(255,255,255,.6)}
  </style>
</head>
<body>
<div class="login-wrap">
  <div class="login-logo">
    <h1>Nariño<em>Fest</em></h1>
    <p>Sistema de Gestión de Eventos Culturales</p>
  </div>
  <div class="login-card">
    <h2>Acceso al sistema</h2>
    <p class="sub">Ingresa tus datos para continuar</p>
    <% String error = (String) request.getAttribute("errorLogin"); %>
    <% if (error != null) { %>
    <div class="nf-alert nf-alert-danger"><i class="bi bi-exclamation-circle-fill"></i><%= error %></div>
    <% } %>
    <form action="ServletUsuarios" method="POST">
      <input type="hidden" name="accion" value="login">
      <div class="nf-field">
        <label class="nf-label">Correo Electrónico</label>
        <input type="email" class="nf-input" name="correo" placeholder="usuario@ejemplo.com" required>
      </div>
      <div class="nf-field">
        <label class="nf-label">Contraseña</label>
        <div class="nf-input-group">
          <input type="password" class="nf-input" name="contrasena" id="pw" required>
          <button type="button" class="nf-input-btn" onclick="tp('pw','ei')"><i class="bi bi-eye" id="ei"></i></button>
        </div>
      </div>
      <button type="submit" class="btn btn-navy btn-w100" style="padding:13px;font-size:.95rem;margin-top:6px">
        <i class="bi bi-box-arrow-in-right"></i>Iniciar Sesión
      </button>
    </form>
  </div>
  <p class="login-foot">¿No tienes cuenta? <a href="registroUsers.jsp">Regístrate aquí</a></p>
  <a href="index.jsp" class="back-link"><i class="bi bi-arrow-left" style="margin-right:4px"></i>Volver al inicio</a>
</div>
<script>function tp(id,ic){var i=document.getElementById(id),e=document.getElementById(ic);i.type=i.type==='password'?'text':'password';e.className=i.type==='text'?'bi bi-eye-slash':'bi bi-eye'}</script>
</body></html>
