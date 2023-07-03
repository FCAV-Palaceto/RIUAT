<%@ page title="" language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" codefile="Contacto.aspx.cs" inherits="Contacto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="content">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8 contents" style="margin: 0 auto;">
                    <div class="form-block">
                        <div class="mb-4">
                            <h3 class="mb-4">Contacto</h3>
                            <%--<form action="mailto:repositorio.fcav@uat.edu.mx" method="post" enctype="text/plain">
                                <div class="card shadow-sm">
                                    <div class="card-body">
                                        <div class="form-group row">                            
                                            <label for="name" class="col-3 col-form-label">Nombre:</label>
                                            <div class="col-9">
                                                <input class="form-control" type="text" name="name"/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="email" class="col-form-label col-3">Correo electr&oacute;nico:</label>
                                            <div class="col-9">
                                                <input class="form-control" type="email" name="email"/>
                                            </div>            
                                        </div>
                                        <div>
                                            <label for="comments">Comentarios:</label>
                                            <br />
                                            <textarea class="form-control" name="comments" rows="8" placeholder="Envíanos tus comentarios"></textarea>
                                        </div>
                                        <div>
                                            <input type="submit" name="submit" value="Send"/>
                                            <input type="reset" name="reset" value="Clear Form" />
                                        </div>
                                    </div>
                                </div>
                            </form> --%>

                            <!--Nuevo Formulario-->
                            <form name="form2" action="javascript:MailTextarea(form2.comments.value,form2.name.value,form2.email.value)">
                                <div class="card shadow-sm">
                                    <div class="card-body">
                                        <div class="form-group row">                            
                                            <label for="name" class="col-3 col-form-label">Nombre:</label>
                                            <div class="col-9">
                                                <input class="form-control" type="text" name="name"/>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="email" class="col-form-label col-3">Correo electr&oacute;nico:</label>
                                            <div class="col-9">
                                                <input class="form-control" type="email" name="email"/>
                                            </div>            
                                        </div>
                                        <div>
                                            <label for="comments">Comentarios:</label>
                                            <br />
                                            <textarea class="form-control mb-3" name="comments" rows="8" placeholder="Envíanos tus comentarios"></textarea>
                                        </div>
                                        <div>
                                            <input class="btn btn-pill text-white btn-primary" type="submit" name="submit" value="Send"/>
                                            <input class="btn btn-pill text-white btn-primary" type="reset" name="reset" value="Clear Form" />
                                        </div>
                                    </div>
                                </div>
                                <!--<label for="name">Nombre:
                                    <input type="text" name="input1" />
                                </label>-->
                                <!--<label for="email">Correo electr&oacute;nico:
                                    <input type="text" name="input2"" />
                                </label>-->
                                <!--<TEXTAREA name=textarea2 rows=5 ></TEXTAREA><br>-->
                                <!--<input type=submit value="mail !!" name=button2>-->
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="Scripts2" runat="Server">
    <script language="JavaScript">
        function MailTextarea(Nombre,Correo,Comentarios){
            MyAction="mailto:repositorio.fcav@uat.edu.mx?Subject=Comentarios&body=Nombre: "+ Nombre +"%0D%0ACorreo: "+ Correo +"%0D%0A%0D%0A"+ Comentarios+"%0D%0A%0D%0A";
            window.location.href = MyAction;
        }
    </script>
</asp:content>

