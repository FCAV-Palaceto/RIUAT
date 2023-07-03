<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" codefile="Exportar.aspx.cs" inherits="Exportar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/PNotifyBrightTheme.css" rel="stylesheet" />

    <script src="js/PNotify/PNotify.js"></script>    
    <script src="js/PNotify/PNotifyMobile.js"></script>  
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <%-- DataTables --%>

    <link href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="https://editor.datatables.net/extensions/Editor/css/editor.dataTables.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/select/1.4.0/css/select.dataTables.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/buttons/2.2.3/css/buttons.dataTables.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/datetime/1.1.2/css/dataTables.dateTime.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/colreorder/1.5.6/css/colReorder.dataTables.min.css" rel="stylesheet" />
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-12">                
                <div id="espacio">                    
                    <h3>Exportar <strong>Envíos</strong></h3>
                </div>                                     
                
                <div class="card my-4">
                    <p class="card-header"><b>Filtrar env&iacute;os exportados</b></p>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-3 col-md-3">
                                <label for="Filtroexportar" class="col-form-label">Filtrar</label>
                                <select class="form-control" id="Filtroexportar" onchange="changetipo();">
                                    <option value="1">Envíos exportados</option>
                                    <option value="2">Envíos sin exportar</option>
                                </select>
                            </div>
                            <div class="col-3 col-md-3" id="fechasexpo">
                                <label for="dateInicio" class="col-form-label">Fecha de Inicio*</label>
                                <input class="form-control" id="dateInicio" type="date" required="required" />
                            </div>
                            <div class="col-3 col-md-3" id="fechasexpo2">
                                <label for="dateFin" class="col-form-label">Fecha de Fin*</label>
                                <input class="form-control" id="dateFin" type="date" required="required" />
                            </div>
                            <div class="mt-md-auto mt-3">                                
                                <button class="btn btn-primary text-white float-right" id="btnBuscar" type="button" onclick="busqueda();">Buscar</button>
                            </div>
                        </div>                 
                    </div>
                </div>                
                <div class="card" id="expor">
                    <p class="card-header"><b>Lista de env&iacute;os</b></p>
                    <div class="card-body">
                        <div id="tabproductos"></div> 
                    </div>
                </div>
                <div class="card" id="sinexpor">
                    <p class="card-header"><b>Lista de env&iacute;os</b></p>
                    <div class="card-body">
                        <div id="tabproductos2"></div>
                    </div>
                </div>                 
            </div>
        </div>
    </div>

    <%-- toast --%>
    <div aria-live="polite" aria-atomic="true" style="position: fixed; min-height: 200px; top: 1rem; right: 1rem;">
        <div id="toastWarning" class="toast fade hide" role="alert" aria-live="assertive" aria-atomic="true" data-delay="5000">
            <div class="toast-header bg-warning">
                <strong class="mr-auto"><i class="icon-warning align-middle">&nbsp;</i>Fechas inválidas</strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span class="text-white" aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body" style="background:rgba(240, 173, 78, 0.5);">
                Ingrese un rango de fechas válido.
            </div>
        </div>        
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="Scripts2" runat="Server">
    <%-- DataTables --%>   
    <%--<script src="DataTables-1.12.1/datatables.min.js"></script>--%>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    <script src="https://editor.datatables.net/extensions/Editor/js/dataTables.editor.min.js"></script>
    <script src="https://cdn.datatables.net/select/1.4.0/js/dataTables.select.min.js"></script>
    <script src="https://cdn.datatables.net/datetime/1.1.2/js/dataTables.dateTime.min.js"></script>
    <script src="https://cdn.datatables.net/colreorder/1.5.6/js/dataTables.colReorder.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.3/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js"></script>

    <script src="https://cdn.datatables.net/buttons/2.2.3/js/buttons.html5.min.js"></script>
    <script src="js/exportar.js"></script>

    <script>

        function changetipo() {
            var x = document.getElementById("Filtroexportar").value;
            if (x == 1) {
                document.getElementById("fechasexpo").style.display = "block";
                document.getElementById("fechasexpo2").style.display = "block";
            }
            if (x == 2) {
                document.getElementById("fechasexpo").style.display = "none";
                document.getElementById("fechasexpo2").style.display = "none";
            }
        }

        function busqueda() {
            var x = document.getElementById("Filtroexportar").value;
            if (x == 1) {
                TablaProductos();
                document.getElementById("expor").style.display = "block";
                document.getElementById("sinexpor").style.display = "none";
            } else {
                TablaProductosSinExpo();
                //TablaProductosSinExpo2();
                document.getElementById("sinexpor").style.display = "block";
                document.getElementById("expor").style.display = "none";
            }
        }
    </script>
</asp:content>

