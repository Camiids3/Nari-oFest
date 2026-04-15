<%@include file="/lib/header.jsp"%>

<div class="container mt-4">

    <!-- Agregar Usuario -->
    <h2>Agregar Usuario</h2>
    <form action = "ServletUsuarios" method="POST" class="mb-5">
        <input type="hidden" name="accion" value="agregar"/>
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" class="form-control" name="nombre"  placeholder="Nombre completo" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" name="correo" placeholder="correo@ejemplo.com" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" class="form-control" name="contraseña" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Edad</label>
            <input type="number" class="form-control" name="edad" placeholder="Edad" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Rol</label>
            <select class="form-select" name="rol" required>
                <option value="">Seleccionar...</option>
                <option value="admin">Administrador</option>
                <option value="organizador">Organizador</option>
                <option value="usuario">Usuario</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="listaUsers.jsp" class="btn btn-secondary">Cancelar</a>
    </form>

    <hr>
    

</div>

<%@include file="/lib/footer.jsp"%>