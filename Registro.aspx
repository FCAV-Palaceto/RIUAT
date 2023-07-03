<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Registro.aspx.cs" Inherits="Registro" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/PNotifyBrightTheme.css" rel="stylesheet" />

    <script src="js/PNotify/PNotify.js"></script>    
    <script src="js/PNotify/PNotifyMobile.js"></script>  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-10 contents" style="margin: 0 auto;">
                    <div class="form-block">
                        <div class="mb-4">
                            <h3>Registro de <strong>Usuario</strong></h3>
                        </div>
                        <form action="#" method="post">
                            <div class="col-md-12 row">
                                <div class="form-group col-md-6">
                                    <label for="txtnombre">Nombre(s)<span class="text-danger">*</span>:</label>
                                    <input type="text" class="form-control" id="txtnombre" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="txtpaterno">Apellido Paterno<span class="text-danger">*</span>:</label>
                                    <input type="text" class="form-control" id="txtpaterno" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="txtmaterno">Apellido Materno<span class="text-danger">*</span>:</label>
                                    <input type="text" class="form-control" id="txtmaterno" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="txtcorreo">Correo Electrónico<span class="text-danger">*</span>:</label>
                                    <input type="email" class="form-control" id="txtcorreo" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="txtcorreo">Confirmar Correo Electrónico<span class="text-danger">*</span>:</label>
                                    <input type="email" class="form-control" id="txtcorreo2" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="txtcon">Contraseña<span class="text-danger">*</span>:</label>
                                    <input type="password" class="form-control" id="txtcon" />
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="txtrecon">Confirmar Contraseña<span class="text-danger">*</span>:</label>
                                    <input type="password" class="form-control" id="txtrecon" />
                                </div>
                                <div class="col-md-12">
                                    <div class="col-auto text-center alert alert-danger" style="display:none;" role="alert" id="alerta"></div>
                                    <div class="col-auto text-center alert alert-success" style="display:none;" role="alert" id="alerta2"></div>
                                </div>
                                <div class="col-md-12">
                                    <small class="text-danger">* campos obligatorios</small>
                                    <div class="col-md-3" style="float:right;">
                                        <input type="button" value="Registrarse" onclick="Registrarse();" class="btn btn-pill text-white btn-block btn-primary"/>
                                    </div>
                                </div>                                
                                <div class="form-group col-md-12 mt-5">
                                    <span class="ml-auto"><a href="Login.aspx" class="forgot-pass" style="float:right;"><b>Iniciar Sesión</b></a></span>
                                </div>
                                <div class="mb-3" style="text-align:center;color:red;">
                                    <asp:label text="" runat="server" />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts2" Runat="Server">
    <script>
        window.onload = function () {
            
        }

        function Registrarse() {
            if ($('#txtcorreo')[0].checkValidity()){
                var Correo = $('#txtcorreo').val();
            } else{
                $('#txtcorreo')[0].reportValidity();
                return;
            }

            if (!($('#txtcorreo2')[0].checkValidity())){
                $('#txtcorreo2')[0].reportValidity();
                return;
            }

            if ($('#txtcorreo').val() != $('#txtcorreo2').val()){
                $('#alerta').show();
                $('#alerta').html("Los correos electrónicos proporcionados no coinciden.");
                return;
            }

            var Nombre = $('#txtnombre').val();
            var ApellidoP = $('#txtpaterno').val();
            var ApellidoM = $('#txtmaterno').val();
            var Contrasena = $('#txtcon').val();
            var ReContrasena = $('#txtrecon').val();

            if (Nombre == '' || ApellidoP == '' || ApellidoM == '' || Correo == '' || Contrasena == '' || ReContrasena == '') {
                $('#alerta').show();
                $('#alerta').html("Por favor, complete todos los campos.");
                return;
            }

            //if (Contrasena != ReContrasena) {
            //    alert('Las contraseñas no coinciden.');
            //    return;
            //}

            if (Contrasena != ReContrasena) {
                $('#alerta').show();
                $('#alerta').html("Las contraseñas introducidas no coinciden.");
                return;
            }

            var obj = {};
            obj.Nombre = Nombre;
            obj.ApellidoP = ApellidoP;
            obj.ApellidoM = ApellidoM;
            obj.Correo = Correo;
            obj.Contrasena = Contrasena;
            obj.ReContrasena = ReContrasena;

            $.ajax({
                type: 'POST',
                url: 'Registro.aspx/Guardar',
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d)
                    if (JsonD.success == 1) {
                        $('#alerta').show();
                        $('#alerta').html("Este correo electrónico ya se encuentra registrado.");
                    }
                    else if (JsonD.success == 2) {
                        $('#alerta').hide();
                        $('#alerta2').show();
                        $('#alerta2').html("Registro Exitoso.");
                        correo(Nombre, ApellidoP, ApellidoM, Correo, Contrasena);
                        Limpia();
                        setTimeout(function () {
                            $('#alerta2').hide();
                        }, 4002);
                    }
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
                url: 'Registro.aspx/EnviarCorreo',
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d);
                    if (JsonD.success == 1) {
                        //alert('Fue enviado un email!!');
                        PNotify.success({
                            //title: 'Producto Eliminado',
                            text: 'Fue enviado un correo electrónico. En breve será redirigido a la página de inicio de sesión.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                        setTimeout(function () {
                            window.location.href = "Login.aspx";
                        }, 4001);
                    } else {
                        //alert('Hubo un error en el envio del email!!')
                        PNotify.success({
                            //title: 'Producto Eliminado',
                            text: 'Ocurrió un error al enviar el correo electrónico.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                    }
                }
            });
        }

        function Limpia() {
            $('#txtnombre').val('');
            $('#txtpaterno').val('');
            $('#txtmaterno').val('');
            $('#txtcorreo').val('');
            $('#txtcorreo2').val('');
            $('#txtcon').val('');
            $('#txtrecon').val('');
        }
    </script>
</asp:Content>

