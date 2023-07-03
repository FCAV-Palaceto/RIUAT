<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Alta.aspx.cs" Inherits="Alta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/PNotifyBrightTheme.css" rel="stylesheet" />

    <script src="js/PNotify/PNotify.js"></script>    
    <script src="js/PNotify/PNotifyMobile.js"></script>  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%-- DataTables --%>
    <link href="DataTables-1.12.1/datatables.min.css" rel="stylesheet" />
    <div class="content">
        <div class="container">
            <div class="row aling-items-center">
                <div class="col-md-10 contents" style="margin: 0 auto;">
                    <div class="form-block">
                        <div class="md-4">
                            <h3>Alta de <strong>Usuario</strong></h3>
                        </div>
                        <div>
                            <form action="#" method="post">
                                <div class="col-md-12 row">
                                    <input type="text" class="form-control" id="txtidUsu" hidden value="0"/>
                                    <div class="form-group col-md-6">
                                        <label for="txtnombre">Nombre(s):</label>
                                        <input type="text" class="form-control" id="txtnombre"/>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="txtpaterno">Apellido Paterno: </label>
                                        <input type="text" class="form-control" id="txtpaterno"/>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="txtmaterno">Apellido Paterno: </label>
                                        <input type="text" class="form-control" id="txtmaterno"/>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="txtcorreo">Correo Electrónico: </label>
                                        <input type="text" class="form-control" id="txtcorreo"/>
                                        <a id='resultado'></a>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="txtcon">Contraseña: </label>
                                        <input type="password" class="form-control" id="txtcon">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="txtcon">Tipo de Usuario: </label>
                                        <select class="form-control" id="tipousuario">
                                            <option value ="">-- Seleccione el tipo de usuario --</option>
                                            <option value="0">Usuario general</option>
                                            <option value="1">Administrador</option>
                                        </select>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-3" style="float: right;">
                                            <input type="button" value="Registrar" onclick="Registrar();" class="btn btn-pill text-white btn-block btn-primary"/>
                                        </div>
                                    </div>
                                    <div class="col-md-12 mt-5 letra" id="tablausuarios"></div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- Eliminar -->
                    <div class="modal fade bd-modal-del" id="modaldel" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title h4" id="myLargeModalLabel21">ELIMINAR USUARIO</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                                <div class="modal-body">
                                    <h3>¿Está seguro de eliminar el usuario?</h3>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn  btn-success eliminar" data-dismiss="modal" style="float: right; margin-left: 5px;">Confirmar</button>
                                    <button type="button" class="btn  btn-secondary" data-dismiss="modal" style="float: right;">Cancelar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts2" Runat="Server">
