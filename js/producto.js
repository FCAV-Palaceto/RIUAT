window.onload = function () {
    if (document.getElementById("product").value != "") {
        var producto = $('#product').val();
        sessionStorage.setItem("producto", producto);
    } else {
        var producto = sessionStorage.getItem("producto");
    }

    if (producto == "tesism"){
        $('#selectGrado').append($('<option>', {
            value: 'Maestría',
            text: 'Maestría',
        }));
        $('#selectGrado').append($('<option>', {
            value: 'Especialidad',
            text: 'Especialidad',
        }));
    } else if (producto == "tesisd") {
        $('#selectGrado').append($('<option>', {
            value: 'Doctorado',
            text: 'Doctorado',
        }));
        $('#selectGrado').append($('<option>', {
            value: 'Postdoctorado',
            text: 'Postdoctorado',
        }));
    }


    var productoComp = "";

    switch (producto) {
        case 'articulo':
            $('#colaboracion').hide();
            $('#email').hide();
            $('#grado').hide();
            $('#asesor').hide();
            $('#patrocinador').hide();
            $('#mono').hide();
            $('#arbitrado').hide();
            $('#isbn').hide();
            $('#publicador').hide();
            //$('#institucion').hide();
            $('#edicion').hide();
            $('#candidato').hide();
            $('#identificacion').hide();
            $('#paginas').hide();
            $('#tiraje').hide();
            $('#proyecto').hide();
            $('#selectGrado').removeAttr('required');
            $('#txtISBN').removeAttr('required');
            $('#txtCandidato').removeAttr('required');
            $('#txtIdentificacion').removeAttr('required');
            productoComp = "Artículo";
            break;
        case 'libro':
            $('#articulo').hide();
            $('#email').hide();
            $('#grado').hide();
            $('#asesor').hide();
            $('#patrocinador').hide();
            $('#mono').hide();
            $('#descripcion').hide();
            $('#rango').hide();
            //$('#institucion').hide();
            $('#candidato').hide();
            $('#identificacion').hide();
            $('#finalizacion').hide();
            $('#selectGrado').removeAttr('required');
            $('#txtDescripcion').removeAttr('required');
            $('#txtDescripcionVol').removeAttr('required');
            $('#txtCandidato').removeAttr('required');
            $('#txtIdentificacion').removeAttr('required');
            productoComp = "Libro";
            break;
        case 'capitulo':
            $('#articulo').hide();
            $('#colaboracion').hide();
            $('#email').hide();
            $('#grado').hide();
            $('#asesor').hide();
            $('#patrocinador').hide();
            $('#mono').hide();
            $('#isbn').hide();
            $('#publicador').hide();
            //$('#institucion').hide();
            $('#candidato').hide();
            $('#identificacion').hide();
            $('#paginas').hide();
            $('#finalizacion').hide();
            $('#proyecto').hide();
            $('#selectGrado').removeAttr('required');
            $('#txtISBN').removeAttr('required');
            $('#txtCandidato').removeAttr('required');
            $('#txtIdentificacion').removeAttr('required');
            productoComp = "Capítulo de Libro";
            break;
        case 'tesism':            
        case 'tesisd':
            $('#articulo').hide();
            $('#colaboracion').hide();
            $('#patrocinador').hide();
            $('#mono').hide();
            $('#descripcion').hide();
            $('#rango').hide();
            $('#arbitrado').hide();
            $('#isbn').hide();
            $('#edicion').hide();
            $('#candidato').hide();
            $('#identificacion').hide();
            $('#tiraje').hide();
            $('#finalizacion').hide();
            $('#txtDescripcion').removeAttr('required');
            $('#txtDescripcionVol').removeAttr('required');
            $('#txtISBN').removeAttr('required');
            $('#txtCandidato').removeAttr('required');
            $('#txtIdentificacion').removeAttr('required');
            if (producto == 'tesism') {
                productoComp = "Tesis de Maestría";
            } else {
                productoComp = "Tesis de Doctorado";
            }            
            break;
        case 'conjuntod':
            $('#articulo').hide();
            $('#colaboracion').hide();
            $('#email').hide();
            $('#grado').hide();
            $('#asesor').hide();
            $('#mono').hide();
            $('#citacion').hide();
            $('#descripcion').hide();
            $('#rango').hide();
            $('#arbitrado').hide();
            $('#isbn').hide();
            //$('#institucion').hide();
            $('#edicion').hide();
            $('#candidato').hide();
            $('#identificacion').hide();
            $('#paginas').hide();
            $('#tiraje').hide();
            $('#finalizacion').hide();
            $('#proyecto').hide();
            $('#selectGrado').removeAttr('required');
            $('#txtCitacion').removeAttr('required');
            $('#txtDescripcion').removeAttr('required');
            $('#txtDescripcionVol').removeAttr('required');
            $('#txtISBN').removeAttr('required');
            $('#txtCandidato').removeAttr('required');
            $('#txtIdentificacion').removeAttr('required');
            productoComp = "Conjunto de Datos";
            break;
        //case 'imagen':
        //case 'audio':
        //case 'video':
        //case 'otros':
        //    $('#articulo').hide();
        //    $('#colaboracion').hide();
        //    $('#email').hide();
        //    $('#grado').hide();
        //    $('#asesor').hide();
        //    $('#patrocinador').hide();
        //    $('#mono').hide();
        //    $('#citacion').hide();
        //    $('#descripcion').hide();
        //    $('#rango').hide();
        //    $('#arbitrado').hide();
        //    $('#isbn').hide();
        //    $('#institucion').hide();
        //    $('#edicion').hide();
        //    $('#candidato').hide();
        //    $('#identificacion').hide();
        //    $('#paginas').hide();
        //    $('#tiraje').hide();
        //    $('#finalizacion').hide();
        //    $('#proyecto').hide();
        //    $('#selectGrado').removeAttr('required');
        //    $('#txtCitacion').removeAttr('required');
        //    $('#txtDescripcion').removeAttr('required');
        //    $('#txtDescripcionVol').removeAttr('required');
        //    $('#txtISBN').removeAttr('required');
        //    $('#txtCandidato').removeAttr('required');
        //    $('#txtIdentificacion').removeAttr('required');
        //    break;
        //case 'patente':
        //    $('#articulo').hide();
        //    $('#colaboracion').hide();
        //    $('#email').hide();
        //    $('#grado').hide();
        //    $('#asesor').hide();
        //    $('#patrocinador').hide();
        //    $('#mono').hide();
        //    $('#citacion').hide();
        //    $('#descripcion').hide();
        //    $('#rango').hide();
        //    $('#arbitrado').hide();
        //    $('#isbn').hide();
        //    $('#institucion').hide();
        //    $('#edicion').hide();
        //    $('#tiraje').hide();
        //    $('#finalizacion').hide();
        //    $('#proyecto').hide();
        //    $('#selectGrado').removeAttr('required');
        //    $('#txtCitacion').removeAttr('required');
        //    $('#txtDescripcion').removeAttr('required');
        //    $('#txtDescripcionVol').removeAttr('required');
        //    $('#txtISBN').removeAttr('required');
        //    break;
        //case 'monografia':
        //    $('#articulo').hide();
        //    $('#colaboracion').hide();
        //    $('#email').hide();
        //    $('#grado').hide();
        //    $('#asesor').hide();
        //    $('#patrocinador').hide();
        //    $('#citacion').hide();
        //    $('#descripcion').hide();
        //    $('#rango').hide();
        //    $('#arbitrado').hide();
        //    $('#isbn').hide();
        //    $('#institucion').hide();
        //    $('#edicion').hide();
        //    $('#candidato').hide();
        //    $('#identificacion').hide();
        //    $('#paginas').hide();
        //    $('#tiraje').hide();
        //    $('#finalizacion').hide();
        //    $('#proyecto').hide();
        //    $('#selectGrado').removeAttr('required');
        //    $('#txtCitacion').removeAttr('required');
        //    $('#txtDescripcion').removeAttr('required');
        //    $('#txtDescripcionVol').removeAttr('required');
        //    $('#txtISBN').removeAttr('required');
        //    $('#txtCandidato').removeAttr('required');
        //    $('#txtIdentificacion').removeAttr('required');
        //    break;
    }

    $('#tituloform').html('Formulario de Captura - ' + productoComp);

    // Aquí empieza para leer de la api
    var urlareacon = "https://catalogs.repositorionacionalcti.mx/webresources/areacono";
    var urlaudiencia = "https://catalogs.repositorionacionalcti.mx/webresources/audiencia";
    var urlpais = "https://catalogs.repositorionacionalcti.mx/webresources/pais";
    var urlidioma = "https://catalogs.repositorionacionalcti.mx/webresources/idioma";
    var urllicencia = "https://catalogs.repositorionacionalcti.mx/webresources/licencia";

    fetch(urlareacon).then(function (result) {
        if (result.ok) {
            return result.json();
        }
    }).then(function (data) {
        //console.log(data);
        data.forEach(function (element) {
            let areacon = document.getElementById("areacon");
            let opt = document.createElement("option");

            opt.appendChild(document.createTextNode(element.descripcion));
            opt.value = element.descripcion + "[" + element.cveArea + "]";

            areacon.appendChild(opt);
        })
        //Atrapa errores e intenta hacer un nuevo fetch con el link sin certificado
    }).catch((error) => {
        var urlareacon = "http://catalogs.repositorionacionalcti.mx/webresources/areacono";
        fetch(urlareacon).then(function (result) {                   
            if (result.ok) {
                return result.json();
            }
        }).then(function (data) {
            //console.log(data);
            data.forEach(function (element) {
                let areacon = document.getElementById("areacon");
                let opt = document.createElement("option");

                opt.appendChild(document.createTextNode(element.descripcion));
                opt.value = element.descripcion + "[" + element.cveArea + "]";

                areacon.appendChild(opt);
            })
        });
    });

    fetch(urlaudiencia).then(function (result) {
        if (result.ok) {
            return result.json();
        }
    }).then(function (data) {
        //console.log(data);
        data.forEach(function (element) {
            let audiencia = document.getElementById("selectAudiencia");
            let opt = document.createElement("option");

            opt.appendChild(document.createTextNode(element.descCorta));
            opt.value = element.descCorta;// + "[" + element.idAudiencia + "]";

            audiencia.appendChild(opt);
        })
        //Atrapa errores e intenta hacer un nuevo fetch con el link sin certificado
    }).catch((error)=> {
        var urlaudiencia = "http://catalogs.repositorionacionalcti.mx/webresources/audiencia";
        fetch(urlaudiencia).then(function (result) {
            if (result.ok) {
                return result.json();
            }
        }).then(function (data) {
            //console.log(data);
            data.forEach(function (element) {
                let audiencia = document.getElementById("selectAudiencia");
                let opt = document.createElement("option");

                opt.appendChild(document.createTextNode(element.descCorta));
                opt.value = element.descCorta;// + "[" + element.idAudiencia + "]";

                audiencia.appendChild(opt);
            })
        });
    });

    fetch(urlpais).then(function (result) {
        if(result.ok){
            return result.json();
        }
    }).then(function (data) {
        data.forEach(function (element) {
            let pais = document.getElementById("selectPais");
            let opt = document.createElement("option");

            opt.appendChild(document.createTextNode(element.descPais));
            opt.value = element.descPais + "[" + element.idPais + "]";

            pais.appendChild(opt);
        })
        //Atrapa errores e intenta hacer un nuevo fetch con el link sin certificado
    }).catch((error)=> {
        var urlpais = "http://catalogs.repositorionacionalcti.mx/webresources/pais";
        fetch(urlpais).then(function (result) {
        if(result.ok){
            return result.json();
        }
        }).then(function (data) {
            data.forEach(function (element) {
                let pais = document.getElementById("selectPais");
                let opt = document.createElement("option");

                opt.appendChild(document.createTextNode(element.descPais));
                opt.value = element.descPais + "[" + element.idPais + "]";

                pais.appendChild(opt);
            })
        });
    });

    fetch(urlidioma).then(function (result) {
        if(result.ok) {
            return result.json();
        }
    }).then( function (data){
        data.forEach( function (element){
            let idioma = document.getElementById("selectIdioma");
            let opt = document.createElement("option");

            opt.appendChild(document.createTextNode(element.descCorta));
            opt.value = element.descCorta + "[" + element.idIdioma + "]";

            idioma.appendChild(opt);

        })
    }).catch((error)=>{
        var urlidioma = "http://catalogs.repositorionacionalcti.mx/webresources/idioma";
        fetch(urlidioma).then(function (result) {
            if(result.ok) {
                return result.json();
            }
        }).then( function (data){
            data.forEach( function (element){
                let idioma = document.getElementById("selectIdioma");
                let opt = document.createElement("option");

                opt.appendChild(document.createTextNode(element.descCorta));
                opt.value = element.descCorta + "[" + element.idIdioma + "]";

                idioma.appendChild(opt);

            })
        });
    });    

    fetch(urllicencia).then(function (result) {
        if(result.ok) {
            return result.json();
        }
    }).then( function (data){
        data.forEach( function (element){
            let licencia = document.getElementById("selectLicencia");
            let opt = document.createElement("option");

            opt.appendChild(document.createTextNode(element.descCorta + "("+element.clave+")"));
            opt.value = element.clave;

            licencia.appendChild(opt);

        })
    }).catch((error)=>{
        var urllicencia = "http://catalogs.repositorionacionalcti.mx/webresources/licencia";
        fetch(urllicencia).then(function (result) {
            if(result.ok) {
                return result.json();
            }
        }).then( function (data){
            data.forEach( function (element){
                let licencia = document.getElementById("selectLicencia");
                let opt = document.createElement("option");

                opt.appendChild(document.createTextNode(element.descCorta + "("+element.clave+")"));
                opt.value = element.clave;

                licencia.appendChild(opt);

            })
        });
    });    

    if ($('#tipousu').val() != "0") {
        $('#btnsRegular').hide();
        $('#btnsAdmin').show();
    } else {
        $('#btnsRegular').show();
        $('#btnsAdmin').hide();
    }

    setTimeout(function myfunction() {
        if (document.getElementById("id").value != "") {
            //Trae los registros
            modificaRegistro();
        }
    }, 100);
};

