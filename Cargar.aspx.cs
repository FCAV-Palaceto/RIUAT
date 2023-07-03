using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Cargar : System.Web.UI.Page
{   
    public string idProducto, tipoUsu;
    protected void Page_Load(object sender, EventArgs e)
    {
        idProducto = Convert.ToString(HttpContext.Current.Session["idproducto"]);
        this.Form.Enctype = "Multipart/Form-Data";

        tipoUsu = Convert.ToString(HttpContext.Current.Session["tipoUsu"]);
        // Si no existe sesión regresa al login
        if (tipoUsu.Equals(""))
        {
            HttpContext.Current.Response.Redirect("~/");
        }

        // Permisos de cada usuario para ver las pantallas
        if (!(tipoUsu.Equals("0")))
        {
            HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        }

        // Crea la ruta de la página que está
        Session["returnPath"] = Request.RawUrl;
    }
}