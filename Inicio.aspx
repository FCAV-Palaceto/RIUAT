<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" codefile="Inicio.aspx.cs" inherits="Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%-- DataTables --%>
    <link href="DataTables-1.12.1/datatables.min.css" rel="stylesheet" />
    <style>
        /* Para que si se introduce una palabra muuuuuuuuy larga se rompa y no haga overflow
           ********* PUEDE NO FUNCIONAR EN NAVEGADORES MUUUY VIEJOS  ********** */
        table tr td:nth-child(2) {
            word-break: break-word;
        }
    </style>

    <link href="css/PNotifyBrightTheme.css" rel="stylesheet" />

    <script src="js/PNotify/PNotify.js"></script>    
    <script src="js/PNotify/PNotifyMobile.js"></script>    
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <%--<button type="button" onclick="PNotify.notice({title: 'Regular Notice',text: 'Check me out! I\'m a notice.'});">Presiona aquí</button>--%>
        <div class="row align-items-center">
            <div class="col-md-12">
                <div class="mb-4">
                    <h3>Mis <strong>Envíos:</strong> <%=nombreUsu %></h3>
                    <%--<div class="dropdown">
                        <span style="float: right; cursor: pointer;" class="forgot-pass dropdown-toggle" id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><b><i class="icon-user-circle-o mr-2"></i><%=nombreUsu %></b></span>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenu">
                            <a class="dropdown-item text-decoration-none" href="Contrasena.aspx">Cambiar contrase&ntilde;a</a>
                            <div class="dropdown-divider"></div>
                            <a href="Login.aspx" class="dropdown-item forgot-pass text-decoration-none"><b><i class="icon-power-off mr-2"></i>Cerrar Sesión</b></a>
                        </div>
                    </div>--%>     
                </div>
                <div class="row">
                    <div class="col-md-3 px-4 mb-4" style="float: right;">
                        <input type="button" value="Comenzar nuevo envío" onclick="limpiaVariable()" class="btn btn-pill text-white btn-block btn-primary" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 px-4 table-responsive ">
                        <div id="tabproductos"></div>
                    </div>
                </div>
                <div class="row mt-5 card mx-2"> 
                    <h5 class="card-header">Detalles:</h5>
                    <div class="card-body row">
                        <div class="col-auto"><i class="icon-edit bg-info text-white p-1 rounded"></i>&nbsp; Editar producto</div>
                        <div class="col-auto"><i class="icon-search bg-secondary text-white p-1 rounded"></i>&nbsp; Visualizar producto</div>
                        <div class="col-auto"><i class="icon-trash-o bg-danger text-white p-1 rounded"></i>&nbsp; Eliminar producto</div>
                        <div class="col-auto"><i class="icon-message bg-light p-1 rounded border"></i>&nbsp; Ver comentarios</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal borrar -->
    <div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="modalEliminarLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalEliminarLabel">Eliminar producto</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    ¿Desea eliminar el producto?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-danger" data-toggle="modal" data-dismiss="modal" id="eliminaProducto">Eliminar</button>
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
</asp:content>
<asp:content id="Content3" contentplaceholderid="Scripts2" runat="Server">
    <script src="js/inicio.js"></script>
    <script src="js/acciones.js"></script>
    <%-- DataTables --%>   
    <script src="DataTables-1.12.1/datatables.min.js"></script>

    <script>

        /*function Tipo(){
            var tipo=document.getElementById("tipo").innerText;

            switch(tipo){
                case 'articulo':
                    document.getElementById("tipo").textContent="Artículo";
                    break;
                case 'libro':
                    document.getElementById("tipo").textContent="Libro";
                    break;
                case 'capitulo':
                    document.getElementById("tipo").textContent="Capítulo";
                    break;
                case 'tesism':
                    document.getElementById("tipo").textContent="Tesis Maestría";
                    break;
                case 'tesisd':
                    document.getElementById("tipo").textContent="Tesis Doctorado";
                    break;
                case 'conjuntod':
                    document.getElementById("tipo").textContent="Conjunto de Datos";
                    break;
                case 'imagen':
                    document.getElementById("tipo").textContent="Imagen";
                    break;
                case 'audio':
                    document.getElementById("tipo").textContent="Audio";
                    break;
                case 'video':
                    document.getElementById("tipo").textContent="Video";
                    break;
                case 'otros':
                    document.getElementById("tipo").textContent="Otros";
                    break;
            }
        }*/
        

        window.onload = function () {
            TablaProductos();
        };

        function TablaProductos() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'Inicio.aspx/SelProductos',
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
            $('#tabla').DataTable({
                "lengthMenu": [5, 10, 25, 50, 75, 100],
                "pageLength": leng,
                pagingType: 'numbers',
                "order": [[4, 'asc'], [1, 'asc']],
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
        };

        $('#modalComentarios').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget) // Button that triggered the modal
            var recipient = button.data('whatever').toString();//.split('||').join('\n\n'); // Extract info from data-* attributes y lo separa por renglones
            recipient = recipient.replaceAll("``", "").replaceAll("||", "=============================================");
            //recipient = recipient.split('~~').join('\n');
            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            var modal = $(this);
            modal.find('.modal-body textarea').val(recipient);
        });
    </script>
</asp:content>

