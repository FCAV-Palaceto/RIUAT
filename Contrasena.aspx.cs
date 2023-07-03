using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Contrasena : System.Web.UI.Page
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

        Session["returnPath"] = Request.RawUrl;
    }

    protected void btnsend_Click(object sender, EventArgs e)
    {
        myDiv.Attributes.CssStyle.Add("color", "red");
        string pass = password.Text;
        string passNueva = passwordNueva.Text;
        string passNueva2 = passwordNueva2.Text;

        int idUsuario = Convert.ToInt32(HttpContext.Current.Session["idusuario"]), activo;

        if (pass == "" || passNueva == "" || passNueva2 == "")
        {
            lblmsg.Text = "¡Porfavor ingrese una contraseña!";
        }
        else if (passNueva != passNueva2)
        {
            lblmsg.Text = "La contraseña nueva no coincide";
        }
        else if (pass == passNueva || pass == passNueva2)
        {
            lblmsg.Text = "La contraseña nueva no puede ser la misma que la anterior";
        }
        else
        {
            using (SqlConnection Conn = conn.Conecta())
            {
                using (SqlCommand comand = new SqlCommand("CambiarContrasena", Conn))
                {
                    comand.CommandType = CommandType.StoredProcedure;
                    comand.Parameters.AddWithValue("@idusuario", idUsuario);
                    comand.Parameters.AddWithValue("@pass", pass);
                    comand.Parameters.AddWithValue("@passnueva", passNueva);

                    SqlParameter prmActivo = new SqlParameter("@activo", SqlDbType.Int);
                    prmActivo.Direction = ParameterDirection.Output;
                    comand.Parameters.Add(prmActivo);

                    Conn.Open();
                    comand.ExecuteNonQuery();

                    activo = Convert.ToInt32(prmActivo.Value is DBNull ? 0 : prmActivo.Value);

                    if (activo == 1)
                    {
                        myDiv.Attributes.CssStyle.Add("color", "green");
                        lblmsg.Text = "Contraseña actualizada correctamente";
                        password.Text = "";
                        passwordNueva.Text = "";
                        passwordNueva2.Text = "";
                    }
                    else
                    {
                        lblmsg.Text = "¡La contraseña es incorrecta!";
                    }
                }
                Conn.Close();
            }
        }
    }

    
}