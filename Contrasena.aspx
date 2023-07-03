<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contrasena.aspx.cs" Inherits="Contrasena" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8 contents" style="margin: 0 auto;">
                    <div class="form-block">
                        <div class="mb-4">
                            <h3>Cambiar <strong>Contrase&ntilde;a</strong></h3>                            
                        </div>
                        
                            <div class="row col-md-8" style="margin: 0 auto;">
                                <div class="form-group col-md-12">
                                    <label for="password">Contrase&ntilde;a actual:</label>
                                    <br />
                                    <asp:textbox type="password" class="form-control" id="password" runat="server" />
                                </div>
                                <div class="form-group col-md-12 mb-4">
                                    <label for="passwordNueva">Contrase&ntilde;a nueva:</label>
                                    <br />
                                    <asp:textbox type="password" class="form-control" id="passwordNueva" runat="server" />
                                </div>
                                <div class="form-group col-md-12 mb-4">
                                    <label for="password2">Repetir contrase&ntilde;a:</label>
                                    <br />
                                    <asp:textbox type="password" class="form-control" id="passwordNueva2" runat="server" />                                                      
                                </div>

                                <div id="myDiv" class="col-md-12 mb-3" style="text-align: center; color: red;" runat="server">
                                    <asp:label text="" id="lblmsg" runat="server" />
                                </div>
                                <div class="col-md-12 mb-3">
                                    <asp:button class="btn btn-pill text-white btn-block btn-primary" id="btnsend" text="Actualizar Contrase&ntilde;a" runat="server" onclick="btnsend_Click" />
                                </div>                                
                            </div>
                            <div class="col-md-12 mb-3 mt-3 ">
                                <span class="ml-auto"><a href="Inicio.aspx" class="forgot-pass"><b>< Volver</b></a></span>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Scripts2" Runat="Server">
</asp:Content>

