$('#btnSiguiente').on('click', function(event){
    //Primero estos porque son campos obligatorios
    var autor = "";
    // Se comprueba que el campo sea visible
    if ($('#autor').is(':visible')){
        if (arrayAutor.length > 0){
            if ($('#txtAutor').val() != '' && $('#txtCVU').val() != '') {
                // Comprueba si el input hidden tiene algo, si es así fue por consulta
                if ($('#txtAutorhidd').val().includes($('#txtAutor').val())) {
                    autor = arrayAutor.join('||') + '||' + $('#txtAutorhidd').val() + ';' + $('#txtCVU').val();
                } else {
                    autor = arrayAutor.join('||') + '||' + $('#txtAutor').val() + ';' + $('#txtCVU').val();
                }
            } else {
                autor = arrayAutor.join('||');
            }
        } else {
            if ($('#txtAutor').val() == '' || $('#txtCVU').val() == '') {
                $('#autorAlert').removeClass('d-none');
                // Este if solo es para mover el puntero al campo que esté vacío
                if($('#txtAutor').val() == ''){
                    $('#txtAutor').focus();
                } else {
                    $('#txtCVU').focus();
                }
                event.preventDefault();
                return;
            } else {
                if ($('#txtAutorhidd').val().includes($('#txtAutor').val())) {
                    autor = $('#txtAutorhidd').val() + ';' + $('#txtCVU').val();
                } else {
                    autor = $('#txtAutor').val() + ';' + $('#txtCVU').val();
                }
            }
        }
    }

    var correo = "";
    if ($('#email').is(':visible')) {
        if (arrayEmail.length > 0) {
            if ($('#txtEmail').val() != '') {
                correo = arrayEmail.join('||') + '||' + $('#txtEmail').val();
            } else {
                correo = arrayEmail.join('||');
            }
        } else {
            //correo = $('#txtEmail').val();
            $('#emailAlert2').removeClass('d-none');
            $('#txtEmail').focus();

            event.preventDefault();
            return;
        }
    }

    var asesor = "";
    if($('#asesor').is(':visible')){
        if (arrayAsesor.length > 0){
            if ($('#txtAsesor').val() != '' && $('#txtAsesorCVU').val() != '') {
                if ($('#txtAsesorhidd').val().includes($('#txtAsesor').val())) {
                    asesor = arrayAsesor.join('||') + '||' + $('#txtAsesorhidd').val() + ';' + $('#txtAsesorCVU').val();
                }
                else {
                    asesor = arrayAsesor.join('||') + '||' + $('#txtAsesor').val() + ';' + $('#txtAsesorCVU').val();
                }
                
            } else {
                asesor = arrayAsesor.join('||');
            }
        } else {
            if ($('#txtAsesor').val() == '' || $('#txtAsesorCVU').val() == '') {
                $('#asesorAlert').removeClass('d-none');
                if($('#txtAsesor').val() == ''){
                    $('#txtAsesor').focus();
                } else {
                    $('#txtAsesorCVU').focus();
                }
                event.preventDefault();
                return;
            } else {
                if ($('#txtAsesorhidd').val().includes($('#txtAsesor').val())) {
                    asesor = $('#txtAsesorhidd').val() + ';' + $('#txtAsesorCVU').val();
                }
                else {
                    asesor = $('#txtAsesor').val() + ';' + $('#txtAsesorCVU').val();
                }
            }
        }
    }

    var patrocinador = "";
    if($('#patrocinador').is(':visible')){
        if (arrayPatrocinador.length > 0){
            if($('#txtPatrocinador').val() != '' && $('#txtPatrocinadorVol').val() != ''){
                patrocinador = arrayPatrocinador.join('||') + '||' + $('#txtPatrocinador').val() + ';' + $('#txtPatrocinadorVol').val();;
            } else {
                patrocinador = arrayPatrocinador.join('||');
            }
        } else {
            if ($('#txtPatrocinador').val() == '' || $('#txtPatrocinadorVol').val() == '') {
                $('#patrocinadorAlert').removeClass('d-none');
                if($('#txtPatrocinador').val() == ''){
                    $('#txtPatrocinador').focus();
                } else {
                    $('#txtPatrocinadorVol').focus();
                }
                event.preventDefault();
                return;
            } else {
                patrocinador = $('#txtPatrocinador').val() + ';' + $('#txtPatrocinadorVol').val();
            }
        }
    }

    // Después estos campos porque pueden ir dos o más    
    var proyecto = "";
    if ($('#proyecto').is(':visible')){
        if (arrayProyecto.length > 0){
            if ($('#txtProyecto').val() != ''){
                proyecto = arrayProyecto.join('||')  + '||' + $('#txtProyecto').val();
            } else {
                proyecto = arrayProyecto.join('||');
            }
        } else {
            proyecto = $('#txtProyecto').val();
        }
    }

    var palabras = "";
    if (arrayPalabras.length > 0){
        if ($('#txtPalabrasCve').val() != ''){
            palabras = arrayPalabras.join('||')  + '||' + $('#txtPalabrasCve').val();
        } else {
            palabras = arrayPalabras.join('||');
        }
    } else {
        //palabras = $('#txtPalabrasCve').val();
        $('#palabrasAlert3').removeClass('d-none');
        $('#txtPalabrasCve').focus();

        event.preventDefault();
        return;
    }

    var datos = "";
    if (arrayDatos.length > 0){
        if ($('#txtDatos').val() != ''){
            datos = arrayDatos.join('||')  + '||' + $('#txtDatos').val();
        } else {
            datos = arrayDatos.join('||');
        }
    } else {
        datos = $('#txtDatos').val();
    }

    var coleccion = "", tipoArticulo = "", titulo = "", articulo = "", colaboracion = "", grado = "", monografia = "", resumen = "", citacion = "", fechapublicacion = "", descripcion = "", rango = "", arbitrado = "", isbn = "", publicador = "", institucion = "", edicion = "", candidato = "", patente = "", paginas = "", tiraje = "", idioma = "", pais = "", publicacion = "", fechafinalizacion = "", dcarea = "", area = "", audiencia = "", financiamiento = "", licencia = "", url = "", uatnumber = "", uatvol = "", uattitle = "", uatcampo = "", uatdisciplina = "";

    coleccion = sessionStorage.getItem("coleccion");
    tipoArticulo = sessionStorage.getItem("producto");
    if ($('#titulo').is(':visible')) {
        titulo = $('#txtTitulo').val();
    }
    if ($('#articulo').is(':visible')) {
        articulo = $('#selectArticulo').val();
        $('#selectArticulo').attr('required', 'required');
    }
    if ($('#colaboracion').is(':visible')) {
        colaboracion = $('#txtColaboracion').val();
		$('#txtColaboracion').attr('required', 'required');
    }
    if ($('#grado').is(':visible')) {
        grado = $('#selectGrado').val();
    }
    if ($('#mono').is(':visible')) {
        monografia = $('#selectMonografia').val();
    }
    if ($('#resumen').is(':visible')) {
        resumen = $('#txtResumen').val();
    }
    if ($('#citacion').is(':visible')) {
        citacion = $('#txtCitacion').val();
    }
    if ($('#fechapublicacion').is(':visible')) {
        fechapublicacion = $('#datePublicacion').val();
    }
    if ($('#descripcion').is(':visible')) {
        if ($('#txtDescripcion').val() != '' && $('#txtDescripcionVol').val() != '') {
            descripcion = $('#txtDescripcion').val() + ';' + $('#txtDescripcionVol').val();
        } else if ($('#txtDescripcion').val() == '' && $('#txtDescripcionVol').val() != '') {
            descripcion = ';' + $('#txtDescripcionVol').val();
        } else {
            descripcion = $('#txtDescripcion').val();
        }
    }
    if ($('#rango').is(':visible')) {
        rango = $('#txtRango').val();
        $('#txtRango').attr('required', 'required');
    }
    if ($('#arbitrado').is(':visible')) {
        arbitrado = $('#selectArbitrado').val();
        $('#selectArbitrado').attr('required', 'required');
    }
    if ($('#isbn').is(':visible')) {
        isbn = $('#txtISBN').val();
    }
    if ($('#publicador').is(':visible')) {
        publicador = $('#txtPublicador').val();
        $('#txtPublicador').attr('required', 'required');
    }
    if ($('#institucion').is(':visible')) {
        institucion = $('#txtInstitucion').val();
    }
    if ($('#edicion').is(':visible')) {
        edicion = $('#selectEdicion').val();
        $('#selectEdicion').attr('required', 'required');
    }
    if ($('#candidato').is(':visible')) {
        candidato = $('#txtCandidato').val();
    }
    if ($('#identificacion').is(':visible')) {
        patente = $('#txtIdentificacion').val();
    }
    if ($('#paginas').is(':visible')) {
        paginas = $('#txtPaginas').val();
        $('#txtPaginas').attr('required', 'required');
    }
    if ($('#tiraje').is(':visible')) {
        tiraje = $('#txtTiraje').val();
    }
    if ($('#idioma').is(':visible')) {
        idioma = $('#selectIdioma').val();
    }
    if ($('#pais').is(':visible')) {
        pais = $('#selectPais').val();
    }
    if ($('#publicacion').is(':visible')) {
        publicacion = $('#selectPublicacion').val();
    }
    if ($('#finalizacion').is(':visible')) {
        fechafinalizacion = $('#dateEmbargo').val();
    }
    if ($('#area').is(':visible')) {
        dcarea = $('#areacon').val();
        area = $('#areacon').val();
    }
    if ($('#audiencia').is(':visible')) {
        audiencia = $('#selectAudiencia').val();
    }
    if ($('#financiamiento').is(':visible')) {
        financiamiento = $('#selectFinanciamiento').val();
    }
    if ($('#licencia').is(':visible')) {
        licencia = $('#selectLicencia').val();
    }
    if ($('#url').is(':visible')) {
        url = $('#txtURL').val();
    }

    // if (titulo == "" || autor == ""){
    //     alert('Completa los campos obigatorios');
    //     return;
    // }

    var obj = {};
    obj.coleccion = coleccion;
    obj.audiencia = audiencia;
    obj.asesor = asesor;
    obj.pais = pais;
    obj.fechafinalizacion = fechafinalizacion;
    obj.fechapublicacion = fechapublicacion;
    obj.resumen = resumen;
    obj.patrocinador = patrocinador;
    obj.isbn = isbn;
    obj.idioma = idioma;
    obj.publicador = publicador;
    obj.citacion = citacion;
    obj.licencia = licencia;
    obj.acceso = publicacion;
    obj.descripcion = descripcion;
    obj.dcarea = dcarea;
    obj.palabras = palabras;
    obj.titulo = titulo;
    obj.articulo = articulo;
    obj.arbitrado = arbitrado;
    obj.area = area;
    obj.autor = autor;
    obj.edicion = edicion;
    obj.correo = correo;
    obj.grado = grado;
    obj.institucion = institucion;
    obj.patente = patente;
    obj.url = url;
    obj.candidato = candidato;
    obj.tiraje = tiraje;
    obj.proyecto = proyecto;
    obj.rango = rango;
    obj.datos = datos;
    obj.paginas = paginas;
    obj.colaboracion = colaboracion;
    obj.financiamiento = financiamiento;
    obj.tipoArticulo = tipoArticulo;
    obj.monografia = monografia;

    obj.uatnumber = uatnumber;
    obj.uatvol = uatvol;
    obj.uattitle = uattitle;
    obj.uatcampo = uatcampo;
    obj.uatdisciplina = uatdisciplina;

    if ($('form')[0].checkValidity()) {
        event.preventDefault();
        $.ajax({
            type: 'POST',
            url: 'Producto.aspx/GuardarProducto',
            data: JSON.stringify(obj),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error" + jqXHR.responseText);
            },
            success: function (valor) {
                var JsonD = $.parseJSON(valor.d)
                //if (JsonD.success == 1){
                //    alert('Producto guardado correctamente');
                //} else {
                //    if (JsonD.success == 2) {
                //        alert('Por favor, revise que los datos sean correctos');
                //    }
                //}

                $('#id').val(JsonD.success);
                // indica si son uno o más autores
                if (arrayAutor.length > 1) {
                    sessionStorage.setItem("cantAutores", arrayAutor.length);
                } else {
                    sessionStorage.setItem("cantAutores", arrayAutor.length);
                }
                window.location.href = "Cargar.aspx";
            }
        });
    } else {
        $('form')[0].reportValidity();
        return;
    }
});