// Esto es para habilitar o deshabilitar el campo si el acceso es embargo o no
$("#selectPublicacion").change(function () {
    if ($(this).val() == "Acceso Embargado") {
        $("#dateEmbargo").removeAttr("disabled");
    } else {
        $("#dateEmbargo").attr("disabled", "disabled");
        $("#dateEmbargo").val("");
    }
});

// esto es para que no se pickeen fechas futuras
$(function(){
    var dtToday = new Date();

    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();

    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var maxDate = year + '-' + month + '-' + day;
    $('#dateEmbargo').attr('max', maxDate);
});

$(function(){
    var dtToday = new Date();

    var month = dtToday.getMonth() + 1;
    var day = dtToday.getDate();
    var year = dtToday.getFullYear();

    if(month < 10)
        month = '0' + month.toString();
    if(day < 10)
        day = '0' + day.toString();

    var maxDate = year + '-' + month + '-' + day;
    $('#datePublicacion').attr('max', maxDate);
});

// Esto es para que los input text solo acepten números
// Poner onkeypress="return isNumberKey(event)" en el input que se quiera restringir
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
};

var idAutor = 0;
var arrayAutor = [];
// Función para crear nuevos inputs en dónde puedan ser 2 o más entradas
$('#btnAutor').on('click', function() {
    if ($('#txtAutor').val() != '' && $('#txtCVU').val() != '') {
        if ($('#txtAutorhidd').val().includes($('#txtAutor').val())) {
            arrayAutor.push($('#txtAutorhidd').val() + ';' + $('#txtCVU').val());
        } else {
            arrayAutor.push($('#txtAutor').val() + ';' + $('#txtCVU').val());
        }
        
        idAutor++;

        if (idAutor == 1) {
            $('#autor').after('<div id="autor' + idAutor + '" class="row mb-3"></div>') //.....
        } else {
            $('#autor' + (idAutor - 1)).after('<div id="autor' + idAutor + '" class="row mb-3"></div>') //.....
        }
        $('#autor' + idAutor).append('<div id="divAutor' + idAutor + '" class="col-4 offset-2"></div>'); //.......
        $('#autor' + idAutor).append('<div id="divAutorCVU' + idAutor + '" class="col-4"></div>'); //.......
        $('#autor' + idAutor).append('<div id="divAut' + idAutor + '" class="col-2"></div>'); //.......

        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtAutor").val(), id: 'txtAutor'+idAutor, disabled: 'disabled'}).appendTo('#divAutor'+idAutor); //...........
        $('#txtAutor').val('');
        $('#txtAutor').focus();

        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtCVU").val(), id: 'txtCVU'+idAutor, disabled: 'disabled'}).appendTo('#divAutorCVU'+idAutor); //...........
        $('#txtCVU').val('');

        $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar icon-trash-o', value: '', onclick: '', id: 'btnAutor' + idAutor }).appendTo('#divAut' + idAutor);

        $('#autorAlert').addClass('d-none');
    } else{
        if($('#txtAutor').val() == ''){
            $('#autorAlert').removeClass('d-none');
            $('#txtAutor').focus();
        } else {
            $('#autorAlert').removeClass('d-none');
            $('#txtCVU').focus();
        }
    }
    $('#txtAutorhidd').val("");
});

