$(document).on('click', 'td button.btn-info', function (event) {
    // Obtener el id de la fila que se clickea
    var fila = $(this).closest('tr').index();    

    //Convertir la tabla en un array
    var myTableArray = [];
    $("table#tabla tr").each(function () {
        var arrayOfThisRow = [];
        var tableData = $(this).find('td');
        if (tableData.length > 0) {
            tableData.each(function () { arrayOfThisRow.push($(this).text()); });
            myTableArray.push(arrayOfThisRow);
        }
    });    

    //Asignar el valor del primer elemento del array (id oculto del producto) al input (oculto también )
    $('#hiddenControl').val(myTableArray[fila][0]);
    $('#hiddenControl2').val(myTableArray[fila][2]);

    //Disparo otro botón para que genere variable de sesión con el id y se envía a la siguiente página
    $('#btnModificar').click();
});
