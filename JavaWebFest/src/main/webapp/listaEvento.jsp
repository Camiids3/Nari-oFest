<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Lista de Eventos</h2>
        <a href="adminEvento.jsp" class="btn btn-success">+ Agregar Evento</a>
    </div>

    <table class="table table-striped table-bordered">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Nombre</th>
                <th>Fecha</th>
                <th>Lugar</th>
                <th>Capacidad</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Evento e : BaseDatos.listaEventos) {
            %>    
            <tr>
                <td> <%= e.getIdEvento()%> </td>
                <td><%= e.getNombreEvento()%></td>
                <td><%= e.getFecha()%></td>
                <td><%= e.getUbicacion()%></td>
                <td><%= e.getCapacidadMax()%></td>
                <td>
                    <form action="ServletEventos" method="POST" style="display:inline;"
                          onsubmit="return confirm('¿Estás seguro de eliminar este evento?');">
                        <input type="hidden" name="accion" value="eliminar"/>
                        <input type="hidden" name="IdEvento" value="<%=e.getIdEvento()%>"/>
                        <button type ="submit" class="btn btn-danger btn-sm">Eliminar</button>
                    </form>
                    <form action ="editarEvento.jsp" method="GET" style="display:inline">
                        <input type="hidden" name="IdEvento" value="<%= e.getIdEvento()%>"/>
                        <button type="submit" class="btn btn-warning btn-sm">Editar</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>    
        </tbody>
    </table>

</div>

<%@include file="/lib/footer.jsp"%>