$(document).on("click", '.eliminar', function() { //..........
    // Esto es para obtener solo los numeros del id
    let id = $(this).attr('id').replace(/\D/g,'');
    if (id != '') {
        if (arrayAutor.indexOf($('#txtAutor' + id).val() + ';' + $('#txtCVU' + id).val()) != -1) {
            let pos = arrayAutor.indexOf($('#txtAutor' + id).val() + ';' + $('#txtCVU' + id).val());
            arrayAutor.splice(pos, 1);
        } else {
            let pos = arrayAutor.indexOf(($('#txtAutor' + id).val() + "1")+ ';' + $('#txtCVU' + id).val());
            arrayAutor.splice(pos, 1);
        }

        $('#txtAutor'+id).remove();
        $('#txtCVU'+id).remove();
        $('#btnAutor' + id).remove();
        $('#autor' + id).hide();//...........        
    }
});

var idPalabra = 0;
var arrayPalabras = [];

$('#btnPalabras').on('click', function() {
    if(arrayPalabras.length < 5){
        if($('#txtPalabrasCve').val() != ''){
            arrayPalabras.push($('#txtPalabrasCve').val());

            idPalabra++;

            if (idPalabra == 1) {
                $('#palabras').after('<div id="palabras' + idPalabra + '" class="row mb-3"></div>') //.....
            } else {
                $('#palabras'+(idPalabra-1)).after('<div id="palabras' + idPalabra + '" class="row mb-3"></div>') //.....
            }
            $('#palabras' + idPalabra).append('<div id="divPalabra' + idPalabra + '" class="col-8 offset-2"></div>'); //.......
            $('#palabras' + idPalabra).append('<div id="divPalabr' + idPalabra + '" class="col-2"></div>'); //.......

            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtPalabrasCve").val(), id: 'txtPalabrasCve' + idPalabra, disabled: 'disabled' }).appendTo('#divPalabra'+idPalabra); //....
            $('#txtPalabrasCve').val('');
            $('#txtPalabrasCve').focus();

            $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar5 icon-trash-o', value: '', onclick: '', id: 'btnPalabras' + idPalabra }).appendTo('#divPalabr' + idPalabra);  //.......

            $('#palabrasAlert').addClass('d-none');
            $('#palabrasAlert3').addClass('d-none');
        } else {
            $('#palabrasAlert').removeClass('d-none');
            $('#txtPalabrasCve').focus();
        }
    } else {
        $('#palabrasAlert2').removeClass('d-none');
    }
});

