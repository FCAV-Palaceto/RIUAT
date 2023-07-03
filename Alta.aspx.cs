using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;
using System.Net.Mail;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Net;

public partial class Alta : System.Web.UI.Page
{
    public string tipoUsu;
    protected void Page_Load(object sender, EventArgs e)
    {
        tipoUsu = Convert.ToString(HttpContext.Current.Session["tipoUsu"]);
        // Si no existe sesión regresa al login
        if (tipoUsu.Equals(""))
        {
            HttpContext.Current.Response.Redirect("~/");
        }

        // Permisos de cada usuario para ver las pantallas
        if (!(tipoUsu.Equals("2")))
        {
            HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        }

        // Crea la ruta de la página que está
        Session["returnPath"] = Request.RawUrl;
    }

    [WebMethod]
    public static string Registrar(string Nombre, string ApellidoP, string ApellidoM, string Correo, string Contrasena, int Tipo){

        int Exitoso = 0;
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("RegistroUsuarios", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@Nombre", SqlDbType.NVarChar, 50).Value = Nombre;
                comand.Parameters.Add("@ApellidoP", SqlDbType.NVarChar, 50).Value = ApellidoP;
                comand.Parameters.Add("@ApellidoM", SqlDbType.NVarChar, 50).Value = ApellidoM;
                comand.Parameters.Add("@Correo", SqlDbType.NVarChar, 50).Value = Correo;
                comand.Parameters.Add("@Contra", SqlDbType.NVarChar, 50).Value = Contrasena;
                comand.Parameters.Add("@Tipo", SqlDbType.Int).Value = Tipo;
                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                pexitoso.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
            }
            Conn.Close();
            return "{\"success\": \"" + Exitoso + "\"}";
        }
    }

    [WebMethod]
    public static string ActualizarUsu(string Nombre, string ApellidoP, string ApellidoM, string Correo, string Contrasena, int Tipo, int id)
    {
        int Exitoso = 0;
        using (SqlConnection con = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("ActualizarUsuario", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@Nombre", SqlDbType.NVarChar, 50).Value = Nombre;
                comand.Parameters.Add("@ApellidoP", SqlDbType.NVarChar, 50).Value = ApellidoP;
                comand.Parameters.Add("@ApellidoM", SqlDbType.NVarChar, 50).Value = ApellidoM;
                comand.Parameters.Add("@Correo", SqlDbType.NVarChar, 50).Value = Correo;
                //comand.Parameters.Add("@Contra", SqlDbType.NVarChar, 50).Value = Contrasena;
                comand.Parameters.Add("@Tipo", SqlDbType.Int).Value = Tipo;
                comand.Parameters.Add("@idUsu", SqlDbType.Int).Value = id;
                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                pexitoso.Direction = ParameterDirection.Output;
                con.Open();
                comand.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
            }
            con.Close();
            return "{\"success\": \"" + Exitoso + "\"}";
        }
    }

    [WebMethod]
    public static string ModUsu(int id)
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("ModUsuario", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idUsuario", SqlDbType.Int).Value = id;
                con.Open();
                using (SqlDataReader dr = comand.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        sb.Append("{\"Nombre\": \"" + dr["Nombre"].ToString().Trim() + "\",\"Paterno\": \"" + dr["Paterno"].ToString().Trim() + "\",\"Materno\": \"" + dr["Materno"].ToString().Trim() + "\", \"Correo\": \"" + dr["Correo"].ToString().Trim() + "\",\"Tipo\": \"" + dr["Tipo"].ToString().Trim() + "\"}");
                    }
                    dr.Close();
                }
            }
            con.Close();
        }
        return sb.ToString();
    }

    [WebMethod]
    public static string EnviarCorreo(string Nombre, string ApellidoP, string ApellidoM, string Correo, string Contrasena)
    {
        int Exitoso = 1;
        //Enviar Correo
        //Console.WriteLine("Entro");
        using (MailMessage mm = new MailMessage("repositorio.fcav@uat.edu.mx", Correo.Trim()))
        {
            mm.Subject = "Registro exitoso en RIUAT"; //Constancia.Trim();
            mm.Body = "Apreciable: <b>" + Nombre + " " + ApellidoP + " " + ApellidoM + "</b><br /><br /> Le informamos que ha sido registrado correctamente en el sistema.<br /><br /> Para ingresar al sistema nuevamente utilicé el siguiente usuario y contraseña: <b>" + Correo + ".</b><br /><b>" + Contrasena + "</b> <br /><br />Si necesita asistencia con su cuenta, envíe un correo a la siguiente cuenta: <br />repositorio.fcav@uat.edu.mx<br /><br />Saludos cordiales<br /><br />".Trim();
            mm.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "***";
            smtp.EnableSsl = true;
            string user = "***";
            string pass = "***";
            NetworkCredential networkCred = new NetworkCredential(user, pass);
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = networkCred;
            smtp.Port = ***;
            smtp.Send(mm);
        }
        return "{\"success\": \"" + Exitoso + "\"}";
    }

    [WebMethod]
    public static string TablaUsuarios()
    {
        int activo = 0;
        string estado = "", color = "";
        StringBuilder sb = new StringBuilder();
        using (SqlConnection con =  conn.Conecta())
        {
            using (SqlCommand seldata = new SqlCommand("SelUsuarios", con))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                con.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered\"><thead><tr><th scope=\"col\">Nuevo usuario</th><th scope=\"col\">Nombre</th><th scope=\"col\">Correo</th><th scope=\"col\">Tipo</th><th scope=\"col\">Estatus</th><th scope=\"col\">Editar</th><th scope=\"col\">Eliminar</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        activo = Convert.ToInt32(drseldatos["Activo"]);
                        if (activo == 1)
                        {
                            estado = "fa fa-check";
                            color = "btn-info";
                        }
                        else
                        {
                            estado = "fa fa-ban";
                            color = "btn-secondary";
                        }
                        sb.Append("<tr>");
                        if (drseldatos["Estado"].ToString() == "False"){
                            sb.Append("<td data-order=\"1\" class=\"align-middle text-center\"><i class=\"fa fa-exclamation-triangle text-warning\"></i></td>");
                        } else {
                            sb.Append("<td data-order=\"0\"></td>");
                        }
                        sb.Append("<td>" + drseldatos["Nombre"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["Correo"].ToString() + "</td>");
                        sb.Append("<td>" + drseldatos["Tipo"].ToString() + "</td>");
                        sb.Append("<td><button type=\"button\" class=\"btn btn-icon "+ color +" "+ estado +"\" onclick=\"EstadoUsuario(" + drseldatos["idUsuario"].ToString() + ");\" style=\"width: 40px; height: 40px;\"></button></td>");
                        sb.Append("<td><a type=\"button\" href=\"#\" style=\"color:#fff;\" class=\"btn  btn-primary\" onclick=\"ModificarUsuario(" + drseldatos["idUsuario"].ToString() + ");\"><i class=\"fa fa-pencil\"></i></a></td>");
                        sb.Append("<td><button type=\"button\" class=\"btn btn-danger\" onclick=\"ConfirmarEliminar(" + drseldatos["idUsuario"].ToString() + ");\"><i class=\"fa fa-trash\"></i></button></td>");
                        sb.Append("</tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"7\" style=\"text-align: center;\">No hay registros disponibles.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            con.Close();
            return sb.ToString();
        }
    }

    [WebMethod]
    public static string EstadoUsu(int id)
    {
        int Exitoso = 0;
        using (SqlConnection con = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("EstadoUsuario", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idUsu", SqlDbType.Int).Value = id;
                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                pexitoso.Direction = ParameterDirection.Output;
                con.Open();
                comand.ExecuteNonQuery();
                Exitoso = int.Parse(pexitoso.Value.ToString());
            }
            con.Close();
            return "{\"success\": \"" + Exitoso + "\"}";
        }
    }

    [WebMethod]
    public static string EliminarUsu(int id)
    {
        int Eliminado = 0;
        using (SqlConnection con = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("EliminarUsuario", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idUsuario", SqlDbType.Int).Value = id;
                SqlParameter peliminado = comand.Parameters.Add("@Eliminado", SqlDbType.Int);
                peliminado.Direction = ParameterDirection.Output;
                con.Open();
                comand.ExecuteNonQuery();
                Eliminado = int.Parse(peliminado.Value.ToString());
            }
            con.Close();
            return "{\"success\": \"" + Eliminado + "\"}";
        }
    }
}