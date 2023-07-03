<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" codefile="Restablecer.aspx.cs" inherits="Restablecer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/PNotifyBrightTheme.css" rel="stylesheet" />

    <script src="js/PNotify/PNotify.js"></script>    
    <script src="js/PNotify/PNotifyMobile.js"></script>    
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="content">
        <div class="container">
            <div class="row aling-items-center">
                <div class="col-md-8 contents" style="margin: 0 auto;">
                    <div class="form-block">
                        <div class="mb-4">
                            <h3>Recuperar <strong>Contraseña</strong></h3>
                        </div>
                        <form action="#" method="post">
                            <div class="col-md-8 row" style="margin:auto;">
                                <div class="form-group col-md-12 mb-4">
                                    <label for="Correo">Introduzca su correo electr&oacute;nico: </label>
                                    <input type="text" class="form-control" id="Correo"/>
                                    <small>-Si el correo existe se le enviar&aacute; su contraseña a su correo.-</small>
                                    <a id='resultado'></a>
                                </div>
                                <div class="col-md-12" >
                                    <input type="button" value="Validar" onclick="Validar();" class="btn btn-pill text-white btn-block btn-primary"/>
                                </div>
                                <div class="col-md-12 mt-3 ">
                                    <span class="ml-auto"><a href="Login.aspx" class="forgot-pass"><b>< Volver</b></a></span>
                            </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="Scripts2" runat="Server">
    <script>
        window.onload = function () {

        }

        function Validar() {
            var Correo = $('#Correo').val();
            var regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;  

            if (Correo == '') {
                alert('Por favor coloque un correo');
                return;
            }

            if (!regex.test(Correo)) {
                document.getElementById("resultado").innerHTML="<div class=\"alert alert-danger\" role=\"alert\">Ingrese un <strong>CORREO</strong> valido</div>"
                //alert('Ingrese un correo Valido');
                return;
            }

            $.ajax({
                type: 'POST',
                url: 'Restablecer.aspx/Validar',
                data: "{'Correo':'" + Correo + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error" + jqXHR.responseText);
                },
                success: function (valor) {
                    var JsonD = $.parseJSON(valor.d);
                    if (JsonD.success == 1) {
                        //alert('Recibira un email en un par de minutos');
                        PNotify.info({
                            //title: 'Producto Eliminado',
                            text: 'En breve recibirá un correo electrónico en la dirección proporcionada.',
                            delay: 4000,
                            addClass: 'translucent'
                        });
                        $('#Correo').val("");
                        setTimeout(function () {
                            window.location.href = 'Login.aspx';
                        }, 4001);
                    } else {
                        document.getElementById("resultado").innerHTML = "<div class=\"alert alert-danger\" role=\"alert\">El correo electrónico ingresado no ha sido registrado</div>";
                    }
                }
            });
        }

        function Limpia() {
            $('#Correo');
        }
    </script>
</asp:content>

