<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" codefile="Licencia.aspx.cs" inherits="Licencia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/PNotifyBrightTheme.css" rel="stylesheet" />

    <script src="js/PNotify/PNotify.js"></script>    
    <script src="js/PNotify/PNotifyMobile.js"></script> 
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <h1 class="mb-3">Formulario de Captura</h1>
        <p><strong>No conceder la licencia no borrará su envío.</strong> Su producto académico permanecerá en su página "Mis Envíos ". Usted puede borrar el producto académico del sistema o mostrar su acuerdo con la licencia más tarde.</p>
        
        <div class="card w-75 text-justify mx-auto border-info mb-3 scroll">
            <div class="card-body">
                <h5 class="card-title font-weight-bold text-center">
                    AUTORIZACIÓN PARA LA DIVULGACIÓN EN EL REPOSITORIO INSTITUCIONAL DE LA UNIVERSIDAD AUTÓNOMA DE TAMAULIPAS. <br><br>LICENCIA CESIÓN DE DERECHOS A LA UNIVERSIDAD AUTÓNOMA DE TAMAULIPAS PARA LA PUBLICACIÓN EN EL REPOSITORIO INSTITUCIONAL (RIUAT)
                </h5>
                <br />
                <div class="card-text" id="licencia">     
                    <p>
                        En mi calidad de autor(a) de esta obra académica, expreso mi conformidad de <b>AUTORIZAR</b> la divulgación, publicación, la comunicación pública y circulación del trabajo antes mencionado, a la <b>UNIVERSIDAD AUTÓNOMA DE TAMAULIPAS</b>, y a su repositorio institucional (RIUAT) en forma gratuita y de forma no exclusiva.
                    </p> 
                    <p>
                        Como autor (a), manifiesto mi consentimiento y autorizo para que el RIUAT:
                    </p>
                    <ul>
                        <li class="ml-4">Mantenga más de una copia de la obra con fines de seguridad, respaldo y conservación;</li>
                        <li class="ml-4">Formule un resumen de la obra, en formato electrónico y en cualquier medio, incluyendo, pero no limitado a audio o video.</li>
                    </ul>
                    <p>
                        Así mismo, declaro bajo protesta de decir verdad, que el contenido de la obra es académico-científico y manifiesto que es de mi autoría y de original creación siendo el propietario de los derechos de autor, reconozco que, de no ser así, me hago responsable de las consecuencias legales a las que haya lugar, declarando a la UAT libre de toda responsabilidad sobre el contenido de la obra y que el RIUAT no se hace responsable si se violan los derechos de autor del archivo almacenado en él.
                    </p>
                    <p>
                        Manifiesto conocer las <b>POLÍTICAS DE USO Y PRIVACIDAD</b>, para el tratamiento de datos personales proporcionados, de igual forma, manifiesto conocer el <b>CÓDIGO DE ÉTICA Y CONDUCTA</b> de la Universidad Autónoma de Tamaulipas.
                    </p>      
                </div>
                <div class="card-text" id="licencia2">
                    <p>
                        En mi calidad de primer autor(a) de la obra académica colectiva presentada, expreso mi conformidad y manifiesto que tengo poder amplio por los demás autores para <b>AUTORIZAR</b> la divulgación, publicación, la comunicación pública y circulación del trabajo antes mencionado, a la <b>UNIVERSIDAD AUTÓNOMA DE TAMAULIPAS</b>, y a su repositorio institucional (RIUAT) en forma gratuita y de forma no exclusiva, lo anterior
                    </p>
                    <p>
                        Como primer autor (a) y representante legal de los coautores (as) por mi conducto, manifestamos nuestro consentimiento de autorizar para que el RIUAT:
                    </p>
                    <ul>
                        <li class="ml-4">Mantenga más de una copia de la obra con fines de seguridad, respaldo y conservación;</li>
                        <li class="ml-4">Formule un resumen de la obra, en formato electrónico y en cualquier medio, incluyendo, pero no limitado a audio o video.</li>
                    </ul>
                    <p>
                        Así mismo, declaramos bajo protesta de decir verdad, que el contenido de la obra es académico-científico y manifiesto que es una obra colectiva de original creación siendo uno de los propietarios de los derechos de autor, reconozco que, de no ser así, me hago responsable de las consecuencias legales a las que haya lugar, declarando a la UAT libre de toda responsabilidad sobre el contenido de la obra y que el RIUAT no se hace responsable si se violan los derechos.
                    </p>
                    <p>
                        Manifestamos conocer las <b>POLÍTICAS DE USO Y PRIVACIDAD</b>, para el tratamiento de datos personales proporcionados, de igual forma, conocer el <b>CÓDIGO DE ÉTICA Y CONDUCTA</b> de la Universidad Autónoma de Tamaulipas.
                    </p>
                </div>
            </div>
        </div>
        
         <div class="form-group text-center">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="licenciaCheck" name="licenciaCheck" required/>
                <label class="form-check-label" for="licenciaCheck">
                    He le&iacute;do y acepto la licencia de distribuci&oacute;n
                </label>
            </div>
        </div>

        <div class="text-center">
            <div class="row">
                <button class="btn btn-light border col-md-2 col-3 offset-md-3 offset-2" type="button" onclick="window.location.href = 'Inicio.aspx'">No Acepto</button>
                <button id="aceptarLicencia" class="btn btn-light border col-md-2 col-3 offset-md-2 offset-2" type="button" onclick="enviaProducto()" disabled="disabled">Acepto</button>
            </div>            
        </div>
    </div>   
    
    <script>
        window.onload = function () {
            //para ajustar el texto de la licencia
            console.log(sessionStorage.getItem("cantAutores"));
            if (sessionStorage.getItem("cantAutores") > 1) {
                $('#licencia').hide();
            } else {   
                $('#licencia2').hide();
            }
        }

        var checkbox = document.querySelector("input[name=licenciaCheck]");

        checkbox.addEventListener('change', function () {
            if (this.checked) {
                document.getElementById("aceptarLicencia").disabled = false;
            } else {
                document.getElementById("aceptarLicencia").disabled = true;
            }
        });

        function enviaProducto() {
            $.ajax({
                type: 'POST',
                url: 'Licencia.aspx/EnviaProducto',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("Error- Status: " + "jqXHR Status: " + jqXHR.Status + "jqXHR Response Text:" + jqXHR.responseText);
                },
                success: function (cadena) {
                    var JsonD = $.parseJSON(cadena.d);
                    if (JsonD.success == 3) {
                        PNotify.success({
                            //title: false,
                            text: 'Producto enviado correctamente.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                        //alert("Producto enviado correctamente");
                        setTimeout(function () {
                            window.location.href = "Inicio.aspx";
                        }, 3001);
                    } else {
                        PNotify.notice({
                            //title: false,
                            text: 'Ocurrió un error, favor de volver a intentarlo más tarde.',
                            delay: 3000,
                            addClass: 'translucent'
                        });
                    }
                }
            });
        };
    </script> 
</asp:content>

