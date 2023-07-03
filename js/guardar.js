// Para comprobar si es un producto enviado o en envio
$('#guardarDespues').on('click', function (event) {
    if ($('#idEstado').val() == "1" || $('#tipousu').val() != "0") {
        $('#exampleModal').modal('hide');
        setTimeout(function () {
            if ($('form')[0].checkValidity()) {
                guardar();
            } else {
                $('form')[0].reportValidity();
                return;
            }
        }, 1000);        
    } else {
        guardar();
    }    
});

function guardar() {
    //Primero estos porque son campos obligatorios
    var autor = "";
    // Se comprueba que el campo sea visible
    if ($('#autor').is(':visible')) {
        if (arrayAutor.length > 0) {
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
            if ($('#txtAutor').val() != '' && $('#txtCVU').val() != '') {
                if ($('#txtAutorhidd').val().includes($('#txtAutor').val())) {
                    autor = $('#txtAutorhidd').val() + ';' + $('#txtCVU').val();
                } else {
                    autor = $('#txtAutor').val() + ';' + $('#txtCVU').val();
                }

            } else if ($('#txtAutor').val() == '' && $('#txtCVU').val() != '') {
                autor = ';' + $('#txtCVU').val();
            } else {
                autor = $('#txtAutor').val();
            }
        }
    }

    var asesor = "";
    if ($('#asesor').is(':visible')) {
        if (arrayAsesor.length > 0) {
            if ($('#txtAsesor').val() != '' && $('#txtAsesorCVU').val() != '') {
                // Comprueba si el input hidden tiene algo, si es así fue por consulta
                if ($('#txtAsesorhidd').val().includes($('#txtAsesor').val())) {
                    asesor = arrayAsesor.join('||') + '||' + $('#txtAsesorhidd').val() + ';' + $('#txtAsesorCVU').val();
                } else {
                    asesor = arrayAsesor.join('||') + '||' + $('#txtAsesor').val() + ';' + $('#txtAsesorCVU').val();
                }
            } else {
                asesor = arrayAsesor.join('||');
            }
        } else {
            if ($('#txtAsesor').val() != '' && $('#txtAsesorCVU').val() != '') {
                if ($('#txtAsesorhidd').val().includes($('#txtAsesor').val())) {
                    asesor = $('#txtAsesorhidd').val() + ';' + $('#txtAsesorCVU').val();
                }
                else {
                    asesor = $('#txtAsesor').val() + ';' + $('#txtAsesorCVU').val();
                }
            } else if ($('#txtAsesor').val() == '' && $('#txtAsesorCVU').val() != '') {
                asesor = ';' + $('#txtAsesorCVU').val();

            } else {
                asesor = $('#txtAsesor').val();
            }
        }
    }

    var patrocinador = "";
    if ($('#patrocinador').is(':visible')) {
        if (arrayPatrocinador.length > 0) {
            if ($('#txtPatrocinador').val() != '' && $('#txtPatrocinadorVol').val() != '') {
                patrocinador = arrayPatrocinador.join('||') + '||' + $('#txtPatrocinador').val() + ';' + $('#txtPatrocinadorVol').val();;
            } else {
                patrocinador = arrayPatrocinador.join('||');
            }
        } else {
            if ($('#txtPatrocinador').val() != '' && $('#txtPatrocinadorVol').val() != '') {
                patrocinador = $('#txtPatrocinador').val() + ';' + $('#txtPatrocinadorVol').val();
            } else if ($('#txtPatrocinador').val() == '' && $('#txtPatrocinadorVol').val() != '') {
                patrocinador = ';' + $('#txtPatrocinadorVol').val();
            } else {
                patrocinador = $('#txtPatrocinador').val();
            }
        }
    }

    // Después estos campos porque pueden ir dos o más
    var correo = "";
    if ($('#email').is(':visible')) {
        if (arrayEmail.length > 0) {
            if ($('#txtEmail').val() != '') {
                correo = arrayEmail.join('||') + '||' + $('#txtEmail').val();
            } else {
                correo = arrayEmail.join('||');
            }
        } else {
            correo = $('#txtEmail').val();
        }
    }

    var proyecto = "";
    if ($('#proyecto').is(':visible')) {
        if (arrayProyecto.length > 0) {
            if ($('#txtProyecto').val() != '') {
                proyecto = arrayProyecto.join('||') + '||' + $('#txtProyecto').val();
            } else {
                proyecto = arrayProyecto.join('||');
            }
        } else {
            proyecto = $('#txtProyecto').val();
        }
    }

    var palabras = "";
    if (arrayPalabras.length > 0) {
        if ($('#txtPalabrasCve').val() != '') {
            palabras = arrayPalabras.join('||') + '||' + $('#txtPalabrasCve').val();
        } else {
            palabras = arrayPalabras.join('||');
        }
    } else {
        palabras = $('#txtPalabrasCve').val();
    }

    var datos = "";
    if (arrayDatos.length > 0) {
        if ($('#txtDatos').val() != '') {
            datos = arrayDatos.join('||') + '||' + $('#txtDatos').val();
        } else {
            datos = arrayDatos.join('||');
        }
    } else {
        datos = $('#txtDatos').val();
    }

    var coleccion = "", tipoArticulo = "", titulo = "", articulo = "", colaboracion = "", grado = "", monografia = "", resumen = "", citacion = "", fechapublicacion = "", descripcion = "", rango = "", arbitrado = "", isbn = "", publicador = "", institucion = "", edicion = "", candidato = "", patente = "", paginas = "", tiraje = "", idioma = "", pais = "", publicacion = "", fechafinalizacion = "", dcarea = "", area = "", audiencia = "", financiamiento = "", licencia = "", url = "", uatnumber = "", uatvol = "", uattitle = "", uatcampo = "", uatdisciplina = "";

    tipoArticulo = sessionStorage.getItem("producto");
    coleccion = sessionStorage.getItem("coleccion");
    if ($('#titulo').is(':visible')) {
        titulo = $('#txtTitulo').val();
    }
    if ($('#articulo').is(':visible')) {
        articulo = $('#selectArticulo').val();
    }
    if ($('#colaboracion').is(':visible')) {
        colaboracion = $('#txtColaboracion').val();
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
    }
    if ($('#arbitrado').is(':visible')) {
        arbitrado = $('#selectArbitrado').val();
    }
    if ($('#isbn').is(':visible')) {
        isbn = $('#txtISBN').val();
    }
    if ($('#publicador').is(':visible')) {
        publicador = $('#txtPublicador').val();
    }
    if ($('#institucion').is(':visible')) {
        institucion = $('#txtInstitucion').val();
    }
    if ($('#edicion').is(':visible')) {
        edicion = $('#selectEdicion').val();
    }
    if ($('#candidato').is(':visible')) {
        candidato = $('#txtCandidato').val();
    }
    if ($('#identificacion').is(':visible')) {
        patente = $('#txtIdentificacion').val();
    }
    if ($('#paginas').is(':visible')) {
        paginas = $('#txtPaginas').val();
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
            //var JsonD = $.parseJSON(valor.d)
            //if (JsonD.success == 1) {
            //    alert('Producto guardado correctamente');
            //} else {
            //    if (JsonD.success == 2) {
            //        alert('Ocurrió un error');
            //    }
            //}
            if ($('#tipousu').val() != "0") {
                window.location = document.referrer;
            } else {
                window.location.href = "Inicio.aspx";
            }

        }
    });
};

$('#guardaAutor').on('click', function () {
    $('#guardarDespues').trigger('click');
});