<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" codefile="Coleccion.aspx.cs" inherits="Coleccion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <h1 class="mb-3">Elegir Colecci&oacute;n</h1>
        <p>Seleccione la colecci&oacute;n a la que desea enviar un nuevo producto acad&eacute;mico, y haga clic en "Siguiente".</p>
        <%-- AQUÍ EMPIEZA LA SELECCION DEL TIPO DE PRODUCTO ACADEMICO --%>
        <div id="tipoProducto">
            <div class="row mb-4">
                <div class="col-12">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <label class="input-group-text" for="selectColeccion">Colección</label>
                        </div>
                        <select id="selectColeccion" class="custom-select inputs" required="required">
                            <option value="" selected>Seleccione...</option>
                            <%--<option value="76">Acceso Abierto > Archivo Institucional</option>--%>
                            <option value="1262">Acceso Abierto > Documentanción Cientifica</option>
                            <%--<option value="77">Acceso Abierto > Patrimonio Documental</option>
                            <option value="78">Acceso Abierto > Publicaciones y Producciones Universitarias</option>
                            <option value="702">Acceso Abierto > Recursos Educativos</option>--%>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-12">
                    <div class="btn-group float-right" role="group">
                        <button class="btn btn-light border text-nowrap col" type="button" onclick="window.location.href='Inicio.aspx'">Cancelar</button>
                        <input id="btnSiguiente" class="btn btnsBS col" type="button" value="Siguiente" onclick="muestraFormulario()" />
                    </div>
                </div>
            </div>        
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="Scripts2" runat="Server">
    <script>
        function muestraFormulario() {
            if ($('#selectColeccion')[0].checkValidity()) {
                var coleccion = $('#selectColeccion').val();
                sessionStorage.setItem("coleccion", coleccion);
                
                window.location.href = "Formulario.aspx";
            } else {
                $('#selectColeccion')[0].reportValidity()
            }
        }
    </script>
</asp:content>