$(document).on("click", '.eliminar5', function() { //....
    $('#palabrasAlert2').addClass('d-none');
    // Esto es para obtener solo los numeros del id
    let id = $(this).attr('id').replace(/\D/g,'');
    if (id != '') {
        let pos = arrayPalabras.indexOf($('#txtPalabrasCve'+id).val());
        arrayPalabras.splice(pos, 1);

        $('#txtPalabrasCve'+id).remove();
        $('#btnPalabras' + id).remove();
        $('#palabras' + id).hide(); //......
    }
});

var idDatos = 0;
var arrayDatos = [];

$('#btnDatos').on('click', function() {
    if ($('#txtDatos').val() != ''){
        arrayDatos.push($('#txtDatos').val());

        idDatos++;

        if (idDatos == 1) {
            $('#conjunto').after('<div id="conjunto' + idDatos + '" class="row mb-3"></div>') //.....
        } else {
            $('#conjunto' + (idDatos - 1)).after('<div id="conjunto' + idDatos + '" class="row mb-3"></div>') //.....
        }
        $('#conjunto' + idDatos).append('<div id="divDatos' + idDatos + '" class="col-8 offset-2"></div>'); //.......
        $('#conjunto' + idDatos).append('<div id="divDatosRel' + idDatos + '" class="col-2"></div>'); //.......

        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtDatos").val(), id: 'txtDatos'+idDatos, disabled: 'disabled'}).appendTo('#divDatos'+idDatos); //...........
        $('#txtDatos').val('');
        $('#txtDatos').focus();

        $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar7 icon-trash-o', value: '', onclick: '', id: 'btnDatos' + idDatos }).appendTo('#divDatosRel' + idDatos); //........

        $('#datosAlert').addClass('d-none');
    } else {
        $('#datosAlert').removeClass('d-none');
        $('#txtDatos').focus();
    }

});

