<%@include file="../lib/header.jsp"%>

<div class="container mt-5 text-center">
    <h1 class="mb-2">Bienvenido a JavaWebFest</h1>
    <p class="text-muted mb-5">Selecciona una sección para comenzar</p>

    <div class="d-flex justify-content-center gap-4">
        <a href="./listaUsers.jsp" class="btn btn-primary btn-lg px-5 py-4 fs-4">
            Usuarios
        </a>
        <a href="./listaEvento.jsp" class="btn btn-success btn-lg px-5 py-4 fs-4">
            Eventos
        </a>
    </div>
</div>

<%@include file="../lib/footer.jsp"%>