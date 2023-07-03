using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class MasterPage : System.Web.UI.MasterPage
{
    public string nombreUsu, textourl, textourl2, url, url2, usuarioexiste, usuario, correo, url3;
    protected void Page_Load(object sender, EventArgs e)
    {
        nombreUsu = Convert.ToString(HttpContext.Current.Session["nombreUsu"]);
        correo = Convert.ToString(HttpContext.Current.Session["correo"]);
        if (nombreUsu.Equals("")){
            textourl = "Iniciar Sesión";
            textourl2 = "Registrarse";
            url = "Login.aspx";
            url2 = "Registro.aspx";
            usuarioexiste = "";
            usuario = "";
        }
        else if(Convert.ToString(HttpContext.Current.Session["tipoUsu"]).Equals("1") /*|| Convert.ToString(HttpContext.Current.Session["tipoUsu"]).Equals("2")*/)
        {
            textourl = "Mis Tareas";
            textourl2 = "Cerrar Sesión";
            url = "Tareas.aspx";
            url2 = "Logout.aspx";            
            usuarioexiste = "<a class=\"dropdown-item text-decoration-none\" href=\"Contrasena.aspx\">Cambiar contrase&ntilde;a</a><div class=\"dropdown-divider\"></div><a href=\"Logout.aspx\" class=\"dropdown-item forgot-pass text-decoration-none\"><b><i class=\"icon-power-off mr-2\"></i>Cerrar Sesión</b></a>";
            usuario = "<div class=\"pr-2\" style=\"font-size: small; color: #BBBBBB; padding-left: 19.2px; \">Usuario conectado:</div><div class=\"pr-2 mb-2\" style=\"font-size: small; font-weight: bold; padding-left: 19.2px;\">" + correo + "</div>";            
        }else if(Convert.ToString(HttpContext.Current.Session["tipoUsu"]).Equals("2")){
            textourl = "Mis Tareas";
            textourl2 = "Cerrar Sesión";
            url = "Tareas.aspx";
            url2 = "Logout.aspx";
            url3 = "https://riuat.uat.edu.mx/password-login";
            usuarioexiste = "<a class=\"dropdown-item text-decoration-none\" href=\"Exportar.aspx\">Exportar metadatos</a><a class=\"dropdown-item text-decoration-none\" href=\"Alta.aspx\">Alta de Usuario</a><a class=\"dropdown-item text-decoration-none\" href=\"Contrasena.aspx\">Cambiar contrase&ntilde;a</a><div class=\"dropdown-divider\"></div><a class=\"dropdown-item text-decoration-none\" href=\"" + url3 + "\">Administrar Dspace</a><a href=\"Logout.aspx\"class=\"dropdown-item forgot-pass text-decoration-none\"><b><i class=\"icon-power-off mr-2\"></i>Cerrar Sesión</b></a>";
            usuario = "<div class=\"pr-2\" style=\"font-size: small; color: #BBBBBB; padding-left: 19.2px;\">Usuario conectado:</div><div class=\"pr-2 mb-2\" style=\"font-size: small; font-weight: bold; padding-left: 19.2px;\">" + correo + "</div>";
        }
        else
        {
            textourl = "Mis Envíos";
            textourl2 = "Cerrar Sesión";
            url = "Inicio.aspx";
            url2 = "Logout.aspx";
            usuarioexiste = "<a class=\"dropdown-item text-decoration-none\" href=\"Contrasena.aspx\">Cambiar contrase&ntilde;a</a><div class=\"dropdown-divider\"></div><a href=\"Logout.aspx\" class=\"dropdown-item forgot-pass text-decoration-none\"><b><i class=\"icon-power-off mr-2\"></i>Cerrar Sesión</b></a>";
            usuario = "<div class=\"pr-2\" style=\"font-size: small; color: #BBBBBB; padding-left: 19.2px;\">Usuario conectado:</div><div class=\"pr-2 mb-2\" style=\"font-size: small; font-weight: bold; padding-left: 19.2px;\">" + correo + "</div>";
        }
    }
}
