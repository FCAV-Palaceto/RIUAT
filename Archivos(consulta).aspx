<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Archivos.aspx.cs" Inherits="Archivos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>

<script>
    function modalAddDocs(periodo, matricula, idinforme) {
        // Se muestra el modal para la carga de archivos y se oculta el boton que genera el trigger
        $('#btnAddDocs').hide();
        var strCategoriaArch = "Informes"; //Indica la categoria al que pertenece el archivo  
        var periodo = periodo;
        var matricula = matricula;
        var idinforme = idinforme;
        var filesName = "";
        //Se crea el modal

        $('.container').prepend("<div class=\"modal fade\" id=\"modalinformes\" role=\"dialog\">" +
          "<div class=\"modal-dialog modal-lg\"><div class=\"modal-content\"><div class=\"modal-header\">" +
          "<h4>Subir Informe</h4><button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button></div>" +
          "<div class=\"modal-body\"><div class=\"col-md-12\"><div class=\"card card-primary card-outline card-outline-tabs\"><div class=\"card-header p-0 border-bottom-0\">" +
          "<ul class=\"nav nav-tabs\" id=\"custom-tabs-four-tab\" role=\"tablist\"><li class=\"nav-item\">" +
          "<a class=\"nav-link active\" id=\"custom-tabs-four-home-tab\" data-toggle=\"pill\" href=\"#custom-tabs-four-home\" role=\"tab\" aria-controls=\"custom-tabs-four-home\" aria-selected=\"true\">Subir informe</a>" +
          "</li><li class=\"nav-item\"><a class=\"nav-link\" id=\"custom-tabs-four-profile-tab\" data-toggle=\"pill\" href=\"#custom-tabs-four-profile\" role=\"tab\" aria-controls=\"custom-tabs-four-profile\" aria-selected=\"false\">Informe guardado</a>" +
          "</li></ul></div><div class=\"card-body\"><div class=\"tab-content\" id=\"custom-tabs-four-tabContent\"><div class=\"tab-pane fade show active\" id=\"custom-tabs-four-home\" role=\"tabpanel\" aria-labelledby=\"custom-tabs-four-home-tab\">" +
          "Seleccione el informe que necesita subir.<br/>El formato valido para cargar el informe es en pdf.<br/><br/>El tamaño maximo soportado es de 10MB.<br/><br/><button type=\"button\" id=\"getFiles\" class=\"btn btn-primary\"><span class=\"fas fa-cloud-upload-alt\"></span> Agregar informe</button>" +
          "<button type=\"button\" id=\"btnCargar\" class=\"btn btn-success2\" style=\"margin-left:10px;\"><span class=\"far fa-save\"></span> Guardar informe</button><div id=\"selArchivos\"></div></div>" +
          "<div class=\"tab-pane fade\" id=\"custom-tabs-four-profile\" role=\"tabpanel\" aria-labelledby=\"custom-tabs-four-profile-tab\"><div id=\"cDocumentos\"></div></div></div></div></div></div><div class=\"modal-footer mt-2\"><button type=\"button\" class=\"btn btn-secondary\" data-dismiss=\"modal\">Cancelar</button></div></div></div></div></div>");
        MuestraArchivos(strCategoriaArch, periodo, matricula, idinforme); // funcion que renderiza los archivos disponibles   
        GuardaArchivos(strCategoriaArch, periodo, matricula, idinforme); // Se invoca la función que hace el proceso de guardado de los archivos seleccionados
    }

    function GuardaArchivos(cat, periodo, matricula, idinforme) {
        //Inicia carga de archivos
        var contadorUpFile = 0;
        var cargaArchivos = $('#selArchivos').fineUploader({
            request: {
                endpoint: '../Funciones/CargaArchivos.ashx',
                params: {
                    categoria: cat,
                    per: periodo,
                    mat: matricula,
                    id: idinforme

                }
            },
            button: $('#getFiles'),
            validation: { //filtros
                //acceptFiles: ['application/pdf', 'application/doc', 'application/vnd.ms-excel', 'text/plain', 'application/vnd.ms-powerpoint', 'video/x-flv'], // MIME types
                //allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt', 'text', 'pot', 'potx', 'pps', 'ppt', 'pptx', 'flv'],
                //acceptFiles: ['application/pdf'], // MIME types
                allowedExtensions: ['pdf'],
                sizeLimit: 12428800, // 10MB
                stopOnFirstInvalidFile: false
            },
            template: '<div class="qq-uploader">' +
                     '<pre class="qq-upload-drop-area well well-sm"><span>Arrastre sus archivos a esta zona</span></pre>' +
                     '<span class="qq-drop-processing"><span>Cargando...</span><span class="qq-drop-processing-spinner"></span></span>' +
                     '<ul class="qq-upload-list" style="margin-top: 10px;"></ul>' +
                   '</div>',
            autoUpload: false,
            text: {
                cancelButton: 'Cancelar',
                failUpload: 'Error, limite maximo 10MB'
            }
        }).on('submit', function () {
            contadorUpFile++; //Se incrementa la cantidad de archivos
        }).on('cancel', function () {
            contadorUpFile--;//Se decrementa la cantidad de archivos
        }).on('complete', function () {
            contadorUpFile--;

            MuestraArchivos(cat, periodo, matricula, idinforme);
        });
        //Carga de archivos
        $('#btnCargar').click(function () {
            //Se hace el llamado a la funcion de carga de archivos
            cargaArchivos.fineUploader('uploadStoredFiles');
        });
    }

    function MuestraArchivos(cat, periodo, matricula, idinforme) {
        $.ajax({
            url: '../Funciones/GetFilesByCat.ashx',
            data: { 'categoria': cat, 'per': periodo, 'mat': matricula, 'id': idinforme },
            error: function (jqXHR, textStatus, jqThrown) {
                $.bootstrapGrowl("Ocurrio un error", {
                    type: 'danger',
                    offset: { from: 'top', amount: 300 },
                    align: 'center',
                    width: 250,
                    allow_dismiss: true
                });
            },
            success: function (data, textStatus, jqXHR) {
                $('#cDocumentos').html(data);
                setTimeout(function myfunction() {
                    //tablaEstilos();
                }, 100);
            }
        });
    }

    function deletefile(ruta, cat, per, mat, id) {
        $("#modal-eliminar").modal('show');
        $(".DelThis").attr("onclick", "return EliminarArchivo('" + ruta + "','" + cat + "','" + per + "','" + mat + "','" + id + "');");
        $("#pThisModal").text("¿Está seguro de eliminar el informe?");
    }

    function EliminarArchivo(ruta, cat, per, mat, id) {
        $("#modal-eliminar").modal('hide');
        $(".DelThis").attr("onclick", "");
        $("#pThisModal").text("");
        var rutaHandler = "../Funciones/DeleteFile.ashx";
        $.ajax({
            url: rutaHandler,
            data: { 'rutaArc': ruta },
            error: function (request, status, error) {
                $.bootstrapGrowl("Error al eliminar el informe", {
                    type: 'danger',
                    offset: { from: 'top', amount: 300 },
                    align: 'center',
                    width: 250,
                    allow_dismiss: true
                });
                return;
            },
            success: function (data, textStatus, jqXHR) {
                $.bootstrapGrowl("El informe se elimino correctamente", {
                    type: 'success',
                    offset: { from: 'top', amount: 300 },
                    align: 'center',
                    width: 250,
                    allow_dismiss: true
                });
                MuestraArchivos(cat, per, mat, id);
            }
        });
    }
</script>
