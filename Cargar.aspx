<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" codefile="Cargar.aspx.cs" inherits="Cargar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    <script>

    </script>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
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
            <div id="handler"></div>
            <h1 class="mb-3">Formulario de Captura</h1>
            <p>Por favor, cargar los archivos del producto.</p>
            <%-- A PARTIR DE AQUÍ EMPIEZA EL FORMULARIO --%>
            <div class="form-group" id="fileInput">
                <div class="file-loading" >
                    <input id="file-5" type="file" multiple data-preview-file-type="any"/>
                </div>
            </div>
            <script>
                $(document).ready(function() {
                    $.get('Handler2.ashx', function(data) {
                        $('#handler').html(data);
                    });

                    // Se inicializa el plugin
                    $('#file-5').fileinput({
                        theme: 'fa5',
                        language: 'es',
                        uploadUrl: 'Handler.ashx',
                        //deleteUrl: "/site/file-delete",
                        maxFileSize: 15360,
                        maxFileCount: 5,
                        overwriteInitial: false,                        
                        initialPreviewAsData: true, //...
                        browseOnZoneClick: true,
                        allowedFileExtensions: ['pdf']
                    });
                });
            </script>
            <div id="formulario">
                <div class="row mb-3 mt-5">
                    <div class="col-12">
                        <div class="btn-group float-right" role="group">
                            <button class="btn btn-light border col" type="button" onclick="window.history.back()">Anterior</button>
                            <button class="btn btn-light border text-nowrap col" type="button" onclick="" data-toggle="modal" data-target="#exampleModal">Guardar</button>
                            <button id="btnSigLic" class="btn btn-primary col" type="button">Siguiente</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Cancelar o Guardar el Env&iacute;o</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ¿Desea guardar el env&iacute;o para seguir trabajando en el m&aacute;s tarde?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Continuar con el env&iacute;o</button>
                    <button type="button" class="btn btn-danger" data-toggle="modal" data-dismiss="modal" data-target="#exampleModalToggle2">Descartar el env&iacute;o</button>                    
                    <button type="button" class="btn btn-primary" onclick="guardaArchivo()">Guardar para despu&eacute;s</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="exampleModalToggle2" aria-hidden="true" role="dialog" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalToggleLabel2">Eliminar env&iacute;o</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ¿Desea descartar este env&iacute;o?
                </div>
                <div class="modal-footer">
                    <button class="btn btn-danger" type="button" onclick="DelProductoOTG(<%=idProducto %>);" id="eliminaProducto">Eliminar</button>
                    <button class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="Scripts2" runat="Server">
    <script src="js/acciones.js"></script>    
</asp:content>
