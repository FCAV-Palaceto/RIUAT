<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" codefile="Revisar.aspx.cs" inherits="Revisar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/jquery-ui.min.css" rel="stylesheet" />
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
        .ui-autocomplete-loading {
            background: white url("img/ui-anim_basic_16x16.gif") no-repeat right center;
        }

        [data-toggle="collapse"] .fa:before {
            content: "\f055";
        }
        /* Este servía para el primer ícono si comienza colapsado, cambia a este ícono al expandirse*/
        [aria-expanded="true"] .fa:before {
            content: "\f056";
        }

        [data-toggle="collapse"].collapsed .fa:before {
            content: "\f055";
        }
    </style>
    <script src="js/jquery-ui.min.js"></script>
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
        <h1 class="mb-3">Detalle del env&iacute;o</h1>
        <div class="row mb-3">
            <div class="col-auto btn-group" style="height:38px !important;" role="group">
                <a href="Tareas.aspx" class="btn btn-light border col" type="button"><i class="icon-undo2"></i> Regresar</a>
            </div>
            <div id="btnsEditar" class="col text-right">
                <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#modalconsulta"><i class="icon-search mr-2"></i>Buscar autor</button>
                <button type="button" class="btn btn-primary" id="btnAlta"><i class="icon-person_add mr-2"></i>Dar de alta autor</button>
                <button type="button" class="btn btn-info" id="btnEditar"><i class="icon-edit mr-2"></i>Modificar</button>
            </div>
        </div>

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

        <div class="row mb-3" id="btnRegresar">
            <div class="col-auto">
                <div class="btn-group" role="group">
                    <a href="Tareas.aspx" class="btn btn-light border col" type="button"><i class="icon-undo2"></i> Regresar</a>
                </div>
            </div>
            <div class="col-auto" id="btnCancelar">
                <div class="btn-group" role="group">
                    <button class="btn btn-danger col" type="button" data-toggle="modal" data-target="#modalCancelar"><i class="icon-cancel"></i> Cancelar</button>
                </div>
            </div>
        </div>

        <div class="container mt-5" id="botones">
            <div class="row border rounded align-items-center shadow-sm mb-3">
                <div class="col-lg-2 col-5 py-2">
                    <button class="btn btn-success border-success w-100" type="button" data-toggle="modal" data-target="#modalAceptar">Aprobar</button>
                </div>
                <div class="col">
                    <div>Si ha revisado el producto acad&eacute;mico y desea aceptarlo para continuar con la siguiente fase <%--puede incluirse en la colecci&oacute;n--%>, seleccione "Aprobar".</div>
                </div>
            </div>
            <div class="row border rounded align-items-center shadow-sm mb-3">
                <div class="col-lg-2 col-5">
                    <button class="btn btn-danger w-100 border-danger" type="button" data-toggle="modal" data-target="#modalMensaje">Rechazar</button>
                </div>
                <div class="col">
                    <div>Si ha revisado el producto acad&eacute;mico y requiere dar retroalimentación a la persona que ha hecho el envío <%--<strong>no</strong> puede introducirse en la colecci&oacute;n--%>, seleccione "Rechazar". <%--Se le pedir&aacute; que escriba un mensaje indicando las razones por las que el producto acad&eacute;mico se ha rechazado, y si la persona que ha hecho el env&iacute;o debe modificar algo o volverlo a cargar.--%></div>
                </div>
            </div>
            <div class="row border rounded align-items-center shadow-sm mb-3">
                <div class="col-lg-2 col-5 py-2">
                    <button class="btn btn-secondary w-100 border" type="button" onclick="RealizarTarea();">Hacer m&aacute;s tarde</button>
                </div>
                <div class="col">
                    <div>Si desea posponer esta revisión<%--dejar esta tarea--%> por ahora y volver a "Mis Tareas", utilice esta opci&oacute;n.</div>
                </div>
            </div>
            <div id="divBtnDevolver" class="row border rounded align-items-center shadow-sm mb-3">
                <div class="col-lg-2 col-5 py-2">
                    <button class="btn btn-secondary w-100 border" type="button" onclick="devolver();">Devolver tarea</button>
                </div>
                <div class="col">
                    <div>Para devolver la tarea a la lista de tareas y que sea otra persona quien la haga, use esta opción.</div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalMensaje" tabindex="-1" role="dialog" aria-labelledby="modalMensajeLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalMensajeLabel">Comentarios</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="message-text" class="col-form-label">Mensaje:</label>
                        <textarea class="form-control" id="message-text" rows="10"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="rechazar()">Enviar mensaje</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalAceptar" tabindex="-1" role="dialog" aria-labelledby="modalAceptarLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAceptarLabel">Comentarios</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="message-text" class="col-form-label">Mensaje:</label>
                        <textarea class="form-control" id="message-text2" rows="10"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" onclick="aceptar()">Enviar mensaje</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalCancelar" tabindex="-1" role="dialog" aria-labelledby="modalCancelarLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalCancelarLabel">Cancelar producto</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <p>¿Desea cancelar el estado del producto?</p>
                        <p>Al hacer esto el producto pasará al estado de Primera revisión y podrá volver a Rechazarlo para agregar más comentarios o Aprobarlo y posteriormente publicarlo nuevamente.</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-danger" onclick="cancelar()">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade ui-front" id="modalconsulta" tabindex="-1" role="dialog" aria-labelledby="ModalLabelConsulta" aria-hidden="true">
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="ModalLabelConsulta">Consultar autores</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
		    <div class="col-12">
                    <div class="row">
                        <div class="col-12 mb-3">
                            <span class="" type="button" data-toggle="collapse" data-target="#collapseAutores" aria-expanded="true" aria-controls="collapseExample"><b>Autor(es) en este env&iacute;o<i class="fa align-middle ml-2"></i></b></span>
                            <div class="collapse show" id="collapseAutores">
                                <div class="card card-body">
                                    <div id="autores"></div>
                                </div>
                            </div>
                        </div>
                        <div id="divAsesores" class="col-12 mb-3">
                            <span class="" type="button" data-toggle="collapse" data-target="#collapseAsesores" aria-expanded="true" aria-controls="collapseExample"><b>Asesor(es) en este env&iacute;o<i class="fa align-middle ml-2"></i></b></span>
                            <div class="collapse show" id="collapseAsesores">
                                <div class="card card-body">
                                    <div id="asesores"></div>
                                </div>
                            </div>
                        </div>
                        <div id="" class="col-6">
                            <input id="" type="text" class="form-control inputs" hidden="hidden" />
                            <label for="txtAutor">Nombre:</label>
                            <input id="txtAutor" type="text" class="form-control inputs" placeholder="Ejemplo: José Cantú García" />
                        </div>
                        <div id="" class="col-6">
                            <label for="txtAutor">Identificador:</label>
                            <input id="txtCVU" type="text" class="form-control inputs" placeholder="CVU, ORCID o CURP" />
                        </div>
                    </div>
                <p class="mt-5 text-muted">En esta sección se puede consultar los autores que se incluyeron en el envío; y verificar si están dados de alta en el catálogo del conacyt al buscarlos mediante su nombre o identificador y si aparecen en la lista desplegable es que están validados.</p>
                </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Salir</button>
          </div>
        </div>
      </div>
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="Scripts2" runat="Server">
    <script>
        window.onload = function () {
            $.ajax({
                type: 'POST',
                url: 'Revisar.aspx/Tabla',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#tabproductos").html(tabla.d); //nombre del id del div de la tabla                    
                    var estadoprod = $('#estadoprod').val();
                    console.log(estadoprod);
                    if (estadoprod == "2" || estadoprod == "3" || estadoprod == "4") {
                        $("#botones").hide();
                        $("#btnsEditar").hide();
                        if ($('#txtTipo').val() != "2" || estadoprod == "4") {
                            $("#btnCancelar").hide();
                        }                        
                    } else {
                        $("#btnRegresar").hide();
                        if ($('#asignado').val() == "") {
                            $("#divBtnDevolver").hide();
                        }
                    }
                }
            });

            $.get('Handler_vista.ashx', function (data) {
                $('#handler').html(data);
            });
        }

        function cancelar() {
            $.ajax({
                type: 'POST',
                url: 'Revisar.aspx/Cancela',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (data) {
                    var JsonD = $.parseJSON(data.d);
                    if (JsonD.success == 1) {
                        window.location.href = "Tareas.aspx";
                    } else {
                        alert("Ocurrió un error");
                    }
                }
            });
        };

        function aceptar() {
            //var estado=0;
            var coments = $('#message-text2').val();
            coments = coments.replaceAll("\'", "\\'");
            $.ajax({
                type: 'POST',
                url: 'Revisar.aspx/RevisaProducto',
                data: "{'comentarios':'" + coments + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (cadena) {
                    var JsonD = $.parseJSON(cadena.d);
                    if (JsonD.success == 1 || JsonD.success == 2) {
                        //alert("Producto enviado correctamente");
                        //correo(estado);
                        window.location.href = "Tareas.aspx";
                    } else {
                        alert("Ocurrió un error");
                    }
                }
            });
        };

        function rechazar() {
            //var estado=1;
            var coments = $('#message-text').val();
            coments = coments.replaceAll("\'", "\\'");
            $.ajax({
                type: 'POST',
                url: 'Revisar.aspx/EnviaComentarios',
                data: "{'comentarios':'" + coments + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (exitoso) {
                    var JsonD = $.parseJSON(exitoso.d);
                    if (JsonD.success == 1) {
                        alert("Comentarios enviados correctamente");
                        window.location.href = "Tareas.aspx";
                    } else {
                        alert("Comentarios enviados correctamente");
                        //correo();
                        window.location.href = "Tareas.aspx";
                    }
                }
            });
        };

        function correo() {
            var Correo=$("#txtCorreo").val();
            var Titulo=$("#titulo").text();
            $.ajax({
                type: 'POST',
                url: 'Revisar.aspx/EnviarCorreo',
                data: "{'titulo':'" + Titulo +"', 'correo':'"+ Correo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function () {
                    console.log("Correo Enviado");
                }
            });
        };

        // limpia inputs al cerrar el modal
        $('#modalconsulta').on('hidden.bs.modal', function () {
            $('#txtCVU').val("");
            $('#txtAutor').val("");
        });

        // Trae info al modal
        $('#modalconsulta').on('show.bs.modal', function (event) {
            var autores = $('#idautor').html();
            $('#autores').html(autores);

            var asesores = $('#idasesor').html();
            if (asesores !== undefined){
                $('#divAsesores').show();
                $('#asesores').html(asesores);
            } else {
                $('#divAsesores').hide();
            }

            // Iniciar el tooltip
            $('[data-toggle="tooltip"]').tooltip();
        });

        function devolver() {
            var opc = 2;
            var idprod = $('#idprod').val();

            $.ajax({
                type: 'POST',
                url: 'Tareas.aspx/EnviaId',
                data: "{'id':'" + idprod + "', 'opcion':'"+ opc + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (exitoso) {
                    var JsonD = $.parseJSON(exitoso.d);
                    if (JsonD.success == 2) {
                        window.location.href = "Tareas.aspx";
                    } else {
                        // No debería entrar aquí
                        alert("Ocurrio un error, vuelva a intentarlo más tarde");
                    }

                }
            });
        };

        function RealizarTarea() {
            $.ajax({
                type: 'POST',
                url: 'Revisar.aspx/RealizarTarea',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        window.location.href = 'Tareas.aspx';
                    }
                }
            });
        }
    </script>
    <script src="js/revisar.js"></script>
    <script src="js/acciones.js"></script>
    <script src="js/buscaautor.js"></script>
</asp:content>

