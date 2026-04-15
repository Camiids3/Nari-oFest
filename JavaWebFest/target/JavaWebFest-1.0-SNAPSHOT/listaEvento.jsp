<%@include file="/lib/header.jsp"%>

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
      <tr>
        <td>1</td>
        <td>Conferencia Tech 2026</td>
        <td>15/04/2026</td>
        <td>Auditorio principal</td>
        <td>200</td>
        <td>
          <a href="adminEvento.jsp" class="btn btn-sm btn-warning">Editar</a>
          <a href="adminEvento.jsp" class="btn btn-sm btn-danger">Eliminar</a>
        </td>
      </tr>
      <tr>
        <td>2</td>
        <td>Taller de Innovacion</td>
        <td>22/05/2026</td>
        <td>Sala B</td>
        <td>50</td>
        <td>
          <a href="adminEvento.jsp" class="btn btn-sm btn-warning">Editar</a>
          <a href="adminEvento.jsp" class="btn btn-sm btn-danger">Eliminar</a>
        </td>
      </tr>
    </tbody>
  </table>

</div>

<%@include file="/lib/footer.jsp"%>