$(document).on("click", '.eliminar7', function() { //.......
    // Esto es para obtener solo los numeros del id
    let id = $(this).attr('id').replace(/\D/g,'');
    if (id != '') {
        let pos = arrayDatos.indexOf($('#txtDatos'+id).val());
        arrayDatos.splice(pos, 1);

        $('#txtDatos'+id).remove();
        $('#btnDatos' + id).remove();
        $('#conjunto' + id).hide();
    }
});

var idProyecto = 0;
var arrayProyecto = [];

$('#btnProyecto').on('click', function() {
    if ($('#txtProyecto').val() != ''){
        arrayProyecto.push($('#txtProyecto').val());

        idProyecto++;

        if (idProyecto == 1) {
            $('#proyecto').after('<div id="proyecto' + idProyecto + '" class="row mb-3"></div>') //.....
        } else {
            $('#proyecto' + (idProyecto - 1)).after('<div id="proyecto' + idProyecto + '" class="row mb-3"></div>') //.....
        }
        $('#proyecto' + idProyecto).append('<div id="divProyecto' + idProyecto + '" class="col-8 offset-2"></div>'); //.......
        $('#proyecto' + idProyecto).append('<div id="divProyect' + idProyecto + '" class="col-2"></div>'); //.......

        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtProyecto").val(), id: 'txtProyecto'+idProyecto, disabled: 'disabled'}).appendTo('#divProyecto'+idProyecto);    //........
        $('#txtProyecto').val('');
        $('#txtProyecto').focus();

        $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar6 icon-trash-o', value: '', onclick: '', id: 'btnProyecto' + idProyecto }).appendTo('#divProyect' + idProyecto); //.......

        $('#proyectoAlert').addClass('d-none');
    } else {
        $('#proyectoAlert').removeClass('d-none');
        $('#txtProyecto').focus();
    }
});

