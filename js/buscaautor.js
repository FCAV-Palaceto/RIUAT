$(function () {
    // Inicializa el plugin
    $("#txtAutor").autocomplete({
        // El origen de los datos: request los datos que envía (la búsqueda), response lo que regresa
        source: function (request, response) {
            var arrayReturn = [];
            $.ajax({
                url: 'WebService.asmx/GetAuthor',
                method: 'POST',
                contentType: 'application/json; charset=utf-8',
                // Convertir el request en json: tiene que ser request.term porque así lo envía el plugin
                data: JSON.stringify({ term: request.term }),
                dataType: 'json',
                success: function (data) {
                    // Recupera y lee la lista, se guarda en un array
                    for (var i = 0; i < data.d.length; i++) {
                        var nombre = data.d[i].nombres + " " + data.d[i].primerApellido + " " + data.d[i].segundoApellido;
                        nombre = nombre.replace(null, "");

                        var cvu = "";
                        if (data.d[i].idOrcid != null) {
                            cvu = data.d[i].idOrcid;
                        } else if (data.d[i].idCvuConacyt != null) {
                            cvu = data.d[i].idCvuConacyt;
                        } else if (data.d[i].curp != null) {
                            cvu = data.d[i].curp;
                        }
                        //value es lo que se insertará en el input, data es adicional, data es para el segundo input
                        arrayReturn.push({ 'value': nombre.trim(), 'data': cvu });
                    }
                    // El responde es la data que va a regresar
                    response(arrayReturn);
                },
                error: function (err) {
                    alert(err);
                }
            });
        },
        // el tiemp oen milisegundos antes de comenzar a buscar una vez que se deja de teclear
        delay: 500,
        // la cantidad mínima de caracteres antes de comenzar a buscar
        minLength: 1,
        // al seleccionar un autor, guarda su orcid, cvu o curp en otro input con data
        select: function (event, ui) {
            $('#txtAutorhidd').val(ui.item.value+"1");
            $('#txtCVU').val(ui.item.data);
        }
    });
});

$(function () {
    $("#txtCVU").autocomplete({
        source: function (request, response) {
            var arrayReturn = [];
            $.ajax({
                url: 'WebService.asmx/ObtenAutor',
                method: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ term: request.term }),
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.d.length; i++) {
                        var nombre = data.d[i].nombres + " " + data.d[i].primerApellido + " " + data.d[i].segundoApellido;
                        nombre = nombre.replace(null, "");

                        var cvu = $('#txtCVU').val().trim().toUpperCase();

                        // label es lo que se muestra en la busqueda, si no se delcara es el mismo que value
                        arrayReturn.push({ 'label': nombre.trim(), 'value': cvu });
                    }
                    response(arrayReturn);
                },
                error: function (err) {
                    alert(err);
                }
            });
        },
        delay: 500,
        minLength: 1,
        select: function (event, ui) {
            $('#txtAutorhidd').val(ui.item.label + "1");
            $('#txtAutor').val(ui.item.label);
        }
    });
});

$(function () {
    $("#txtAsesor").autocomplete({
        source: function (request, response) {
            var arrayReturn = [];
            $.ajax({
                url: 'WebService.asmx/GetAuthor',
                method: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ term: request.term }),
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.d.length; i++) {
                        var nombre = data.d[i].nombres + " " + data.d[i].primerApellido + " " + data.d[i].segundoApellido;
                        nombre = nombre.replace(null, "");

                        var cvu = "";
                        if (data.d[i].idOrcid != null) {
                            cvu = data.d[i].idOrcid;
                        } else if (data.d[i].idCvuConacyt != null) {
                            cvu = data.d[i].idCvuConacyt;
                        } else if (data.d[i].curp != null) {
                            cvu = data.d[i].curp;
                        }

                        arrayReturn.push({ 'value': nombre.trim(), 'data': cvu });
                    }
                    response(arrayReturn);
                },
                error: function (err) {
                    alert(err);
                }
            });
        },
        delay: 500,
        minLength: 1,
        select: function (event, ui) {
            $('#txtAsesorhidd').val(ui.item.value + "1");
            $('#txtAsesorCVU').val(ui.item.data);
        }
    });
});

$(function () {
    $("#txtAsesorCVU").autocomplete({
        source: function (request, response) {
            var arrayReturn = [];
            $.ajax({
                url: 'WebService.asmx/ObtenAutor',
                method: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ term: request.term }),
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.d.length; i++) {
                        var nombre = data.d[i].nombres + " " + data.d[i].primerApellido + " " + data.d[i].segundoApellido;
                        nombre = nombre.replace(null, "");

                        var cvu = $('#txtAsesorCVU').val().trim().toUpperCase();

                        arrayReturn.push({ 'label': nombre.trim(), 'value': cvu });
                    }
                    response(arrayReturn);
                },
                error: function (err) {
                    alert(err);
                }
            });
        },
        delay: 500,
        minLength: 1,
        select: function (event, ui) {
            $('#txtAsesorhidd').val(ui.item.label + "1");
            $('#txtAsesor').val(ui.item.label);
        }
    });
});