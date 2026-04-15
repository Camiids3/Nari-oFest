<%@include file="/lib/header.jsp"%>

<div class="container mt-5" style="max-width: 400px;">
    <h2 class="mb-4">Iniciar Sesion</h2>
    <form method="POST">
        <div class="mb-3">
            <label class="form-label">Correo electronico</label>
            <input type="email" class="form-control" name="email" placeholder="correo@ejemplo.com">
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="password">
        </div>
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input" id="recordar">
            <label class="form-check-label" for="recordar">Recordarme</label>
        </div>
        <button type="submit" class="btn btn-primary w-100">Ingresar</button>
    </form>
</div>

<%@include file="/lib/footer.jsp"%>