$(document).on("click", '.eliminar6', function() { //..........
    // Esto es para obtener solo los numeros del id
    let id = $(this).attr('id').replace(/\D/g,'');
    if (id != '') {
        let pos = arrayProyecto.indexOf($('#txtProyecto'+id).val());
        arrayProyecto.splice(pos, 1);

        $('#txtProyecto'+id).remove();
        $('#btnProyecto' + id).remove();
        $('#proyecto'+id).hide();//..........
    }
});

var idCorreo = 0;
var arrayEmail = [];

$('#btnCorreo').on('click', function() {
    if ($('#txtEmail').val() != '' && $('#txtEmail')[0].checkValidity()) {
        arrayEmail.push($('#txtEmail').val());

        idCorreo++;

        if (idCorreo == 1) {
            $('#email').after('<div id="email' + idCorreo + '" class="row mb-3"></div>') //.....
        } else {
            $('#email' + (idCorreo - 1)).after('<div id="email' + idCorreo + '" class="row mb-3"></div>') //.....
        }
        $('#email' + idCorreo).append('<div id="divEmail' + idCorreo + '" class="col-8 offset-2"></div>'); //.......
        $('#email' + idCorreo).append('<div id="divCorreo' + idCorreo + '" class="col-2"></div>'); //.......


        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtEmail").val(), id: 'txtEmail'+idCorreo, disabled: 'disabled'}).appendTo('#divEmail'+idCorreo);  //....
        $('#txtEmail').val('');
        $('#txtEmail').focus();

        $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar2 icon-trash-o', value: '', onclick: '', id: 'btnCorreo' + idCorreo }).appendTo('#divCorreo' + idCorreo); //.....

        $('#emailAlert').addClass('d-none');
        $('#emailAlert2').addClass('d-none');
    } else {
        $('#emailAlert').removeClass('d-none');
        $('#txtEmail')[0].reportValidity()
        $('#txtEmail').focus();
    }


});

