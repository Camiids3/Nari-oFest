<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>
<div class="container mt-4">

    <!-- Agregar Evento -->
    <h2>Agregar Evento</h2>
    <form action ="ServletEventos" method="POST" class="mb-5">
        
        <input type="hidden" name="accion" value="agregar"/>
        <div class="mb-3">
            <label class="form-label">Nombre del evento</label>
            <input type="text" class="form-control" name="nombreEvento" placeholder="Nombre del evento" required="">
        </div>
        <div class="mb-3">
            <label class="form-label">Descripcion</label>
            <textarea class="form-control" name="descripcion" required rows="3" placeholder="Descripcion del evento"></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">Categoría</label>
            <input type="text" class="form-control" name="categoria" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Lugar</label>
            <input type="text" class="form-control" name="lugar" placeholder="Lugar del evento" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Fecha</label>
            <input type="date" class="form-control" name="fecha" required="">
        </div>
        <div class="mb-3">
            <label class="form-label">Hora</label>
            <input type="time" class="form-control" name="hora" required>
        </div>


        <div class="mb-3">
            <label class="form-label">Capacidad</label>
            <input type="number" class="form-control" name="capacidad" placeholder="Numero maximo de asistentes" required>
        </div>


        <button type="submit" class="btn btn-primary">Guardar</button>
        <a href="listaEvento.jsp" class="btn btn-secondary">Cancelar</a>
    </form>

    <hr>
</div>




<%@include file="/lib/footer.jsp"%>