function DelProducto(id) {
    var idProducto = id;
    $('#modalEliminar').modal('toggle');
    $('#eliminaProducto').off("click");
    $('#eliminaProducto').click(function(){
        $.ajax({
        type: 'POST',
        url: 'Inicio.aspx/EliminarProducto',
        data: "{'id':'" + idProducto + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error" + jqXHR.responseText);
        },
        success: function (valor) {
            var JsonD = $.parseJSON(valor.d)
            if (JsonD.success == 1) {
                PNotify.success({
                    //title: 'Producto Eliminado',
                    text: 'El producto se ha eliminado correctamente.',
                    delay: 3000,
                    addClass: 'translucent'
                });
                //alert('Producto eliminado');
                // Hace que se elimine también la carpeta, llama el hanlder y manda el id del producto
                $.get('Handler_deleteFolder.ashx', { id: id });
                TablaProductos();
            }
        }
        });
    });
};

function DelProductoOTG(id) {
    var idProducto = id;

    if (id == null) {
        window.location.href = "Inicio.aspx";
        return;
    } else {
        $.ajax({
        type: 'POST',
        url: 'Producto.aspx/EliminarProducto',
        data: "{'id':'" + idProducto + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error" + jqXHR.responseText);
        },
        success: function (valor) {
            var JsonD = $.parseJSON(valor.d)
            if (JsonD.success == 1) {
                // Hace que se elimine también la carpeta, llama el hanlder y manda el id del producto
                $.get('Handler_deleteFolder.ashx', { id: id });
                window.location.href = "Inicio.aspx";
                }
            }
        });
    }
};

