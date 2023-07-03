using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    string tipoUsu;
    protected void Page_Load(object sender, EventArgs e)
    {
        tipoUsu = Convert.ToString(HttpContext.Current.Session["tipoUsu"]);
        // Si existe sesión regresa al la página anterior
        if (tipoUsu.Equals("0"))
        {
            Response.Redirect("Inicio.aspx");
        }
        else if (tipoUsu.Equals("1") || tipoUsu.Equals("2"))
        {
            Response.Redirect("Tareas.aspx");
        }
    }
    protected void btnsend_Click(object sender, EventArgs e)
    {
        string user = correo.Text;
        string pass = password.Text;

        int idUsuario, activo, tipousu;
        string nombre = "";

        if (user == "" || pass == "")
        {
            lblmsg.Text = "¡Porfavor ingrese un correo y una contraseña!";
        }
        else
        {
            using (SqlConnection Conn = conn.Conecta())
            {
                using (SqlCommand comand = new SqlCommand("Sesion", Conn))
                {
                    comand.CommandType = CommandType.StoredProcedure;
                    comand.Parameters.AddWithValue("@correo", user);
                    comand.Parameters.AddWithValue("@pass", pass);

                    SqlParameter prmIdUsuario = new SqlParameter("@id", SqlDbType.Int);
                    prmIdUsuario.Direction = ParameterDirection.Output;
                    comand.Parameters.Add(prmIdUsuario);

                    SqlParameter prmNombre = new SqlParameter("@nombre", SqlDbType.NVarChar, 50);
                    prmNombre.Direction = ParameterDirection.Output;
                    comand.Parameters.Add(prmNombre);

                    SqlParameter prmActivo = new SqlParameter("@activo", SqlDbType.Int);
                    prmActivo.Direction = ParameterDirection.Output;
                    comand.Parameters.Add(prmActivo);

                    SqlParameter prmUsuario = new SqlParameter("@tipo", SqlDbType.Int);
                    prmUsuario.Direction = ParameterDirection.Output;
                    comand.Parameters.Add(prmUsuario);

                    Conn.Open();
                    comand.ExecuteNonQuery();

                    idUsuario = Convert.ToInt32(prmIdUsuario.Value);
                    activo = Convert.ToInt32(prmActivo.Value);
                    nombre = Convert.ToString(prmNombre.Value);
                    tipousu = Convert.ToInt32(prmUsuario.Value);

                    Session["idusuario"] = idUsuario;
                    Session["nombreUsu"] = nombre;
                    Session["tipoUsu"] = tipousu;

                    if (activo == 1)
                    {
                        Session["correo"] = user;
                        if (tipousu == 0)
                        {
                            Response.Redirect("Inicio.aspx");
                        }
                        else
                        {
                            Response.Redirect("Tareas.aspx");
                        }
                    }
                    else if (activo == 2)
                    {
                        lblmsg.Text = "¡Contraseña incorrecta!";
                        password.Text = "";
                        password.Focus();
                        Session["tipoUsu"] = "";
                    } else {
                        lblmsg.Text = "¡Su cuenta no esta activada!";
                        correo.Text = "";
                        password.Text = "";
                        correo.Focus();
                        Session["tipoUsu"] = "";
                    }
                }
                Conn.Close();
            }
        }
    }
}