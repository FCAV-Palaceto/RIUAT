using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class Licencia : System.Web.UI.Page
{
    string tipoUsu;
    protected void Page_Load(object sender, EventArgs e)
    {
        tipoUsu = Convert.ToString(HttpContext.Current.Session["tipoUsu"]);
        // Si no existe sesión regresa al login
        if (tipoUsu.Equals(""))
        {
            HttpContext.Current.Response.Redirect("~/");
        }

        //Permisos de cada usuario para ver las pantallas
        if (!(tipoUsu.Equals("0")))
        {
            HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        }

        // Crea la ruta de la página que está
        Session["returnPath"] = Request.RawUrl;
    }


    [WebMethod]
    public static string EnviaProducto()
    {
        int id = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
        int estado = 1;
        int Exitoso = 0;

        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("Estado", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.AddWithValue("@id", id);                
                comand.Parameters.AddWithValue("@estado", estado);
                comand.Parameters.AddWithValue("@fecha", "null");

                SqlParameter pexitoso = new SqlParameter("@Exitoso", SqlDbType.Int);
                pexitoso.Direction = ParameterDirection.Output;
                comand.Parameters.Add(pexitoso);

                Conn.Open();
                comand.ExecuteNonQuery();

                Exitoso = Convert.ToInt32(pexitoso.Value);
            }
            Conn.Close();
            return "{\"success\": \"" + Exitoso + "\"}"; 
        }
    }
}