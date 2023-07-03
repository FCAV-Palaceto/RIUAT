using System;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Services;

public partial class Registro : System.Web.UI.Page
{
    string tipoUsu;
    protected void Page_Load(object sender, EventArgs e)
    {
        tipoUsu = Convert.ToString(HttpContext.Current.Session["tipoUsu"]);
        // Si existe sesión regresa al la página anterior
        if (!(tipoUsu.Equals("")) && HttpContext.Current.Session["returnPath"] != null)
        {
            HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        }    
    }

    [WebMethod]
    public static string Guardar(string Nombre, string ApellidoP, string ApellidoM, string Correo, string Contrasena)
    {
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
                comand.Parameters.Add("@Tipo", SqlDbType.Int).Value = 0;
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
    public static string EnviarCorreo(string Nombre, string ApellidoP, string ApellidoM, string Correo, string Contrasena)
    {
        int Exitoso = 1;
        //Enviar Correo
        //Console.WriteLine("Entro");
        string user = "", pass = "";
        using (SqlConnection con = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("SelCorreo", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                SqlParameter puser = comand.Parameters.Add("@User", SqlDbType.NVarChar, 50);
                SqlParameter ppass = comand.Parameters.Add("@Pass", SqlDbType.NVarChar, 50);
                puser.Direction = ParameterDirection.Output;
                ppass.Direction = ParameterDirection.Output;
                con.Open();
                comand.ExecuteNonQuery();
                user = puser.Value.ToString();
                pass = ppass.Value.ToString();
            }
            con.Close();
        }
        using (MailMessage mm = new MailMessage(user.Trim(), Correo.Trim()))
        {
            mm.Subject = "Registro de RIUAT"; //Constancia.Trim();
            mm.Body = "Apreciable: <b>" + Nombre + " " + ApellidoP + " " + ApellidoM + "</b><br /><br /> Le informamos que se ha realizado correctamente su registro.<br /><br /> Para ingresar al sistema nuevamente utilicé el siguiente usuario y contraseña: <b>" + Correo + ".</b><br /><b>" + Contrasena + "</b> <br /><br />Si necesita asistencia con su cuenta, envíe un correo a la siguiente cuenta: <br />repositorio.fcav@uat.edu.mx<br /><br />Saludos cordiales<br /><br />".Trim();
            mm.IsBodyHtml = true;
            MailAddress copy = new MailAddress("dabrego@docentes.uat.edu.mx");
            mm.CC.Add(copy);
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.office365.com";
            smtp.EnableSsl = true;
            NetworkCredential networkCred = new NetworkCredential(user, pass);
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = networkCred;
            smtp.Port = 587;
            smtp.Send(mm);
        }
        return "{\"success\": \"" + Exitoso + "\"}";
    }
}