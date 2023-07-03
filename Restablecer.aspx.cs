using System;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Services;


public partial class Restablecer : System.Web.UI.Page
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
    public static string Validar(string Correo)
    {
        int Exitoso = 0;
        string Contra ="", user = "", pass = "";
        using (SqlConnection Conn= conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("Restablecer",Conn))
            {
                comand.CommandType= CommandType.StoredProcedure;
                comand.Parameters.Add("@Correo", SqlDbType.NVarChar, 50).Value = Correo;
                SqlParameter contra = comand.Parameters.Add("@Contra", SqlDbType.NVarChar, 50);
                SqlParameter puser = comand.Parameters.Add("@User", SqlDbType.NVarChar, 50);
                SqlParameter ppass = comand.Parameters.Add("@Pass", SqlDbType.NVarChar, 50);
                SqlParameter pexitoso = comand.Parameters.Add("@Exitoso", SqlDbType.Int);
                contra.Direction = ParameterDirection.Output;
                pexitoso.Direction = ParameterDirection.Output;
                puser.Direction = ParameterDirection.Output;
                ppass.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Contra = contra.Value.ToString();
                user = puser.Value.ToString();
                pass = ppass.Value.ToString();
                Exitoso = int.Parse(pexitoso.Value.ToString());
                if(Exitoso == 1){
                    using (MailMessage mm = new MailMessage(user.Trim(), Correo.Trim()))
                    {
                        mm.Subject = "Contraseña de acceso a RIUAT";
                        mm.Body = "Correo: <b>" + Correo + "</b><br/>Contraseña: <b>" + Contra +"</b>";
                        mm.IsBodyHtml = true;
                        SmtpClient smtp = new SmtpClient();
                        smtp.Host = "smtp.office365.com";
                        smtp.EnableSsl = true;
                        NetworkCredential networkCred = new NetworkCredential (user, pass);
                        smtp.UseDefaultCredentials = true;
                        smtp.Credentials = networkCred;
                        smtp.Port = 587;
                        smtp.Send(mm);
                    }
                }
            }
            Conn.Close();
        }
        return "{\"success\":\"" + Exitoso + "\"}";
    }
}