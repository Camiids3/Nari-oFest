<%@include file="/lib/header.jsp"%>
<%@ page import="Modelo.*" %>


<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Lista de Usuarios</h2>
        <a href="adminUsers.jsp" class="btn btn-success">+ Agregar Usuario</a>
    </div>

    <table class="table table-striped table-hover">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Nombre</th>
                <th>Edad</th>
                <th>Email</th>
                <th>Rol</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (Usuario u : BaseDatos.listaUsuarios) {
            %> 

            <tr>
                <td><%= u.getIdUsuario()%></td>
                <td><%= u.getNombre()%></td>
                <td><%= u.getEdad()%></td>
                <td><%= u.getCorreo()%></td>
                <td><%= u.getRol()%></td>
                <td>
                    <form action="ServletUsuarios" method="POST" style="display:inline;">
                        <input type="hidden" name="accion" value="eliminar"/>
                        <input type="hidden" name="id" value="<%=u.getIdUsuario()%>"/>
                        <button type ="submit" class="btn btn-danger btn-sm">Eliminar</button>
                    </form>
                    <form action ="adminUsers.jsp" method="POST" style="display:inline">
                        <input type="hidden" name="id" value="<%= u.getIdUsuario()%>"/>
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