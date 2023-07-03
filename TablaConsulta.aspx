<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TablaConsulta.aspx.cs" Inherits="TablaConsulta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <!--ESTE ES EL PRINCIPAL CSS del plugin-->
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
    <!--Iconos de fontawesome (Se usan en este caso)-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" crossorigin="anonymous" />
    <!--Tema utilizado-->
    <link href="themes/explorer-fa5/theme.css" media="all" rel="stylesheet" type="text/css" />
    <!--jQuery (está en la master)-->
    <%-- <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script> --%>
    <!--Estos son para conversión de archivos-->
    <script src="js/plugins/buffer.min.js" type="text/javascript"></script>
    <script src="js/plugins/filetype.min.js" type="text/javascript"></script>
    <!--ESTOS SON OPCIONALES, AÑADEN EXTRAS DE ORIENTACIÓN (Deben cargarse antes del fileinput.js-->
    <script src="js/plugins/piexif.js" type="text/javascript"></script>
    <script src="js/plugins/sortable.js" type="text/javascript"></script>    
    <style>
        /* Para que si se introduce una palabra muuuuuuuuy larga se rompa y no haga overflow
           ********* PUEDE NO FUNCIONAR EN NAVEGADORES MUUUY VIEJOS  ********** */
        table tr td:nth-child(2) {
            word-break: break-word;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <!--Para hacer zoom y previsualizar en un modal-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <!--JS PRINCIPAL DEL PLUGIN-->
    <script src="js/fileinput.js" type="text/javascript"></script>
    <!--ESTE ES PARA LENGUAJE A ESPAÑOL-->
    <script src="js/locales/es.js" type="text/javascript"></script>
    <!--Para usar el tema de fontawesome5-->
    <script src="themes/fa5/theme.js" type="text/javascript"></script>
    <script src="themes/explorer-fa5/theme.js" type="text/javascript"></script>

    <div class="container">
        <h1 class="mb-3">Detalle del env&iacute;o</h1>
        <div class="row mb-3">
            <div class="col-12">
                <div class="btn-group" role="group">
                    <a href="Inicio.aspx" class="btn btn-light border col" type="button"><i class="icon-undo2"></i> Regresar</a>
                </div>
            </div>
        </div>
        <%--<p>Detalle del env&iacute;o.</p>--%>
        <%-- A PARTIR DE AQUÍ EMPIEZA EL FORMULARIO --%>
        <div id="tabproductos"></div>
        <div id="handler"></div>
        <div class="form-group" id="fileInput">
            <div class="file-loading" >
                <input id="file-5" type="file" data-preview-file-type="any"/>
            </div>
        </div>
        <script>
            $('#file-5').fileinput({
                theme: 'fa5',
                language: 'es',
                showClose: false,
                showBrowse: false,
                showCaption: false,
                dropZoneTitle: 'No hay archivos disponibles',
                //deleteUrl: "/site/file-delete",
                maxFileSize: 15360,
                maxFileCount: 5,
                overwriteInitial: false,
                initialPreviewAsData: true //...               
                //allowedFileExtensions: ['jpg', 'png', 'gif', 'pdf']
            });
        </script>
        <div class="row mb-3">
            <div class="col-12">
                <div class="btn-group" role="group">
                    <a href="Inicio.aspx" class="btn btn-light border col" type="button"><i class="icon-undo2"></i> Regresar</a>
                </div>
            </div>
        </div>        
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts2" Runat="Server">
    <script>
        window.onload = function () {
            $.ajax({
                type: 'POST',
                url: 'TablaConsulta.aspx/TablaProducto',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#tabproductos").html(tabla.d); //nombre del id del div de la tabla

                }
            });
            
            $.get('Handler_vista.ashx', function(data) {
                $('#handler').html(data);
            });
        }
    </script>
</asp:Content>