$(document).on("click", '.eliminar2', function() { //.......
    // Esto es para obtener solo los numeros del id
    let id = $(this).attr('id').replace(/\D/g,'');
    if (id != '') {
        let pos = arrayEmail.indexOf($('#txtEmail'+id).val());
        arrayEmail.splice(pos, 1);

        $('#txtEmail'+id).remove();
        $('#btnCorreo' + id).remove();
        $('#email' + id).hide(); //......
    }
});

var idAsesor = 0;
//var asesores = 0;
var arrayAsesor = [];
$('#btnAsesor').on('click', function() {
    if ($('#txtAsesor').val() != '' && $('#txtAsesorCVU').val() != '') {
        if ($('#txtAsesorhidd').val().includes($('#txtAsesor').val())) {
            arrayAsesor.push($('#txtAsesorhidd').val() + ';' + $('#txtAsesorCVU').val());
        } else {
            arrayAsesor.push($('#txtAsesor').val() + ';' + $('#txtAsesorCVU').val());
        }        

        idAsesor++;

        if (idAsesor == 1) {
            $('#asesor').after('<div id="asesor' + idAsesor + '" class="row mb-3"></div>') //.....
        } else {
            $('#asesor' + (idAsesor - 1)).after('<div id="asesor' + idAsesor + '" class="row mb-3"></div>') //.....
        }
        $('#asesor' + idAsesor).append('<div id="divAsesor' + idAsesor + '" class="col-4 offset-2"></div>'); //.......
        $('#asesor' + idAsesor).append('<div id="divAsesorCVU' + idAsesor + '" class="col-4"></div>'); //.......
        $('#asesor' + idAsesor).append('<div id="divAsesr' + idAsesor + '" class="col-2"></div>'); //.......

        //asesores++;
        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtAsesor").val(), id: 'txtAsesor'+idAsesor, disabled: 'disabled'}).appendTo('#divAsesor'+idAsesor); //............
        $('#txtAsesor').val('');
        $('#txtAsesor').focus();

        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtAsesorCVU").val(), id: 'txtAsesorCVU'+idAsesor, disabled: 'disabled'}).appendTo('#divAsesorCVU'+idAsesor); //..........
        $('#txtAsesorCVU').val('');

        $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar3 icon-trash-o', value: '', onclick: '', id: 'btnAsesor' + idAsesor }).appendTo('#divAsesr' + idAsesor); //............

        $('#asesorAlert').addClass('d-none');
    } else {
        $('#asesorAlert').removeClass('d-none');
        if($('#txtAsesor').val() == ''){
            $('#txtAsesor').focus();
        } else {
            $('#txtAsesorCVU').focus();
        }
    }
    $('#txtAsesorhidd').val("");
});

