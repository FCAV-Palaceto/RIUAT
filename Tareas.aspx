<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Tareas.aspx.cs" Inherits="Tareas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%-- DataTables --%>
    <link href="DataTables-1.12.1/datatables.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.0/css/bootstrap4-toggle.min.css" rel="stylesheet"/>
    <link href="css/Toggle.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.0/js/bootstrap4-toggle.min.js"></script>
    <style>
        table tr td:nth-child(2) {
            word-break: break-word;
        }
    </style>

    <link href="css/PNotifyBrightTheme.css" rel="stylesheet" />

    <script src="js/PNotify/PNotify.js"></script>    
    <script src="js/PNotify/PNotifyMobile.js"></script>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-12">
                <div id="espacio" class="mb-5">
                    <input id="tipousuario" type="text" value="<%=tipoUsu %>" hidden="hidden"/>
                    <h3>Mis <strong>Tareas: </strong><%=nombreUsu %></h3>
                </div>
                <%--<div id="btnExportar" class="row my-3">
                    <div class="col px-4">
                        <button class="btn btn-success float-right" type="button" onclick="window.location.href='Exportar.aspx'"><b><i class="icon-file-excel-o mr-2"></i>Exportar metadatos</b></button>
                    </div>
                </div>--%>
                <div class="row">
                    <div class="col-md-12 px-4 table-responsive">
                        <div id="tabproductos"></div>
                    </div>
                </div>
                <div class="row mt-4 card mx-2">
                    <h5 class="card-header">Detalles:</h5>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-auto"><i class="icon-check text-success"></i>&nbsp; Producto aprobado</div>
                            <div class="col-auto"><i class="icon-times text-danger"></i>&nbsp; Producto rechazado</div>
                        </div>                                               
                    </div>                    
                </div>
                <div class="mx-4" id="leyendas">
                    <hr> 
                    <div class="row border rounded align-items-center shadow-sm mb-3">
                        <div class="col-lg-2 col-5 py-2">
                            <button class="btn btn-success w-100" type="button">Tomar tarea</button>
                        </div>
                        <div class="col">
                            <div>Seleccione "Tomar tarea" para revisar un producto.</div>
                        </div>
                    </div>
                    <div class="row border rounded align-items-center shadow-sm mb-3">
                        <div class="col-lg-2 col-5 py-2">
                            <button class="btn btn-info w-100" type="button">Tarea asignada</button>
                        </div>
                        <div class="col">
                            <div>Seleccione "Tarea asignada" para realizar una tarea asignada.</div>
                        </div>
                    </div>
                    <div class="row border rounded align-items-center shadow-sm mb-3">
                        <div class="col-lg-2 col-5 py-2">
                            <button class="btn btn-warning w-100" type="button">Realizar tarea</button>
                        </div>
                        <div class="col">
                            <div>Seleccione "Realizar tarea" para continuar con la revisión de un producto pospuesto.</div>
                        </div>
                    </div>
                    <div class="row border rounded align-items-center shadow-sm mb-3">
                        <div class="col-lg-2 col-5 py-2">
                            <button class="btn btn-primary w-100 text-white" type="button">Ver envío</button>
                        </div>
                        <div class="col">
                            <div>Seleccione "Ver envío" para visualizar los datos de un envío.</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal ver comentarios -->
    <div class="modal fade" id="modalComentarios" tabindex="-1" role="dialog" aria-labelledby="modalComentariosLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalComentariosLabel">Comentarios</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label for="message-text" class="col-form-label">Mensaje:</label>
                    <textarea class="form-control" id="message-text" rows="10" readonly="readonly"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal ver/Editar comentarios -->
    <div class="modal fade" id="modaleditComentarios" tabindex="-1" role="dialog" aria-labelledby="modaleditComentariosLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modaleditComentariosLabel">Comentarios</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <label for="message-text" class="col-form-label">Mensaje:</label>
                    <input type="text" id="idcoments" hidden="hidden"/>
                    <textarea class="form-control" id="message-text2" rows="10" readonly="readonly"></textarea>
                    <textarea class="form-control" id="message-text-original" rows="10" readonly="readonly" hidden="hidden"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnCierra">Cerrar</button>
                    <button type="button" class="btn btn-primary text-white" id="btnEditarMensaje">Editar</button>
                    <button type="button" class="btn btn-secondary d-none" id="btnCancelar">Cancelar</button>
                    <button type="button" class="btn btn-primary text-white d-none" id="btnGuardarMensaje">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal rechazar --%>
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
                        <textarea class="form-control" id="comentarios" rows="10"></textarea>
                        <input type="text" id="hidInput" hidden="hidden" value="" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary text-white" onclick="rechazar()">Enviar mensaje</button>
                </div>
            </div>
        </div>
    </div>   

    <%-- Modal publicar --%>
    <div class="modal fade" id="modalPublica" tabindex="-1" role="dialog" aria-labelledby="modalPublicaLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalPublicaLabel">Fecha de publicación</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="fechaPublica" class="col-form-label">Ingrese la fecha en que se llevó a cabo la importación del producto en Dspace:</label>                                                
                        <input class="form-control inputs" id="fechaPublica" type="date" required="required" />                       
                        <%--<input type="text" id="hidInput" hidden="hidden" value="" />--%>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary text-white publicar">Publicar</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts2" runat="Server">
    <%-- DataTables --%>
    <script src="DataTables-1.12.1/datatables.min.js"></script>

    <script>
        /* Forzar reload de la página si se accedió con el botón de back, supuestamente está en desuso, pero funciona (?)
        Lo usé aquí porque si tomas una tarea y das back no se actualiza que ya está tomada.... */
        window.addEventListener( "pageshow", function ( event ) {
        var historyTraversal = event.persisted || ( typeof window.performance != "undefined" && window.performance.navigation.type === 2 );
        if ( historyTraversal ) {
            // Handle page restore.
            //alert('refresh');
            window.location.reload();
        }
        });
        /*  */

        window.onload = function () {
            $(function () {
                var dtToday = new Date();

                var month = dtToday.getMonth() + 1;
                var day = dtToday.getDate();
                var year = dtToday.getFullYear();

                if (month < 10)
                    month = '0' + month.toString();
                if (day < 10)
                    day = '0' + day.toString();

                var maxDate = year + '-' + month + '-' + day;
                $('#fechaPublica').attr('max', maxDate);
            });

            TablaProductos();
            if($('#tipousuario').val() != "1"){
                $('#leyendas').hide();
                //$('#espacio').addClass("mb-5");
            }
        };

        function TablaProductos() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'Tareas.aspx/SelTareas',
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

        function estiloDataTable(page, leng) {
            //Para saber qué tabla se creó
            if ($('#tabla').length > 0) {
                $('#tabla').DataTable({
                    "lengthMenu": [5, 10, 25, 50, 75, 100],
                    "pageLength": leng,
                    pagingType: 'numbers',
                    "order": [[5, 'asc'], [2, 'desc'], [1, 'asc']],
                    //stateSave: true,
                    //responsive: true,
                    //scrollY:        200,
                    //deferRender:    true,
                    //scroller:       true,
                    //"initComplete": function (oSettings) {
                    //    var oTable = this;
                    //    var totalRows = oTable.fnGetData().length; //con esta chulada se pone la página en que se quedo ;)
                    //    oTable.fnPageChange(page);
                    //},
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
                    }
                });
            } else {
                $('#tabla1').DataTable({ 
                    "scrollX": true,                    
                    "lengthMenu": [5, 10, 25, 50, 75, 100],
                    "pageLength": leng,
                    pagingType: 'numbers',
                    "order": [[9, 'asc'], [7, 'asc'], [1, 'asc']],
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
                    }
                });
            }
        }

        function tomaTarea(id) {
            var opcion = 1;
            $.ajax({
                type: 'POST',
                url: 'Tareas.aspx/EnviaId',
                data: "{'id':'" + id + "', 'opcion':'"+ opcion + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (exitoso) {
                    var JsonD = $.parseJSON(exitoso.d);
                    if (JsonD.success == 1) {
                        window.location.href = "Revisar.aspx";
                    } else {
                        // No debería entrar aquí
                        alert("Ocurrio un error, vuelva a intentarlo más tarde");
                    }

                }
            });
        };

        function realizaTarea(id) {
            var idProducto = id;

            //var Correo = correo;
            $.ajax({
                type: 'POST',
                url: 'Tareas.aspx/RealizaId',
                data: "{'id':'" + idProducto + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (exitoso) {
                    window.location.href = "Revisar.aspx";

                }
            });
        };

        // Trae la data al modal
        $('#modalComentarios').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget) // Button that triggered the modal
            var recipient = button.data('whatever').toString();//.split('||').join('\n\n'); // Extract info from data-* attributes
            recipient = recipient.replaceAll("``", "").replaceAll("||", "=============================================");
            // recipient = recipient.split('~~').join('\n');
            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            var modal = $(this)
            modal.find('.modal-body textarea').val(recipient)
        });

        $('#modaleditComentarios').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var recipient = button.data('whatever').toString();
            recipient = recipient.replaceAll("``", "").replaceAll("||", "=============================================");
            var id = button.data('id').toString();            
            var modal = $(this)
            modal.find('.modal-body textarea').val(recipient)
            modal.find('.modal-body input').val(id);
        });

        // Esto era para rechazar o aceptar directamente en la página de tareas
        //function aceptar(id) {
        //    var idProd = id;
        //    $.ajax({
        //        type: 'POST',
        //        url: 'Tareas.aspx/AceptaProducto',
        //        data: "{'id':'" + idProd + "'}",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        error: function (jqXHR, textStatus, errorThrown) {
        //            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        //        },
        //        success: function (cadena) {
        //            var JsonD = $.parseJSON(cadena.d);
        //            if (JsonD.success == 1) {
        //                //alert("Producto enviado correctamente");
        //                TablaProductos();
        //            } else {
        //                alert("Ocurrió un error");
        //            }
        //        }
        //    });
        //};

        //$('#modalMensaje').on('show.bs.modal', function (event) {
        //    var button = $(event.relatedTarget) // Button that triggered the modal
        //    var recipient = button.data('whatever') // Extract info from data-* attributes
        //    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        //    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        //    var modal = $(this)
        //    modal.find('#hidInput').val(recipient)
        //});

        //function rechazar() {
        //    var idProd = $('#hidInput').val();
        //    var coments = $('#comentarios').val();
        //    $.ajax({
        //        type: 'POST',
        //        url: 'Tareas.aspx/RechazaProducto',
        //        data: "{'comentarios':'" + coments + "', 'id':'" + idProd + "'}",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        error: function (jqXHR, textStatus, errorThrown) {
        //            console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
        //        },
        //        success: function (exitoso) {
        //            var JsonD = $.parseJSON(exitoso.d);
        //            if (JsonD.success == 1) {
        //                alert("Comentarios enviados correctamente");
        //                $('#modalMensaje').modal('hide')
        //                TablaProductos();
        //            } else {
        //                alert("Ocurrió un error");
        //            }
        //        }
        //    });
        //};
        function modalfecha(id, estado, correo, titulo) {
            $('#modalPublica').modal('toggle');
            $(".publicar").attr("onclick", "onoff(" + id + "," + estado + ",'" + correo + "','" + titulo + "');");
            // Para que se cancele el check si se cierra / cancela la publicación del producto 
            $('#modalPublica').on('hidden.bs.modal', function (e) {
                $("#chkToggle" + id).data("bs.toggle").off(true);
            })
        }        

        function onoff(id, estado, correo, titulo) {            
            var fecha = $('#fechaPublica').val();
            if (fecha == "" && $('#fechaPublica').is(':visible')) {
                $('#fechaPublica')[0].reportValidity();
            } else {
                $.ajax({
                    type: 'POST',
                    url: 'Tareas.aspx/PublicaProducto',
                    data: "{'id':'" + id + "','fecha':'" + fecha + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                    },
                    success: function (exitoso) {
                        var JsonD = $.parseJSON(exitoso.d);
                        if (JsonD.success == 1) {
                            // Se publicó el producto
                            //Aquí sí envía el correo
                            Correo(correo, titulo);
                            $('#modalPublica').modal('toggle');
                            TablaProductos();
                            PNotify.success({
                                //title: 'Producto Eliminado',
                                text: 'El producto ha sido publicado correctamente.',
                                delay: 3000,
                                addClass: 'translucent'
                            });                                                       
                        } else if (JsonD.success == 2) {
                            // Se cambió el estado de el producto a 'Aceptado' (Ya no está publicado)
                            TablaProductos();
                            PNotify.success({
                                //title: 'Producto Eliminado',
                                text: 'El producto ya no se encuentra publicado.',
                                delay: 3000,
                                addClass: 'translucent'
                            });                            
                        } else {
                            // No debería llegar aquí, es un error
                            TablaProductos();
                            PNotify.notice({
                                //title: 'Producto Eliminado',
                                text: 'Ocurrió un error, favor de intentarlo más tarde. Si el problema persiste contacte con un administrador',
                                delay: 4500,
                                addClass: 'translucent'
                            });
                            if ($('#modalPublica').is(':visible')) {
                                $('#modalPublica').modal('toggle');
                            }
                        }
                        $('#fechaPublica').val("")
                    }
                });
            }         
        };

        function Correo(correo, titulo){
            $.ajax({
                type: 'POST',
                url: 'Tareas.aspx/EnviarCorreo',
                data: "{'Correo':'" + correo +"','Titulo':'" + titulo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function () {
                     console.log('Fue enviado un email!!');
                }
            });
        };

        <%-- Editar comentarios --%>         
        $('#btnEditarMensaje').on('click', function (){
            //$('#message-text-original').val($('#message-text2').val());
            
            $('#btnEditarMensaje').hide();
            $('#btnCierra').hide();
            $('#btnGuardarMensaje').removeClass("d-none");
            $('#btnCancelar').removeClass("d-none");
            
            $('#message-text2').attr('readonly', false);
            $('#message-text2').val($('#message-text2').val().trim());
        });

        // Resetea el texto y el textarea al cerrar el modal
        $('#modaleditComentarios').on('hidden.bs.modal', function (event) {
            $('#btnEditarMensaje').show();
            $('#btnCierra').show();
            $('#btnGuardarMensaje').addClass("d-none");
            $('#btnCancelar').addClass("d-none");

            $('#message-text2').attr('readonly', true);            
        });

        $('#btnCancelar').on('click', function (){
            $('#message-text2').val($('#message-text-original').val());
            
            $('#btnEditarMensaje').show();
            $('#btnCierra').show();
            $('#btnGuardarMensaje').addClass("d-none");
            $('#btnCancelar').addClass("d-none");

            $('#message-text2').attr('readonly', true);      
        });
        
        // Ejecutar la función para guardar comentarios
        $('#btnGuardarMensaje').on('click', function(){
            editarComentarios();
        });

        function editarComentarios() {            
            var coments = $('#message-text2').val();
            var id = $('#idcoments').val();
            coments = coments.replaceAll("\'", "\\'");            
            $.ajax({
                type: 'POST',
                url: 'Tareas.aspx/ModificaComentarios',
                data: "{'comentarios':'" + coments + "', 'id':'"+id+"'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (data) {
                    var JsonD = $.parseJSON(data.d);
                    if (JsonD.success == 1) {                        
                        $('#modaleditComentarios').modal('hide');
                        PNotify.success({                                
                            text: 'Comentarios guardados exitosamente.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                        TablaProductos(); 
                    } else {
                        PNotify.notice({                                
                            text: 'Ocurrió un error, favor de intentar más tarde.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                    }
                }
            });
        };

    </script>
</asp:Content>

