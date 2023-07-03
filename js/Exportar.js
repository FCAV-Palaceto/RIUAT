window.onload = function () {
    document.getElementById("expor").style.display = "none";
    document.getElementById("sinexpor").style.display = "none";
};

//Tabla de productos exportados
function TablaProductos() {  //aqui se crea la tabla
    var fechainicio = $('#dateInicio').val();
    var fechafin = $('#dateFin').val();
    var obj = {};
    obj.fechainicio = fechainicio;
    obj.fechafin = fechafin;
    $.ajax({
        type: 'POST',
        url: 'Exportar.aspx/SelProductos',
        data: JSON.stringify(obj),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function (tabla) {
            $("#tabproductos").html(tabla.d); //nombre del id del div de la tabla
            setTimeout(function myfunction() {
                estiloDataTable();
            }, 100);
        }
    });
}

//Tabla de productos sin exportar
function TablaProductosSinExpo() {  //aqui se crea la tabla
    $.ajax({
        type: 'POST',
        url: 'Exportar.aspx/SelProductosSinExpo',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function (tabla) {
            $("#tabproductos2").html(tabla.d); //nombre del id del div de la tabla
            setTimeout(function myfunction() {
                estiloDataTable2();
                $('.buttons-csv').click(function () {
                    ActExportados();
                });
            }, 100);
        }
    });
}

//Estilo para la tabla 1
function estiloDataTable(page, leng) {
    $('#tabla').DataTable({
        "lengthMenu": [5, 10, 25, 50, 75, 100],
        "pageLength": leng,
        pagingType: 'numbers',
        "order": [[4, 'asc'], [1, 'asc']],
        language: {
            "decimal": ".",
            "emptyTable": "",
            "info": "Mostrando del _START_ al _END_ de un total de _TOTAL_ registros",
            "infoEmpty": "",
            "infoFiltered": "<br/>(Filtrado de _MAX_ registros en total)",
            "infoPostFix": "",
            "thousands": ",",
            "lengthMenu": "Mostrando _MENU_ registros",
            "loadingRecords": "Cargando...",
            "processing": "Procesando...",
            "search": "B&uacute;squeda:",
            "zeroRecords": "No hay registros",
        }, dom: 'Bfrtip',
        buttons: [
            'csv', 'excel'
        ]

    });
};

//Estilo para la tabla 2
function estiloDataTable2(page, leng) {
    $('#tabla2').DataTable({
        "lengthMenu": [5, 10, 25, 50, 75, 100],
        "pageLength": leng,
        pagingType: 'numbers',
        "order": [[4, 'asc'], [1, 'asc']],
        language: {
            "decimal": ".",
            "emptyTable": "",
            "info": "Mostrando del _START_ al _END_ de un total de _TOTAL_ registros",
            "infoEmpty": "",
            "infoFiltered": "<br/>(Filtrado de _MAX_ registros en total)",
            "infoPostFix": "",
            "thousands": ",",
            "lengthMenu": "Mostrando _MENU_ registros",
            "loadingRecords": "Cargando...",
            "processing": "Procesando...",
            "search": "B&uacute;squeda:",
            "zeroRecords": "No hay registros",
        }, dom: 'Bfrtip',
        buttons: [
            'csv', 'excel'
        ]

    });
};

// Función para que el día máximo sea hoy y asignar el valor por defecto de los dates
$(function(){
    var dtToday = new Date();

    var monthac = dtToday.getMonth();
    var dayac = dtToday.getDate() - 1;
    var yearac = dtToday.getFullYear();

    if (monthac < 10)
        monthac = '0' + monthac.toString();
    if (dayac < 10)
        dayac = '0' + dayac.toString();

    var actDate = yearac + '-' + monthac + '-' + dayac;

    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();

    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var maxDate = year + '-' + month + '-' + day;
    $('#dateInicio').attr('max', maxDate);
    $('#dateInicio').val(actDate);
    $('#dateFin').attr('max', maxDate);
    $('#dateFin').val(maxDate);
});

function ActExportados() {
    $.ajax({
        type: 'POST',
        url: 'Exportar.aspx/ActExport',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error" + jqXHR.responseText);
        },
        success: function (valor) {
            var JsonD = $.parseJSON(valor.d)
            if (JsonD.success == 1) {
                PNotify.success({
                    text: 'Los metadatos se exportaron correctamente.',
                    delay: 3000,
                    addClass: 'translucent'
                });
            }
        }
    });
}