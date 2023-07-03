<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8 contents" style="margin: 0 auto;">
                    <div class="form-block">
                        <div class="mb-4">
                            <h3>Iniciar <strong>Sesión</strong></h3>
                            <span>Introduzca su direcci&oacute;n de correo electr&oacute;nico o nombre de usuario y su contrase&ntilde;a:</span>
                        </div>

                            <div class="row col-md-8" style="margin: 0 auto;margin-bottom:150px;">
                                <div class="form-group col-md-12">
                                    <label for="correo">Correo:</label>
                                    <br />
                                    <asp:textbox type="text" class="form-control" id="correo" runat="server" />
                                </div>
                                <div class="form-group col-md-12 mb-4">
                                    <label for="password">Contraseña:</label>
                                    <br />
                                    <asp:textbox type="password" class="form-control" id="password" runat="server" />
                                </div>

                                <div class="col-md-12 mb-3 ">
                                    <span class="ml-auto"><a href="Restablecer.aspx" class="forgot-pass"><b>¿Olvidó su contrase&ntilde;a?</b></a></span>
                                    <span id="lre" class="ml-auto" style="float:right;"><a href="Registro.aspx" class="forgot-pass"><b>Registrarse</b></a></span>
                                </div>
                                <div class="col-md-12 mb-3" style="text-align: center; color: red;">
                                    <asp:label text="" id="lblmsg" runat="server" />
                                </div>
                                <div class="col-md-12 mb-3">
                                    <asp:button class="btn btn-pill text-white btn-block btn-primary" id="btnsend" text="Iniciar Sesión" runat="server" OnClick="btnsend_Click" />
                                </div>
                            </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function Enviar() {
            window.location.href = "Inicio.aspx"
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts2" Runat="Server">
</asp:Content>