<%-- DataTables --%>   
    <script src="DataTables-1.12.1/datatables.min.js"></script>
    <script>
        window.onload = function () {
            TablaUsu();
        }

        function TablaUsu() {  //aqui se crea la tabla
            $.ajax({
                type: 'POST',
                url: 'Alta.aspx/TablaUsuarios',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (tabla) {
                    $("#tablausuarios").html(tabla.d); //nombre del id del div de la tabla
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
                "order": [[0, 'desc'], [2, 'asc'], [3, 'asc']],
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

        function EstadoUsuario(ctrl) {
            var idUsu = ctrl;
            $.ajax({
                type: 'POST',
                url: 'Alta.aspx/EstadoUsu',
                data: "{'id':'" + idUsu + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        PNotify.success({
                            text: 'Se desactivo el usuario correctamente.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                        TablaUsu();
                    }
                    else if (JsonD.success == 2) {
                        PNotify.success({
                            text: 'Se activo el usuario correctamente.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                        TablaUsu();
                    }
                }
            });
        }

        function ConfirmarEliminar(ctrl) {
            $("#modaldel").modal('show');
            var id = ctrl;
            $(".eliminar").attr("id", "" + id + "");
            $(".eliminar").attr("onclick", "EliminarUsuario(" + id + ");");
        }

        function EliminarUsuario(id) {
            var id2 = id;
            $.ajax({
                type: 'POST',
                url: 'Alta.aspx/EliminarUsu',
                data: "{'id':'" + id2 + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        PNotify.success({
                            text: 'El usuario se elimino correctamente.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                        TablaUsu();
                    } else
                        if (JsonD.success == 2) {
                            PNotify.info({
                                text: 'No se puede eliminar el usuario.',
                                delay: 4000,
                                addClass: 'translucent'
                            });
                        }
                }
            });
        }

        function Registrar() {
            var idUsu = $('#txtidUsu').val();
            var Nombre = $('#txtnombre').val();
            var ApellidoP = $('#txtpaterno').val();
            var ApellidoM = $('#txtmaterno').val();
            var Correo = $('#txtcorreo').val();
            var Contrasena = $('#txtcon').val();
            var tipo = $('#tipousuario').val();  
            var regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;        

            if(Nombre == ''|| ApellidoP == ''|| ApellidoM == ''|| Correo == ''|| Contrasena == '' || tipo == ''){                
                PNotify.info({
                    text: 'Por favor completa los campos.',
                    delay: 4000,
                    addClass: 'translucent'
                });
                return;
            }
           
            if (!regex.test(Correo)) {
                document.getElementById("resultado").innerHTML="<div class=\"alert alert-danger\" role=\"alert\">Ingrese un <strong>CORREO</strong> valido</div>"
                //alert('Ingrese un correo Valido');
                return;
            }

            /*if ($('#txtcorreo')[0].checkValidity()){
                var Correo = $('#txtcorreo').val();
            } else{
                $('#txtcorreo')[0].reportValidity();
                return;
            }*/

            var obj = {};
            obj.Nombre = Nombre;
            obj.ApellidoP = ApellidoP;
            obj.ApellidoM = ApellidoM;
            obj.Correo = Correo;
            obj.Contrasena = Contrasena;
            obj.Tipo = tipo;
            obj.id = idUsu;

            if (idUsu == 0) {
                var url = 'Alta.aspx/Registrar';
            }
            else {
                var url = 'Alta.aspx/ActualizarUsu';
            }
            
            $.ajax({
                type: 'POST',
                url: url,
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        PNotify.info({
                            text: 'El correo ya existe, porfavor intente con otro.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                    }
                    else if (JsonD.success == 2) {
                        PNotify.success({
                            text: 'Registro exitoso.',
                            delay: 4000,
                            addClass: 'translucent'
                        });

                        //correo(Nombre, ApellidoP, ApellidoM, Correo, Contrasena);
                        Limpia();
                        $('#txtcon').prop("readonly", false);
                        TablaUsu();
                    }
                }
            });
        }

        //Trae los datos para modificar los usuarios
        function ModificarUsuario(ctrl) {
            var id = ctrl;
            $.ajax({
                type: 'POST',
                url: 'Alta.aspx/ModUsu',
                data: "{'id':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                }, success: function (informacion) {
                    var jsonD = $.parseJSON(informacion.d);
                    $('#txtidUsu').val(id);
                    $('#txtnombre').val(jsonD.Nombre);
                    $('#txtpaterno').val(jsonD.Paterno);
                    $('#txtmaterno').val(jsonD.Materno);
                    $('#txtcorreo').val(jsonD.Correo);
                    $('#txtcon').val("*****");
                    $('#txtcon').prop("readonly", true);
                    $('#tipousuario').val(jsonD.Tipo);

                }
            });
        }

        function correo(Nombre, ApellidoP, ApellidoM, Correo, Contrasena) {
            var obj = {};
            obj.Nombre = Nombre;
            obj.ApellidoP = ApellidoP;
            obj.ApellidoM = ApellidoM;
            obj.Correo = Correo;
            obj.Contrasena = Contrasena;

            $.ajax({
                type: 'POST',
                url: 'Alta.aspx/EnviarCorreo',
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        PNotify.success({
                            text: 'Fue enviado un correo.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                    } else {
                        PNotify.info({
                            text: 'Hubo un error en el envio del correo.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                    }
                }
            });
        }

        function Limpia() {
            $('#txtidUsu').val('');
            $('#txtnombre').val('');
            $('#txtpaterno').val('');
            $('#txtmaterno').val('');
            $('#txtcorreo').val('');
            $('#txtcon').val('');
            $('#txtrecon').val('');
        }
    </script>
</asp:Content>

