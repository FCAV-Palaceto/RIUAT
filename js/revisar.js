$('#btnAlta').on('click', function() {
    var anchor = document.createElement('a');
    anchor.href = 'https://catalogs.repositorionacionalcti.mx/RegistroPersona.jsp';
    anchor.target = "_blank";
    anchor.click();
});

$('#btnEditar').on('click', function() {
    var id = $('#idprod').val();
    modificaProducto(id);
});