// Comprueba si el input tiene archivos, si es así, carga los archivos y posteriormente accede a otra página, de lo contrario solo carga la sig. página
function guardaArchivo() {
    var file = $("#file-5").prop('files');
    if (file.length > 0) {
        $("#file-5").fileinput('upload');
        $("#file-5").on('fileuploaded', function (event) {
            window.location.href = "Inicio.aspx";
        });
    } else {
        window.location.href = "Inicio.aspx";
    }
};

$('#btnSigLic').on('click', function(event){
    var file = $("#file-5").prop('files');
    if (file.length > 0) {
        $("#file-5").fileinput('upload');
        $("#file-5").on('fileuploaded', function (event) {
            window.location.href = "Licencia.aspx";
        });
    } else {
        window.location.href = "Licencia.aspx";
    }
});

function limpiaVariable() {
    sessionStorage.setItem("producto", "articulo");
    // $('#btnNuevo').click();

    $.ajax({
        type: 'POST',
        url: 'Inicio.aspx/NuevoProducto',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function () {
            window.location.href = "Coleccion.aspx";
        }
    });
};

function modificaProducto(id) {
    var idProducto = id;
    $.ajax({
        type: 'POST',
        url: 'Inicio.aspx/ModificarProducto',
        data: "{'id':'" + idProducto + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function () {
            window.location.href = "Producto.aspx";
        }
    });
};

function Detalle(id) {
    var idProducto = id;
    $.ajax({
        type: 'POST',
        url: 'Inicio.aspx/Tabla',
        data: "{'id':'" + idProducto + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        },
        success: function () {
            window.location.href = "TablaConsulta.aspx";
        }
    });
};