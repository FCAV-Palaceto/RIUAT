<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Formulario.aspx.cs" Inherits="Formulario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- CSS only -->
    <%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <h1 class="mb-3">Formulario de Captura</h1>
        <p>Seleccione el tipo de archivo</p>
        <%--<p><b>Tipos de archivos*</b></p>--%>
        <%-- AQUÍ EMPIEZA LA SELECCION DEL TIPO DE PRODUCTO ACADEMICO --%>
        <div id="tipoProducto">
            <div class="row mb-3">
                <div class="col-sm-12 col-md-6">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="radioArticulo" name="producto" class="mt-0" type="radio" value="articulo" checked="checked" />
                            </div>
                        </div>
                        <label class="form-control border" for="radioArticulo">
                            Art&iacute;culo
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="libro" name="producto" class="mt-0" type="radio" value="libro" />
                            </div>
                        </div>
                        <label class="form-control border" for="libro">
                            Libro
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="capituloLibro" name="producto" class="mt-0" type="radio" value="capitulo" />
                            </div>
                        </div>
                        <label class="form-control border" for="capituloLibro">
                            Cap&iacute;tulo Libro
                        </label>
                    </div>                    
                </div>
                <div class="col-sm-12 col-md-6">
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="tesisMaestria" name="producto" class="mt-0" type="radio" value="tesism" />
                            </div>
                        </div>
                        <label class="form-control border" for="tesisMaestria">
                            Tesis Maestr&iacute;a
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="tesisDoctorado" name="producto" class="mt-0" type="radio" value="tesisd" />
                            </div>
                        </div>
                        <label class="form-control border" for="tesisDoctorado">
                            Tesis Doctorado
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="conjuntoDatos" name="producto" class="mt-0" type="radio" value="conjuntod" />
                            </div>
                        </div>
                        <label class="form-control border" for="conjuntoDatos">
                            Conjunto de Datos
                        </label>
                    </div>
                    <%--<div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="imagen" name="producto" class="mt-0" type="radio" value="imagen" />
                            </div>
                        </div>
                        <label class="form-control border" for="imagen">
                            Imagen
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="audio" name="producto" class="mt-0" type="radio" value="audio" />
                            </div>
                        </div>
                        <label class="form-control border" for="audio">
                            Audio
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="video" name="producto" class="mt-0" type="radio" value="video" />
                            </div>
                        </div>
                        <label class="form-control border" for="video">
                            Video
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="patente" name="producto" class="mt-0" type="radio" value="patente" />
                            </div>
                        </div>
                        <label class="form-control border" for="patente">
                            Patente
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="monografia" name="producto" class="mt-0" type="radio" value="monografia" />
                            </div>
                        </div>
                        <label class="form-control border" for="monografia">
                            Monografía
                        </label>
                    </div>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <div class="input-group-text">
                                <input id="otros" name="producto" class="mt-0" type="radio" value="otros" />
                            </div>
                        </div>
                        <label class="form-control border" for="otros">
                            Otros
                        </label>
                    </div>--%>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col-12">
                    <div class="btn-group float-right" role="group">
                        <button class="btn btn-light border text-nowrap col" type="button" onclick="window.location.href='Inicio.aspx'">Cancelar</button>
                        <button id="btnSiguiente" type="button" class="btn btnsBS col rounded-right" onclick="mostrarForm()">Siguiente</button>                        
                        <asp:textbox runat="server" id="hiddenArticulo" hidden="hidden"/> 
                        <button type="button" id="btnArticulo" class="btn btn-primary" onServerClick="btnArticulo_Click" runat="server" hidden="hidden"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Scripts2" runat="Server">
    <script src="js/formulario.js"></script>
</asp:Content>

