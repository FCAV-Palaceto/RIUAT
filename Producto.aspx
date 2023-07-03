<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Producto.aspx.cs" Inherits="Producto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/jquery-ui.min.css" rel="stylesheet" />
    <style>
        .ui-autocomplete-loading {
            background: white url("img/ui-anim_basic_16x16.gif") no-repeat right center;
        }
    </style>
    <script src="js/jquery-ui.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid">
        <h1 id="tituloform" class="mb-3">Formulario de Captura</h1>
        <p>Por favor, introduzca la siguiente informaci&oacute;n.</p>
        <%-- A PARTIR DE AQUÍ EMPIEZA EL FORMULARIO --%>
        <div id="formulario">
            <div id="idProducto" class="row mb-3">
                <input id="product" type="text" name="name" value="<%=articulo %>" hidden="hidden"/>
                <input id="id" type="text" name="id" value="<%=idProducto %>" hidden="hidden"/>
                <input id="tipousu" type="text" name="id" value="<%=tipoUsu %>" hidden="hidden"/>
                <input id="idEstado" type="text" name="id" value="<%=estado %>" hidden="hidden"/>
            </div>
            <div id="titulo" class="row mb-3">
                <label for="txtTitulo" class="col-sm-12 col-md-2 col-form-label">T&iacute;tulo<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input id="txtTitulo" type="text" class="form-control inputs" required="required" />
                    <small class="form-text text-muted">Ingrese el t&iacute;tulo del producto acad&eacute;mico que seleccion&oacute;.</small>
                </div>
            </div>
            <div id="autorAlert" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de llenar los campos correctamente.</span>
            </div>
            <div id="autor" class="row mb-3">
                <label for="txtAutor" class="col-sm-12 col-md-2 col-form-label">Autor(es)<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <div class="row">
                        <div id="divAutor" class="col-6">
                            <input id="txtAutorhidd" type="text" class="form-control inputs" hidden="hidden" />
                            <input id="txtAutor" type="text" class="form-control inputs" placeholder="Ejemplo: José Cantú García" />
                        </div>
                        <div id="divAutorCVU" class="col-6">
                            <input id="txtCVU" type="text" class="form-control inputs" placeholder="CVU, ORCID o CURP" />
                        </div>
                    </div>
                    <small class="form-text text-muted">Ingrese el autor o autores quienes elaboraron el producto acad&eacute;mico.</small>
                </div>
                <div id="divAut" class="col-2">
                    <input id="btnAutor" type="button" class="btn btn-light border" onclick="" value="Agregar" />
                </div>
            </div>
            <div id="articulo" class="row mb-3">
                <label for="selectArticulo" class="col-sm-12 col-md-2 col-form-label">Tipo de Art&iacute;culo<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select id="selectArticulo" class="form-control inputs" name="">
                        <option value="">-- Seleccione el tipo de artículo --
                        </option>
                        <option value="Arbitrado">Arbitrado
                        </option>
                        <option value="Indexado">Indexado
                        </option>
                        <option value="Difusión">Difusi&oacute;n
                        </option>
                        <option value="Divulgación">Divulgaci&oacute;n
                        </option>
                    </select>
                    <small class="form-text text-muted">Seleccione el tipo de art&iacute;culo al cual pertenece el producto acad&eacute;mico.</small>
                </div>
            </div>
            <div id="colaboracion" class="row mb-3">
                <label for="txtColaboracion" class="col-sm-12 col-md-2 col-form-label">Tipo de Colaboraci&oacute;n<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input id="txtColaboracion" type="text" class="form-control inputs"/>
                    <small class="form-text text-muted">Seleccione el tipo de colaboraci&oacute;n del autor o autores.</small>
                    <%--<div class="form-text">
                        <a href="#!" class="link-primary text-decoration-none">Elija una opci&oacute;n</a>
                    </div>--%>
                </div>
            </div>
            <div id="emailAlert" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de ingresar un correo electr&oacute;nico v&aacute;lido.</span>
            </div>
            <div id="emailAlert2" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de llenar los campos correctamente.</span>
            </div>
            <div id="email" class="row mb-3">
                <label for="txtEmail" class="col-sm-12 col-md-2 col-form-label">Correo Electrónico de Autor(es)<span class="text-danger">*</span></label>
                <div id="divEmail" class="col-sm-12 col-md-8">
                    <input id="txtEmail" type="email" class="form-control inputs" />
                    <small class="form-text text-muted">Ingrese los correos electr&oacute;nicos del autor o autores.</small>
                </div>
                <div id="divCorreo" class="col-2">
                    <button id="btnCorreo" type="button" class="btn btn-light border">Agregar</button>
                </div>
            </div>
            <div id="grado" class="row mb-3">
                <label for="selectGrado" class="col-sm-12 col-md-2 col-form-label">Grado Obtenido<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select id="selectGrado" name="gradoObtenido" class="form-control inputs" required="required">
                        <option value="">-- Seleccione el grado obtenido --
                        </option>
                    </select>
                    <small class="form-text text-muted">Seleccione el grado obtenido por el producto acad&eacute;mico.</small>
                </div>
            </div>
            <div id="asesorAlert" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de llenar los campos correctamente.</span>
            </div>
            <div id="asesor" class="row mb-3">
                <div class="form-text mb-2">
                </div>
                <label for="txtAsesor" class="col-sm-12 col-md-2 col-form-label">Asesor de Tesis<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <div class="row">
                        <div id="divAsesor" class="col-6">
                            <input type="text" id="txtAsesorhidd" value="" hidden="hidden" />
                            <input class="form-control inputs" id="txtAsesor" type="text" placeholder="Ejemplo: José Cantú García" />
                        </div>
                        <div id="divAsesorCVU" class="col-6">
                            <input class="form-control inputs" id="txtAsesorCVU" type="text" placeholder="CVU, ORCID o CURP" />
                        </div>
                    </div>
                    <small class="form-text text-muted">Ingrese los nombres del asesor o asesores del producto acad&eacute;mico.</small>
                </div>

                <div id="divAsesr" class="col-2">
                    <button id="btnAsesor" class="btn btn-light border" type="button">Agregar</button>
                </div>
            </div>
            <div id="patrocinadorAlert" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de llenar los campos correctamente.</span>
            </div>
            <div id="patrocinador" class="row mb-3">
                <label for="txtPatrocinador" class="col-sm-12 col-md-2 col-form-label">Patrocinadores<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <div class="row">
                        <div id="divPatrocinador" class="col-6">
                            <input class="form-control inputs" id="txtPatrocinador" type="text" placeholder="Ejemplo: Revista ciencia UAT" />
                        </div>
                        <div id="divPatrocinadorVol" class="col-6">
                            <input class="form-control inputs" id="txtPatrocinadorVol" type="text" placeholder="(1461023x) vol.4 (2001)" />
                        </div>
                    </div>
                    <small class="form-text text-muted">Ingrese los patrocinadores del producto acad&eacute;mico.</small>
                </div>
                <div id="divPatrocinadr" class="col-2">
                    <button id="btnPatrocinador" class="btn btn-light border" type="button">Agregar</button>
                </div>
            </div>
            <div id="mono" class="row mb-3">
                <label for="selectMonografia" class="col-sm-12 col-md-2 col-form-label">Tipo de Monograf&iacute;a</label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" id="selectMonografia" name="">
                        <option value="">-- Seleccione el tipo de monografía --
                        </option>
                        <option value="Reporte Técnico">Reporte T&eacute;cnico
                        </option>
                        <option value="Reporte de Proyecto">Reporte de Proyecto
                        </option>
                        <option value="Documentación">Documentaci&oacute;n
                        </option>
                        <option value="Manual">Manual
                        </option>
                        <option value="Documento de Trabajo">Documento de Trabajo
                        </option>
                        <option value="Documento de Discusión">Documento de Discusi&oacute;n
                        </option>
                        <option value="Otro">Otro
                        </option>
                    </select>
                    <small class="form-text text-muted">Seleccione el tipo de monograf&iacute;a</small>
                </div>
            </div>
            <div id="resumen" class="row mb-3">
                <label for="txtResumen" class="col-sm-12 col-md-2 col-form-label">Resumen<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <textarea class="form-control inputs" rows="3" id="txtResumen" required="required" maxlength="2500" onkeyup="contador(this,1);"></textarea>
                        <small class="form-text text-muted">Ingrese el resumen del producto acad&eacute;mico.<span id="charNum" class="float-right">(0/2500)</span></small>
                </div>
            </div>
            <div id="citacion" class="row mb-3">
                <label for="txtCitacion" class="col-sm-12 col-md-2 col-form-label">Citaci&oacute;n<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <textarea class="form-control inputs" rows="3" id="txtCitacion" required="required" maxlength="300" onkeyup="contador(this,2);"></textarea>
                    <small class="form-text text-muted">Ejemplo: Apellido, A. A., Apellido, B. B. y Apellido, C. C. (Año). T&iacute;tulo del art&iacute;culo. T&iacute;tulo de la publicaci&oacute;n, volumen (N&uacute;mero), pp-pp. <span id="charNum2" class="float-right">(0/300)</span></small>
                </div>
            </div>
            <div id="palabrasAlert" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de ingresar una palabra v&aacute;lida.</span>
            </div>
            <div id="palabrasAlert2" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Ha alcanzado el límite de 5 palabras.</span>
            </div>
            <div id="palabrasAlert3" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de introducir al menos una palabra clave.</span>
            </div>
            <div id="palabras" class="row mb-3">
                <label for="txtPalabrasCve" class="col-sm-12 col-md-2 col-form-label">Palabras Clave<span class="text-danger">*</span></label>
                <div id="divPalabras" class="col-8">
                    <input class="form-control inputs" id="txtPalabrasCve" type="text" maxlength="50"/>
                    <small class="form-text text-muted">Ingrese las palabras clave del producto acad&eacute;mico de una en una. (M&aacute;ximo 5 palabras).</small>
                </div>
                <div id="divPalabr" class="col-2">
                    <button id="btnPalabras" class="btn btn-light border" type="button">Agregar</button>
                </div>
            </div>
            <div id="fechapublicacion" class="row mb-3">
                <label for="datePublicacion" class="col-sm-12 col-md-2 col-form-label">Fecha de Publicaci&oacute;n o Terminaci&oacute;n<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="datePublicacion" type="date" required="required" />
                    <small class="form-text text-muted">Ingrese la fecha de publicaci&oacute;n o terminaci&oacute;n del producto acad&eacute;mico.</small>
                </div>
            </div>
            <div id="descripcion" class="row mb-3">
                <label for="txtDescripcion" class="col-sm-12 col-md-2 col-form-label">Descripci&oacute;n de la Revista o Libro<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <div class="row">
                        <div class="col-6">
                            <input class="form-control inputs" id="txtDescripcion" type="text" placeholder="Ejemplo: Revista ciencia UAT" required />
                        </div>
                        <div class="col-6">
                            <input class="form-control inputs" id="txtDescripcionVol" type="text" placeholder="2(2)" required />
                        </div>
                    </div>
                    <small class="form-text text-muted">Favor de llenar el campo en este formato: T&iacute;tulo de la revista, publicaci&oacute;n o T&iacute;tulo de su cap&iacute;tulo (ISSN o ISBN) numeraci&oacute;n (cronolog&iacute;a).</small>
                </div>
            </div>
            <div id="rango" class="row mb-3">
                <label for="txtRango" class="col-sm-12 col-md-2 col-form-label">Rango de P&aacute;ginas<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtRango" type="text"/>
                    <small class="form-text text-muted">Ejemplo: 12-20</small>
                </div>

            </div>
            <div id="arbitrado" class="row mb-3">
                <label for="selectArbitrado" class="col-sm-12 col-md-2 col-form-label">Arbitrado<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" id="selectArbitrado" name="">
                        <option value="Ha sido Arbitrado">Ha sido Arbitrado</option>
                        <option value="No ha sido Arbitrado">No ha sido Arbitrado</option>
                    </select>
                    <small class="form-text text-muted">Seleccione.</small>
                </div>
            </div>
            <div id="isbn" class="row mb-3">
                <label for="txtISBN" class="col-sm-12 col-md-2 col-form-label">ISBN<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtISBN" type="text" required="required" />
                    <small class="form-text text-muted">Ingrese el ISBN del libro.</small>
                </div>
            </div>
            <div id="publicador" class="row mb-3">
                <label for="txtPublicador" class="col-sm-12 col-md-2 col-form-label">Publicador<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtPublicador" type="text"/>
                    <small class="form-text text-muted">Si su obra fue financiada ingrese el nombre del publicador.</small>
                </div>
            </div>
            <div id="institucion" class="row mb-3">
                <label for="txtInstitucion" class="col-sm-12 col-md-2 col-form-label">Instituci&oacute;n de Procedencia<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <div class="row">
                        <div class="col-md-6 col-12 mb-md-0 mb-3">
                            <select class="form-control inputs" id="txtInstitucionZona" name="institucionProcedencia" onchange="populate(this.id,'txtInstitucion')" required="required">
                                <option value="">--Selecciona la Zona--</option>
                                <option value="ZonaCentro">Zona Centro</option>
                                <option value="ZonaSur">Zona Sur</option>
                                <option value="ZonaNorte">Zona Norte</option>
                            </select>
                        </div>
                        <div class="col-md-6 col-12">
                            <select class="form-control inputs" id="txtInstitucion" name="institucionProcedencia2" required="required">
                                <option value="" selected>--Selecciona la Instituci&oacute;n--</option>
                            </select>
                        </div>
                    </div>
                    <%--<input class="form-control inputs" id="txtInstitucion" type="text" />--%>
                    <small class="form-text text-muted">Ingrese el nombre de la instituci&oacute;n donde se realiz&oacute; la tesis.</small>
                    <%--<div class="form-text">
                        <a href="#!" class="link-primary text-decoration-none">Elija una opci&oacute;n</a>
                    </div>--%>
                </div>
            </div>
            <div id="edicion" class="row mb-3">
                <label for="selectEdicion" class="col-sm-12 col-md-2 col-form-label">Edici&oacute;n<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" id="selectEdicion" name="">
                        <option value="Primera Edición">Primera Edici&oacute;n</option>
                        <option value="Segunda Edición">Segunda Edici&oacute;n</option>
                        <option value="Tercera Edición">Tercera Edici&oacute;n</option>
                        <option value="Cuarta Edición">Cuarta Edici&oacute;n</option>
                        <option value="Quinta Edición">Quinta Edici&oacute;n</option>
                    </select>
                    <small class="form-text text-muted">Ingrese la edici&oacute;n del libro. Ej. 8va</small>
                </div>

            </div>
            <div id="candidato" class="row mb-3">
                <label for="txtCandidato" class="col-sm-12 col-md-2 col-form-label">Candidato de la Patente<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtCandidato" type="text" required="required" />
                    <small class="form-text text-muted">El nombre del solicitante al que se concedi&oacute; la patente. Puede ser una persona o una organizaci&oacute;n</small>
                </div>
            </div>
            <div id="identificacion" class="row mb-3">
                <label for="txtIdentificacion" class="col-sm-12 col-md-2 col-form-label">N&uacute;mero de Identificaci&oacute;n<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtIdentificacion" type="text" required="required" />
                    <small class="form-text text-muted">El n&uacute;mero de solicitud de patente.</small>
                </div>
            </div>
            <div id="paginas" class="row mb-3">
                <label for="txtPaginas" class="col-sm-12 col-md-2 col-form-label">N&uacute;mero de P&aacute;ginas<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtPaginas" type="text" onkeypress="return isNumberKey(event)"/>
                    <small class="form-text text-muted">Ingrese el n&uacute;mero de p&aacute;ginas del producto acad&eacute;mico.</small>
                </div>
            </div>
            <div id="tiraje" class="row mb-3">
                <label for="txtTiraje" class="col-sm-12 col-md-2 col-form-label">Tiraje</label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtTiraje" type="text" onkeypress="return isNumberKey(event)" />
                    <small class="form-text text-muted">Ingrese el n&uacute;mero de ejemplares que se imprimieron. Ej. 500</small>
                </div>
            </div>
            <div id="idioma" class="row mb-3">
                <label for="selectIdioma" class="col-sm-12 col-md-2 col-form-label">Idioma<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" name="idiomaProducto" id="selectIdioma" required="required">
                        <option value="">-- Seleccione el idioma --</option>
                    </select>
                    <small class="form-text text-muted">Seleccione el idioma del producto acad&eacute;mico.</small>
                </div>
            </div>
            <div id="pais" class="row mb-3">
                <label for="selectPais" class="col-sm-12 col-md-2 col-form-label">Pa&iacute;s<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" name="paisProducto" id="selectPais" required="required">
                        <option value="">-- Seleccione el país --</option>
                    </select>
                    <small class="form-text text-muted">Seleccione el pa&iacute;s del producto acad&eacute;mico.</small>
                </div>
            </div>
            <div id="publicacion" class="row mb-3">
                <label for="selectPublicacion" class="col-sm-12 col-md-2 col-form-label">Tipo de Publicaci&oacute;n<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" id="selectPublicacion" name="tipoPublicacion" required="required">
                        <option value="">-- Seleccione el tipo de acceso --</option>
                        <option value="Acceso Abierto">Acceso Abierto</option>
                        <option value="Acceso Cerrado">Acceso Cerrado</option>
                        <option value="Acceso Embargado">Acceso Embargado</option>
                        <option value="Acceso Restringido">Acceso Restringido</option>
                    </select>
                    <small class="form-text text-muted">Seleccione el tipo de acceso que tiene el producto acad&eacute;mico.</small>
                </div>
            </div>
            <div id="finalizacion" class="row mb-3">
                <label for="dateEmbargo" class="col-sm-12 col-md-2 col-form-label">Fecha de Finalización de Embargo</label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="dateEmbargo" type="date" disabled="disabled" />
                    <small class="form-text text-muted">Ingrese la fecha de terminaci&oacute;n del embargo (en caso de que haya seleccionado en tipo de publicaci&oacute;n "Acceso Embargado").</small>
                </div>
            </div>
            <div id="proyectoAlert" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de ingresar un proyecto.</span>
            </div>
            <div id="proyecto" class="row mb-3">
                <label for="txtProyecto" class="col-sm-12 col-md-2 col-form-label">Proyecto</label>
                <div id="divProyecto" class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtProyecto" type="text" />
                    <small class="form-text text-muted">Describa el(los) proyecto(s) que salieron de esta obra.</small>
                </div>
                <div id="divProyect" class="col-2">
                    <button id="btnProyecto" class="btn btn-light border" type="button">Agregar</button>
                </div>
            </div>
            <div id="area" class="row mb-3">
                <label for="areacon" class="col-sm-12 col-md-2 col-form-label">&Aacute;rea de Conocimiento<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <div class="form-text">
                        <!-- <input class="form-control" id="txtAreaC" type="text" />
                            <a href="#!" class="link-primary text-decoration-none">Elija una opci&oacute;n</a> -->
                        <select class="form-control inputs" name="areaConocimiento" id="areacon" required="required">
                            <option value="">-- Seleccione el área del conocimiento --</option>
                        </select>
                        <small class="form-text text-muted">&Aacute;rea al cual pertenece el producto acad&eacute;mico.</small>
                    </div>
                </div>
                <%--<select name="">
                    <option>
                        Seleccione
                    </option>
                </select>--%>
            </div>
            <div id="audiencia" class="row mb-3">
                <label for="selectAudiencia" class="col-sm-12 col-md-2 col-form-label">Audiencia<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" id="selectAudiencia" name="" required="required">
                        <option value="">-- Seleccione la audiencia --</option>
                    </select>
                    <small class="form-text text-muted">P&uacute;blico al cual va dirigido el producto acad&eacute;mico.</small>
                </div>
            </div>
            <div id="financiamiento" class="row mb-3">
                <label for="selectFinanciamiento" class="col-sm-12 col-md-2 col-form-label">Tipo de Financiamiento / Patrocinador<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" id="selectFinanciamiento" name="tipoFinanciamiento" required="required">
                        <option value="">-- Seleccione el tipo de financiamiento --</option>
                        <option value="conacyt">Conacyt</option>
                        <option value="otro/ninguno">Otro / ninguno</option>
                    </select>
                    <small class="form-text text-muted">Seleccione una opci&oacute;n.</small>
                </div>
            </div>
            <div id="licencia" class="row mb-3">
                <label for="selectLicencia" class="col-sm-12 col-md-2 col-form-label">Licencia<span class="text-danger">*</span></label>
                <div class="col-sm-12 col-md-8">
                    <select class="form-control inputs" id="selectLicencia" name="licenciaObra" required="required">
                        <option value="">-- Seleccione la licencia --</option>
                        <!-- <option value="">Sin Derechos Reservados(BY)</option>
                            <option value="">Atribuci&oacute;n(BY SA)</option>
                            <option value="">Atribuci&oacute;n-SinDerivadas(BY ND)</option>
                            <option value="">Atribuci&oacute;n-NoComercial-CompartirIgual(BY NC)</option>
                            <option value="">Atribuci&oacute;n-NoComercial(BY NC SA)</option>
                            <option value="">Atribuci&oacute;n-NoComercial-SinDerivadas(BY NC ND)</option> -->
                    </select>
                    <small class="form-text text-muted">Son los que permiten compartir una obra bajo determinadas condiciones.</small>
                </div>

            </div>
            <div id="url" class="row mb-3">
                <label for="txtURL" class="col-sm-12 col-md-2 col-form-label">URL del Origen del Producto Acad&eacute;mico</label>
                <div class="col-sm-12 col-md-8">
                    <input class="form-control inputs" id="txtURL" type="text" />
                    <small class="form-text text-muted">Si usted tiene la obra depositado fuera del repositorio coloque la URL en donde se encuentra. Ej. http://www.revistaciencia.uat.edu.mx/index.php/CienciaUAT</small>
                </div>
            </div>
            <div id="datosAlert" role="alert" class="alert alert-warning mb-3 d-none">
                <span>Favor de ingresar un URL v&aacute;lido.</span>
            </div>
            <div id="conjunto" class="row mb-3">
                <label for="txtDatos" class="col-sm-12 col-md-2 col-form-label">Conjunto de Datos Relacionados con el Producto Acad&eacute;mico</label>
                <div id="divDatos" class="col-sm-10 col-md-8">
                    <input class="form-control inputs" id="txtDatos" type="text" />
                    <small class="form-text text-muted">Anote el URL relacionada. Ej. url/http://riuat.uat.edu.mx/handle/123456789/20 o El identificador de objeto digital (DOI) Ej. doi/10.1234-567</small>
                </div>
                <div id="divDatosRel" class="col-2">
                    <button id="btnDatos" class="btn btn-light border" type="button">Agregar</button>
                </div>
            </div>           
            <p class="font-weight-bold"><span class="text-danger font-weight-bold">* Campos obligatorios.</span></p> 
            <div class="row mt-5" id="btnsRegular">
                <div class="col-12">
                    <div class="btn-group float-right" role="group">
                        <a href="Formulario.aspx" class="btn btn-light border col<%---sm-12 col-md-4--%>" type="button">Anterior</a>
                        <button class="btn btn-light border text-nowrap col<%---sm-12 col-md-4--%>" type="button" onclick="" data-toggle="modal" data-target="#exampleModal">Guardar</button>
                        <input id="btnSiguiente" class="btn btnsBS col<%---sm-12 col-md-4--%>" type="submit" value="Siguiente" />
                    </div>
                </div>                
            </div>
            <div class="row float-right" id="btnsAdmin">
                <div class="col-auto">
                    <button class="btn btn-light border text-nowrap col" type="button" onclick="window.location = document.referrer;">Cancelar</button>
                </div>
                   <div class="col-auto">
                    <button id="guardaAutor" class="btn btnsBS col" type="button">Guardar</button>
                </div>
            </div>
            <br>
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
                    <button id="guardarDespues" type="button" class="btn btnsBS">Guardar para despu&eacute;s</button>
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
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Scripts2" runat="Server">
    <script src="js/buscaautor.js"></script>
    <script src="js/producto.js"></script>
    <script src="js/acciones.js"></script>
    <script src="js/guardar.js"></script>
    <script>

        /*var input="textarea[maxlength]";
        $(document).on('keyup', "[maxlength]",function(e){
            var este=$(this),maxlength=este.attr('maxlength'),maxlengthint = parseInt(maxlength),textoActual = este.val(),
            currentCharacters = este.val().length;
            remainingCharacters = maxlengthint - currentCharacters, espan = este.prev('small').find('span');
            espan.html(remainingCharacters);
            if (!!maxlength) {
                var texto = este.val(); 
            }

        });*/
        /*window.onload(function(){
            var contR=document.getElementById("txtResumen").value;
            document.getElementById("charNum").innerHTML='('+contR + '/2500)';
            var contC=document.getElementById("txtCitacion").value;
            document.getElementById("charNum2").innerHTML='('+contC + '/300)'
        });*/

        function contador(obj,a){
            if(a == 1){
                var textTam=obj.value.length;
                if(textTam > 2499 ){
                    document.getElementById("charNum").innerHTML='<span style="color: red;">('+textTam + '/2500)</span>';
                }else{
                    document.getElementById("charNum").innerHTML='('+textTam + '/2500)';
                }
            }else{
                var textTam=obj.value.length;
                if(textTam > 299 ){
                    document.getElementById("charNum2").innerHTML='<span style="color: red;">('+textTam + '/300)</span>';
                }else{
                    document.getElementById("charNum2").innerHTML='('+textTam + '/300)';
                }
            }
            
        }

        function populate(s1,s2){
            var s1=document.getElementById(s1);
            var s2=document.getElementById(s2);

            s2.innerHTML = "--Selecciona la Institución--";

            if(s1.value == "ZonaCentro"){
                var array=['Escuela Preparatoria No. 3|Escuela Preparatoria No. 3','Facultad de Ingeniería y Ciencias|Facultad de Ingeniería y Ciencias','Facultad de Enfermería Victoria|Facultad de Enfermería Victoria','Facultad de Medicina Veterinaria y Zootecnia "Dr. Norberto Treviño Zapata"|Facultad de Medicina Veterinaria y Zootecnia "Dr. Norberto Treviño Zapata"','Unidad Académica Multidisciplinaria de Ciencias, Educación y Humanidades|Unidad Académica Multidisciplinaria de Ciencias, Educación y Humanidades','Unidad Académica de Trabajo Social y Ciencias para el Desarrollo Humano|Unidad Académica de Trabajo Social y Ciencias para el Desarrollo Humano','Facultad de Derecho y Ciencias Sociales Victoria|Facultad de Derecho y Ciencias Sociales Victoria','Facultad de Comercio y Administración Victoria|Facultad de Comercio y Administración Victoria','Instituto de Ecología Aplicada|Instituto de Ecología Aplicada','Centro de Lenguas y Lingüística Aplicada Victoria|Centro de Lenguas y Lingüística Aplicada Victoria','Escuela Preparatoria Mante|Escuela Preparatoria Mante','Unidad Académica Multidisciplinaria Mante Centro|Unidad Académica Multidisciplinaria Mante Centro'];
            }else if(s1.value == "ZonaSur"){
                var array=['Facultad de Arquitectura Diseño y Urbanismo|Facultad de Arquitectura Diseño y Urbanismo','Facultad de Comercio y Administración Tampico|Facultad de Comercio y Administración Tampico','Facultad de Enfermería Tampico|Facultad de Enfermería Tampico','Facultad de Música y Artes "Mtro. Manuel Barroso Ramírez"|Facultad de Música y Artes "Mtro. Manuel Barroso Ramírez"','Facultad de Ingeniería "Arturo Narro Siller"|Facultad de Ingeniería "Arturo Narro Siller"','Facultad de Medicina de Tampico "Dr. Alberto Romo Caballero"|Facultad de Medicina de Tampico "Dr. Alberto Romo Caballero"','Facultad de Derecho y Ciencias Sociales|Facultad de Derecho y Ciencias Sociales','Facultad de Odontología|Facultad de Odontología','Centro de Lenguas y Lingüística Aplicada Tampico|Centro de Lenguas y Lingüística Aplicada Tampico'];
            }else if(s1.value == "ZonaNorte"){
                var array=['Facultad de Comercio, Adminis​​tración y Ciencias Sociales Nuevo Laredo|Facultad de Comercio, Adminis​​tración y Ciencias Sociales Nuevo Laredo','Facultad de Enfermería Nuevo Laredo|Facultad de Enfermería Nuevo Laredo','Unidad Académica Multidisciplinaria Reynosa - Aztlán|Unidad Académica Multidisciplinaria Reynosa - Aztlán','Unidad Académica Multidisciplinaria Reynosa Rodhe|Unidad Académica Multidisciplinaria Reynosa Rodhe','Centro de Lenguas y Lingüística Aplicada Reynosa|Centro de Lenguas y Lingüística Aplicada Reynosa','Facultad de Medicina e Ingeniería en Sistemas Computacionales de Matamoros|Facultad de Medicina e Ingeniería en Sistemas Computacionales de Matamoros','Unidad Académica Multidisciplinaria Matamoros UAT|Unidad Académica Multidisciplinaria Matamoros UAT','Unidad Académica Multidisciplinaria Valle Hermoso|Unidad Académica Multidisciplinaria Valle Hermoso','Unidad Académica Multidisciplinaria Río Bravo|Unidad Académica Multidisciplinaria Río Bravo'];
            } else {
                array = ['|--Selecciona la Institución--'];
            }

            for(var option in array){
                var par=array[option].split("|");
                var newOption=document.createElement("option");

                newOption.value=s1.value + " - " + par[0];
                newOption.innerHTML=par[1];
                s2.options.add(newOption);
            }
        }

        function modificaRegistro() {  //trae los datos
            if($('#tipousu').val() != "0"){
                $('#btnsRegular').hide();
                $('#btnsAdmin').show();
            }else{
                $('#btnsRegular').show();
                $('#btnsAdmin').hide();
            }
            $.ajax({
                type: 'POST',
                url: 'Producto.aspx/ModificaProducto',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (datos) {
                    var JsonD = $.parseJSON(datos.d);

                    //sessionStorage.setItem("producto", JsonD.tipoarticulo);

                    $('#txtTitulo').val(JsonD.titulo);
                    // Para los registros que se deben colocar en 2 inputs
                    var arrayAutoresLista = (JsonD.autor).split("||");
                    var arrayAutoresAutor = arrayAutoresLista[0].split(";");
                    if (arrayAutoresLista.length > 0 && arrayAutoresLista[0] != '') {
                        //Recorrer el array y generar tantos inputs como registros haya
                        arrayAutoresLista.forEach(function (autor) {
                            // dividir el autor en un arreglo con nombre autor y cvu separados
                            arrayAutoresAutor = autor.split(";");

                            idAutor++;
                            // se genera la estructura
                            if (idAutor == 1) {
                                $('#autor').after('<div id="autor' + idAutor + '" class="row mb-3"></div>') //.....
                            } else {
                                $('#autor' + (idAutor - 1)).after('<div id="autor' + idAutor + '" class="row mb-3"></div>') //.....
                            }
                            $('#autor' + idAutor).append('<div id="divAutor' + idAutor + '" class="col-4 offset-2"></div>'); //.......
                            $('#autor' + idAutor).append('<div id="divAutorCVU' + idAutor + '" class="col-4"></div>'); //.......
                            $('#autor' + idAutor).append('<div id="divAut' + idAutor + '" class="col-2"></div>'); //.......

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtAutor").val(), id: 'txtAutor' + idAutor, disabled: 'disabled' }).appendTo('#divAutor' + idAutor); //...........

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtCVU").val(), id: 'txtCVU' + idAutor, disabled: 'disabled' }).appendTo('#divAutorCVU' + idAutor); //...........

                            $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar icon-trash-o', value: '', onclick: '', id: 'btnAutor' + idAutor }).appendTo('#divAut' + idAutor);

                            //se asigna cada información del autor a su input
                            $('#txtAutor' + idAutor).val(arrayAutoresAutor[0]);
                            $('#txtCVU' + idAutor).val(arrayAutoresAutor[1]);

                            //Se agrega valor al array que se usa para grabar
                            if ($('#txtAutor' + idAutor).val() != '' && $('#txtCVU' + idAutor).val() != '') {
                                arrayAutor.push($('#txtAutor' + idAutor).val() + ';' + $('#txtCVU' + idAutor).val());
                            }

                            $('#txtAutor' + idAutor).val(arrayAutoresAutor[0].replace("1", ""));
                        });
                    }
                    
                    //28/10/2022
                    //else {
                    //    if (!(arrayAutoresAutor[0].indexOf('1') == -1)){
                    //        $('#txtAutorhidd').val(arrayAutoresAutor[0]);
                    //    }
                    //    $('#txtAutor').val(arrayAutoresAutor[0].replace("1", ""));
                    //    $('#txtCVU').val(arrayAutoresAutor[1]);
                    //}
                    $('#selectArticulo option[value="' + JsonD.articulo + '"]').attr("selected", "selected");
                    $('#txtColaboracion').val(JsonD.colaborador);
                    // Dividir el campo según sus registros
                    var arrayEmails = (JsonD.email).split("||");
                    //verificar si son uno o más registros
                    if (arrayEmails.length > 0 && arrayEmails[0] != '') {
                        //Recorrer el array y generar tantos inputs como registros haya
                        arrayEmails.forEach(function (correo) {
                            //Se agrega valor al array que se usa para grabar
                            arrayEmail.push(correo);

                            idCorreo++;
                            // se genera la estructura
                            if (idCorreo == 1) {
                                $('#email').after('<div id="email' + idCorreo + '" class="row mb-3"></div>') //.....
                            } else {
                                $('#email' + (idCorreo - 1)).after('<div id="email' + idCorreo + '" class="row mb-3"></div>') //.....
                            }
                            $('#email' + idCorreo).append('<div id="divEmail' + idCorreo + '" class="col-8 offset-2"></div>'); //.......
                            $('#email' + idCorreo).append('<div id="divCorreo' + idCorreo + '" class="col-2"></div>'); //.......

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtEmail").val(), id: 'txtEmail' + idCorreo, disabled: 'disabled' }).appendTo('#divEmail' + idCorreo);  //....

                            $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar2 icon-trash-o', value: '', onclick: '', id: 'btnCorreo' + idCorreo }).appendTo('#divCorreo' + idCorreo); //.....
                            //se asigna cada email a cada campo generado
                            $('#txtEmail' + idCorreo).val(correo);
                        });
                    }
                    //else {
                    //    $('#txtEmail').val(arrayEmails[0]);
                    //}
                    $('#selectGrado option[value="' + JsonD.grado + '"]').attr("selected", "selected");
                    // Para los registros que se deben colocar en 2 inputs
                    var arrayAsesoresLista = (JsonD.asesor).split("||");
                    var arrayAsesoresAsesor = arrayAsesoresLista[0].split(";");
                    if (arrayAsesoresLista.length > 0 && arrayAsesoresLista[0] != '') {
                        //Recorrer el array y generar tantos inputs como registros haya
                        arrayAsesoresLista.forEach(function (asesor) {
                            // dividir el autor en un arreglo con nombre autor y cvu separados
                            arrayAsesoresAsesor = asesor.split(";");

                            idAsesor++;
                            // se genera la estructura
                            if (idAsesor == 1) {
                                $('#asesor').after('<div id="asesor' + idAsesor + '" class="row mb-3"></div>') //.....
                            } else {
                                $('#asesor' + (idAsesor - 1)).after('<div id="asesor' + idAsesor + '" class="row mb-3"></div>') //.....
                            }
                            $('#asesor' + idAsesor).append('<div id="divAsesor' + idAsesor + '" class="col-4 offset-2"></div>'); //.......
                            $('#asesor' + idAsesor).append('<div id="divAsesorCVU' + idAsesor + '" class="col-4"></div>'); //.......
                            $('#asesor' + idAsesor).append('<div id="divAsesr' + idAsesor + '" class="col-2"></div>'); //.......

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtAsesor").val(), id: 'txtAsesor' + idAsesor, disabled: 'disabled' }).appendTo('#divAsesor' + idAsesor); //............

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtAsesorCVU").val(), id: 'txtAsesorCVU' + idAsesor, disabled: 'disabled' }).appendTo('#divAsesorCVU' + idAsesor); //..........

                            $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar3 icon-trash-o', value: '', onclick: '', id: 'btnAsesor' + idAsesor }).appendTo('#divAsesr' + idAsesor); //............

                            //se asigna cada información del autor a su input
                            $('#txtAsesor' + idAsesor).val(arrayAsesoresAsesor[0]);
                            $('#txtAsesorCVU' + idAsesor).val(arrayAsesoresAsesor[1]);

                            //Se agrega valor al array que se usa para grabar
                            if ($('#txtAsesor' + idAsesor).val() != '' && $('#txtAsesorCVU' + idAsesor).val() != '') {
                                arrayAsesor.push($('#txtAsesor' + idAsesor).val() + ';' + $('#txtAsesorCVU' + idAsesor).val());
                            }

                            $('#txtAsesor' + idAsesor).val(arrayAsesoresAsesor[0].replace("1", ""));
                        });
                    }
                    //else {
                    //    if (!(arrayAsesoresAsesor[0].indexOf('1') == -1)) {
                    //        $('#txtAsesorhidd').val(arrayAsesoresAsesor[0]);
                    //    }

                    //    if ($('#txtAsesor').val() != '') {
                    //        $('#txtAsesor').val(arrayAsesoresAsesor[0]).replace(modal"1", "");
                    //    }                        
                    //    $('#txtAsesorCVU').val(arrayAsesoresAsesor[1]);
                    //}
                    // Para los registros que se deben colocar en 2 inputs
                    var arrayPatrocinadoresLista = (JsonD.patrocinador).split("||");
                    var arrayPatrocinadoresP = arrayPatrocinadoresLista[0].split(";");
                    if (arrayPatrocinadoresLista.length > 0 && arrayPatrocinadoresLista[0] != '') {
                        //Recorrer el array y generar tantos inputs como registros haya
                        arrayPatrocinadoresLista.forEach(function (patrocinador) {
                            // dividir el autor en un arreglo con nombre autor y cvu separados
                            arrayPatrocinadoresP = patrocinador.split(";");

                            idPatrocinador++;
                            // se genera la estructura
                            if (idPatrocinador == 1) {
                                $('#patrocinador').after('<div id="patrocinador' + idPatrocinador + '" class="row mb-3"></div>') //.....
                            } else {
                                $('#patrocinador' + (idPatrocinador - 1)).after('<div id="patrocinador' + idPatrocinador + '" class="row mb-3"></div>') //.....
                            }
                            $('#patrocinador' + idPatrocinador).append('<div id="divPatrocinador' + idPatrocinador + '" class="col-4 offset-2"></div>'); //.......
                            $('#patrocinador' + idPatrocinador).append('<div id="divPatrocinadorVol' + idPatrocinador + '" class="col-4"></div>'); //.......
                            $('#patrocinador' + idPatrocinador).append('<div id="divPatrocinadr' + idPatrocinador + '" class="col-2"></div>'); //.......

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtPatrocinador").val(), id: 'txtPatrocinador' + idPatrocinador, disabled: 'disabled' }).appendTo('#divPatrocinador' + idPatrocinador); //......

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtPatrocinadorVol").val(), id: 'txtPatrocinadorVol' + idPatrocinador, disabled: 'disabled' }).appendTo('#divPatrocinadorVol' + idPatrocinador); //.........

                            $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar4 icon-trash-o', value: '', onclick: '', id: 'btnPatrocinador' + idPatrocinador }).appendTo('#divPatrocinadr' + idPatrocinador); //.......

                            //se asigna cada información del autor a su input
                            $('#txtPatrocinador' + idPatrocinador).val(arrayPatrocinadoresP[0]);
                            $('#txtPatrocinadorVol' + idPatrocinador).val(arrayPatrocinadoresP[1]);

                            //Se agrega valor al array que se usa para grabar
                            if ($('#txtPatrocinador' + idPatrocinador).val() != '' && $('#txtPatrocinadorVol' + idPatrocinador).val() != '') {
                                arrayPatrocinador.push($('#txtPatrocinador' + idPatrocinador).val() + ';' + $('#txtPatrocinadorVol' + idPatrocinador).val());
                            }
                        });
                    }
                    //else {
                    //    $('#txtPatrocinador').val(arrayPatrocinadoresP[0]);
                    //    $('#txtPatrocinadorVol').val(arrayPatrocinadoresP[1]);
                    //}
                    $('#selectMonografia option[value="' + JsonD.monografia + '"]').attr("selected", "selected");
                    $('#txtResumen').val(JsonD.resumen);
                    $('#txtCitacion').val(JsonD.citacion);
                    // Dividir el campo según sus registros
                    var arrayPalabrasClave = (JsonD.palabras).split("||");
                    //verificar si son uno o más registros
                    if (arrayPalabrasClave.length > 0 && arrayPalabrasClave[0] != '') {
                        //Recorrer el array y generar tantos inputs como registros haya
                        arrayPalabrasClave.forEach(function (palabra) {
                            //Se agrega valor al array que se usa para grabar
                            arrayPalabras.push(palabra);

                            idPalabra++;
                            // se genera la estructura
                            if (idPalabra == 1) {
                                $('#palabras').after('<div id="palabras' + idPalabra + '" class="row mb-3"></div>') //.....
                            } else {
                                $('#palabras' + (idPalabra - 1)).after('<div id="palabras' + idPalabra + '" class="row mb-3"></div>') //.....
                            }
                            $('#palabras' + idPalabra).append('<div id="divPalabra' + idPalabra + '" class="col-8 offset-2"></div>'); //.......
                            $('#palabras' + idPalabra).append('<div id="divPalabr' + idPalabra + '" class="col-2"></div>'); //.......

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtPalabrasCve").val(), id: 'txtPalabrasCve' + idPalabra, disabled: 'disabled' }).appendTo('#divPalabra' + idPalabra); //....

                            $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar5 icon-trash-o', value: '', onclick: '', id: 'btnPalabras' + idPalabra }).appendTo('#divPalabr' + idPalabra);  //.......
                            //se asigna cada palabra a cada campo generado
                            $('#txtPalabrasCve' + idPalabra).val(palabra);
                        });
                    }
                    //else {
                    //    $('#txtPalabrasCve').val(arrayPalabrasClave[0]);
                    //}
                    $('#datePublicacion').val(JsonD.fechapublicacion);
                    // Dividir el campo en 2 para mandar cada info a su respectivo input
                    var arrayDescripcion = (JsonD.descripcion).split(";");
                    $('#txtDescripcion').val(arrayDescripcion[0]);
                    $('#txtDescripcionVol').val(arrayDescripcion[1]);
                    $('#txtRango').val(JsonD.rango);
                    $('#selectArbitrado option[value="' + JsonD.arbitrado + '"]').attr("selected", "selected");
                    $('#txtISBN').val(JsonD.isbn);
                    $('#txtPublicador').val(JsonD.publicador);
                    // Aquí comienza para recuperar la institución de procedencia    
                    if(JsonD.institucion.includes('ZonaCentro')){
                        $('#txtInstitucionZona option[value="ZonaCentro"]').attr("selected", "selected");
                    } else if (JsonD.institucion.includes('ZonaSur')){
                        $('#txtInstitucionZona option[value="ZonaSur"]').attr("selected", "selected");
                    } else if (JsonD.institucion.includes('ZonaNorte')){
                        $('#txtInstitucionZona option[value="ZonaNorte"]').attr("selected", "selected");
                    } else{
                        $('#txtInstitucionZona option[value=""]').attr("selected", "selected");
                    }
                    $('#txtInstitucionZona').change();
                    setTimeout(function () {                        
                        $('#txtInstitucion option[value="' + JsonD.institucion + '"]').attr("selected", "selected");                        
                    }, 1000);
                    // Aquí termina recuperar Institución de procedencia
                    $('#selectEdicion option[value="' + JsonD.edicion + '"]').attr("selected", "selected");
                    $('#txtCandidato').val(JsonD.candidato);
                    $('#txtIdentificacion').val(JsonD.patente);
                    $('#txtPaginas').val(JsonD.paginas);
                    $('#txtTiraje').val(JsonD.ejemplares);
                    $('#selectPublicacion option[value="' + JsonD.acceso + '"]').attr("selected", "selected");
                    $('#dateEmbargo').val(JsonD.fechafin);
                    // Dividir el campo según sus registros
                    var arrayProyectos = (JsonD.proyecto).split("||");
                    console.log(arrayProyectos);
                    //verificar si son uno o más registros
                    if (arrayProyectos.length > 0 && arrayProyectos[0]!='') {
                        //Recorrer el array y generar tantos inputs como registros haya
                        arrayProyectos.forEach(function (proyecto) {
                            //Se agrega valor al array que se usa para grabar
                            arrayProyecto.push(proyecto);

                            idProyecto++;
                            // se genera la estructura
                            if (idProyecto == 1) {
                                $('#proyecto').after('<div id="proyecto' + idProyecto + '" class="row mb-3"></div>') //.....
                            } else {
                                $('#proyecto' + (idProyecto - 1)).after('<div id="proyecto' + idProyecto + '" class="row mb-3"></div>') //.....
                            }
                            $('#proyecto' + idProyecto).append('<div id="divProyecto' + idProyecto + '" class="col-8 offset-2"></div>'); //.......
                            $('#proyecto' + idProyecto).append('<div id="divProyect' + idProyecto + '" class="col-2"></div>'); //.......

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtProyecto").val(), id: 'txtProyecto' + idProyecto, disabled: 'disabled' }).appendTo('#divProyecto' + idProyecto);    //........

                            $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar6 icon-trash-o', value: '', onclick: '', id: 'btnProyecto' + idProyecto }).appendTo('#divProyect' + idProyecto); //.......
                            //se asigna cada proyecto a cada campo generado
                            $('#txtProyecto' + idProyecto).val(proyecto);
                        });
                    }
                    //else {
                    //    $('#txtProyecto').val(arrayProyectos[0]);
                    //}
                    $('#selectFinanciamiento option[value="' + JsonD.financiamiento + '"]').attr("selected", "selected");
                    $('#txtURL').val(JsonD.url);
                    // Dividir el campo según sus registros
                    var arrayConjunto = (JsonD.datos).split("||");
                    //verificar si son uno o más registros
                    if (arrayConjunto.length > 0 && arrayConjunto[0]!='') {
                        //Recorrer el array y generar tantos inputs como registros haya
                        arrayConjunto.forEach(function (conjunto) {
                            //Se agrega valor al array que se usa para grabar
                            arrayDatos.push(conjunto);

                            idDatos++;
                            // se genera la estructura
                            if (idDatos == 1) {
                                $('#conjunto').after('<div id="conjunto' + idDatos + '" class="row mb-3"></div>') //.....
                            } else {
                                $('#conjunto' + (idDatos - 1)).after('<div id="conjunto' + idDatos + '" class="row mb-3"></div>') //.....
                            }
                            $('#conjunto' + idDatos).append('<div id="divDatos' + idDatos + '" class="col-8 offset-2"></div>'); //.......
                            $('#conjunto' + idDatos).append('<div id="divDatosRel' + idDatos + '" class="col-2"></div>'); //.......

                            $('<input/>').attr({ type: 'text', class: 'form-control', value: $("#txtDatos").val(), id: 'txtDatos' + idDatos, disabled: 'disabled' }).appendTo('#divDatos' + idDatos); //..........

                            $('<button>').attr({ type: 'button', class: 'btn btn-danger eliminar7 icon-trash-o', value: '', onclick: '', id: 'btnDatos' + idDatos }).appendTo('#divDatosRel' + idDatos); //........
                            //se asigna cada conjunto de datos a cada campo generado
                            $('#txtDatos' + idDatos).val(conjunto);
                        });
                    }
                    //else {
                    //    $('#txtDatos').val(arrayConjunto[0]);
                    //}

                    setTimeout(function myfunction() {
                        $('#areacon option[value="' + JsonD.area + '"]').attr("selected", "selected");
                        $('#selectAudiencia option[value="' + JsonD.audiencia + '"]').attr("selected", "selected");
                        $('#selectIdioma option[value="' + JsonD.idioma + '"]').attr("selected", "selected");
                        $('#selectPais option[value="' + JsonD.pais + '"]').attr("selected", "selected");
                        $('#selectLicencia option[value="' + JsonD.licencia + '"]').attr("selected", "selected");
                    }, 2000);

                    // activa resumen y citación para contar sus caracteres
                    $('#txtResumen').trigger("keyup");
                    $('#txtCitacion').trigger("keyup");
                }
            });
        }
    </script>
</asp:Content>

