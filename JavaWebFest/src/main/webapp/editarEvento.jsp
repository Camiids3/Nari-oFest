<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>

<div class="container mt-4">
    <h2>Editar Evento</h2>
    <%
        String idStr = request.getParameter("IdEvento");
        Evento eventoEditar = null;
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            for (Evento ev : BaseDatos.listaEventos) {
                if (ev.getIdEvento() == id) {
                    eventoEditar = ev;
                    break;
                }
            }
        }
    %>

    <form action="ServletEventos" method="POST" class="mb-5">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="IdEvento" value="<%= (eventoEditar != null) ? eventoEditar.getIdEvento() : ""%>"/>

        <div class="mb-3">
            <label class="form-label">Nombre del evento</label>
            <input type="text" class="form-control" name="nombreEvento"
                   required value="<%= (eventoEditar != null) ? eventoEditar.getNombreEvento() : ""%>">
        </div>

        <div class="mb-3">
            <label class="form-label">Descripción</label>
            <textarea class="form-control" name="descripcion" required rows="3" placeholder="Descripción del evento">
                <%= (eventoEditar != null) ? eventoEditar.getDescripcion() : ""%>
            </textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Categoría</label>
            <input type="text" class="form-control" name="categoria"
                   required value="<%= (eventoEditar != null) ? eventoEditar.getCategoria() : ""%>">
        </div>

        <div class="mb-3">
            <label class="form-label">Lugar</label>
            <input type="text" class="form-control" name="lugar"
                   required value="<%= (eventoEditar != null) ? eventoEditar.getUbicacion() : ""%>">
        </div>

        <div class="mb-3">
            <label class="form-label">Fecha</label>
            <input type="date" name="fecha"
                   value="<%= (eventoEditar != null) ? eventoEditar.getFecha() : ""%>">
        </div>

        <div class="mb-3">
            <label class="form-label">Hora</label>
            <input type="time" name="hora"
                   value="<%= (eventoEditar != null) ? eventoEditar.getHora() : ""%>">
        </div>

        <div class="mb-3">
            <label class="form-label">Capacidad</label>
            <input type="number" name="capacidad"
                   value="<%= (eventoEditar != null) ? String.valueOf(eventoEditar.getCapacidadMax()) : ""%>">
            <button type="submit" class="btn btn-primary">Actualizar</button>
            <a href="listaEvento.jsp" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

<%@include file="/lib/footer.jsp"%>