$(document).on("click", '.eliminar3', function() { //.........
    // Esto es para obtener solo los numeros del id
    let id = $(this).attr('id').replace(/\D/g,'');
    if (id != '') {
        if (arrayAsesor.indexOf($('#txtAsesor' + id).val() + ';' + $('#txtAsesorCVU' + id).val()) != -1) {
            var pos = arrayAsesor.indexOf($('#txtAsesor' + id).val() + ';' + $('#txtAsesorCVU' + id).val());
        } else {
            var pos = arrayAsesor.indexOf(($('#txtAsesor' + id).val() + "1") + ';' + $('#txtAsesorCVU' + id).val());
        }
        
        arrayAsesor.splice(pos, 1);
        //asesores--;
        $('#txtAsesor'+id).remove();
        $('#txtAsesorCVU'+id).remove();
        $('#btnAsesor' + id).remove();
        $('#asesor' + id).hide();//...........
    }
});

var idPatrocinador = 0;
var arrayPatrocinador = [];

$('#btnPatrocinador').on('click', function() {
    if($('#txtPatrocinador').val() != '' && $('#txtPatrocinadorVol').val() != ''){
        arrayPatrocinador.push($('#txtPatrocinador').val() + ';' + $('#txtPatrocinadorVol').val());

        idPatrocinador++;

        if (idPatrocinador == 1) {
            $('#patrocinador').after('<div id="patrocinador' + idPatrocinador + '" class="row mb-3"></div>') //.....
        } else {
            $('#patrocinador' + (idPatrocinador - 1)).after('<div id="patrocinador' + idPatrocinador + '" class="row mb-3"></div>') //.....
        }
        $('#patrocinador' + idPatrocinador).append('<div id="divPatrocinador' + idPatrocinador + '" class="col-4 offset-2"></div>'); //.......
        $('#patrocinador' + idPatrocinador).append('<div id="divPatrocinadorVol' + idPatrocinador + '" class="col-4"></div>'); //.......
        $('#patrocinador' + idPatrocinador).append('<div id="divPatrocinadr' + idPatrocinador + '" class="col-2"></div>'); //.......

        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtPatrocinador").val(), id: 'txtPatrocinador'+idPatrocinador, disabled: 'disabled'}).appendTo('#divPatrocinador'+idPatrocinador); //......
        $('#txtPatrocinador').val('');
        $('#txtPatrocinador').focus();

        $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtPatrocinadorVol").val(), id: 'txtPatrocinadorVol'+idPatrocinador, disabled: 'disabled'}).appendTo('#divPatrocinadorVol'+idPatrocinador); //.........
        $('#txtPatrocinadorVol').val('');

        $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar4 icon-trash-o', value: '', onclick: '', id: 'btnPatrocinador' + idPatrocinador }).appendTo('#divPatrocinadr' + idPatrocinador); //........

        $('#patrocinadorAlert').addClass('d-none');
    } else {
        $('#patrocinadorAlert').removeClass('d-none');
        if ($('#txtPatrocinador').val() == ''){
            $('#txtPatrocinador').focus();
        } else {
            $('#txtPatrocinadorVol').focus();
        }
    }
});

$(document).on("click", '.eliminar4', function() { //......
    // Esto es para obtener solo los numeros del id
    let id = $(this).attr('id').replace(/\D/g,'');
    if (id != '') {
        let pos = arrayPatrocinador.indexOf($('#txtPatrocinador'+id).val() + ';' + $('#txtPatrocinadorVol'+id).val());
        arrayPatrocinador.splice(pos, 1);

        $('#txtPatrocinador'+id).remove();
        $('#txtPatrocinadorVol'+id).remove();
        $('#btnPatrocinador' + id).remove();
        $('#patrocinador' + id).hide(); //..........
    }
});