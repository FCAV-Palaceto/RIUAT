using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Text;
using System.Data;
using System.Net.Mail;
using System.IO;
using System.Text;
using System.Net;




public partial class Tareas : System.Web.UI.Page
{
    public string nombreUsu, tipoUsu;
    protected void Page_Load(object sender, EventArgs e)
    {
        nombreUsu = Convert.ToString(HttpContext.Current.Session["nombreUsu"]);

        tipoUsu = Convert.ToString(HttpContext.Current.Session["tipoUsu"]);
        // Si no existe sesión regresa al login
        if (tipoUsu.Equals(""))
        {
            HttpContext.Current.Response.Redirect("~/");
        }

        //Permisos de cada usuario para ver las pantallas
        if (tipoUsu.Equals("0"))
        {
            HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        }

        // Crea la ruta de la página que está
        Session["returnPath"] = Request.RawUrl;
    }

    [WebMethod]
    public static string SelTareas()
    {
        StringBuilder sb = new StringBuilder();
        if (Convert.ToString(HttpContext.Current.Session["nombreUsu"]) == "" || Convert.ToString(HttpContext.Current.Session["nombreUsu"]) == null){
            sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered\"><thead><tr><th scope=\"col\" hidden=\"hidden\">Id</th><th scope=\"col\">Producto académico</th><th scope=\"col\">Enviado a</th><th scope=\"col\">Enviado por</th><th scope=\"col\">Institución de procedencia</th><th scope=\"col\">Acciones</th></tr></thead><tbody><td colspan=\"5\" style=\"text-align: center;\">No hay registros disponibles.</td></tbody></table>");
        } else {
            using (SqlConnection Conn = conn.Conecta())
            {
                if (Convert.ToString(HttpContext.Current.Session["tipoUsu"]) == "1"){
                    using (SqlCommand seldata = new SqlCommand("SelTareas", Conn))
                    {
                        seldata.CommandType = CommandType.StoredProcedure;
                        seldata.Parameters.Add("@idUsuario", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idUsuario"]);
                        Conn.Open();
                        using (SqlDataReader drseldatos = seldata.ExecuteReader())
                        {
                            sb.Append("<table id=\"tabla1\" class=\"table table-striped table-bordered\"><thead><tr><th scope=\"col\" hidden=\"hidden\">Id</th><th scope=\"col\"><div style=\"width: 500px\">Producto académico</div></th><th scope=\"col\">Enviado a</th><th scope=\"col\"><div style=\"width: 150px\">Enviado por</div></th><th scope=\"col\">Institución de procedencia</th><th scope=\"col\">1era revisión</th><th scope=\"col\">2da revisión</th><th scope=\"col\">Estado</th><th scope=\"col\">Comentarios</th><th scope=\"col\">Acciones</th></tr></thead><tbody>");
                            while (drseldatos.Read())
                            {
                                sb.Append("<tr>");
                                sb.Append("<td hidden=\"hidden\">" + drseldatos["id"].ToString() + "</td>");
                                //sb.Append("<td>" + drseldatos["titulo"].ToString() + "</td>");
                                sb.Append("<td class=\"align-middle\">" + drseldatos["titulo"].ToString() + "</td>");
                                string coleccion = "";
                                switch (drseldatos["coleccion"].ToString())
                                {
                                    case "76":
                                        coleccion = "Archivo Institucional";
                                        break;
                                    case "1262":
                                        coleccion = "Documentación Cientifica";
                                        break;
                                    case "77":
                                        coleccion = "Patrimonio Documental";
                                        break;
                                    case "78":
                                        coleccion = "Publicaciones y Producciones Universitarias";
                                        break;
                                    case "702":
                                        coleccion = "Recursos Educativos";
                                        break;
                                }
                                sb.Append("<td class=\"align-middle\">" + coleccion + "</td>");
                                sb.Append("<td class=\"align-middle\">" + drseldatos["Nombre"].ToString() + "</td>");
                                sb.Append("<td class=\"align-middle\">" + drseldatos["inst"].ToString() + "</td>");
                                string estado = "", orden = "";
                                int activa;
                                activa = Convert.ToInt32(drseldatos["activa"]);
                                switch (drseldatos["estado"].ToString())
                                {
                                    case "1":
                                        estado = "Enviado";
                                        orden = "1";
                                        break;
                                    case "2":
                                        estado = "Aceptado";
                                        orden = "3";
                                        break;
                                    case "3":
                                        estado = "Rechazado";
                                        orden = "4";
                                        break;
                                    case "4":
                                        estado = "Publicado";
                                        orden = "5";
                                        break;
                                    case "5":
                                        estado = "Primera revisión";
                                        orden = "2";
                                        break;
                                }
                                if (drseldatos["R1"].ToString() == "True")
                                {
                                    sb.Append("<td class = \"align-middle text-center\"><i class=\"icon-check text-success\"></i></td>");
                                }
                                else if (drseldatos["R1"].ToString() == "False")
                                {
                                    sb.Append("<td class = \"align-middle text-center\"><i class=\"icon-times text-danger\"></i></td>");
                                }
                                else
                                {
                                    sb.Append("<td></td>");
                                }
                                if (drseldatos["R2"].ToString() == "True")
                                {
                                    sb.Append("<td class = \"align-middle text-center\"><i class=\"icon-check text-success\"></i></td>");
                                }
                                else if (drseldatos["R2"].ToString() == "False")
                                {
                                    sb.Append("<td class = \"align-middle text-center\"><i class=\"icon-times text-danger\"></i></td>");
                                }
                                else
                                {
                                    sb.Append("<td></td>");
                                }
                                sb.Append("<td data-order=\"" + orden + "\" class = \"align-middle\">" + estado + "</td>");
                                //sb.Append("<td id=\"btnPublicado\"><input type=\"checkbox\" id=\"hide\" onclick=\"publicado\" class=\"btn btn-primary text-white text-nowrap\" style=\"text-align: center;\"/></td>");
                                if (drseldatos["observaciones"].ToString() != "")
                                {
                                    sb.Append("<td class=\"text-center align-middle\"><button type=\"button\" class=\"btn btn-link\" data-toggle=\"modal\" data-target=\"#modalComentarios\" data-whatever=\"" + drseldatos["observaciones"].ToString().Replace("\"", "&quot;") + "\">Mostrar</button></td>");
                                }
                                else
                                {
                                    sb.Append("<td></td>");
                                }
                                if (estado == "Enviado" || estado == "Primera revisión"){
                                    if (drseldatos["tomado"].ToString().Equals("")){
                                        sb.Append("<td class=\"text-center align-middle\"><button type=\"button\" class=\"btn btn-success text-nowrap\" onclick=\"tomaTarea(" + drseldatos["id"].ToString() + ");\">Tomar tarea</button></td>");
                                    }
                                    else if (activa == 1)
                                    {
                                        sb.Append("<td class=\"text-center align-middle\"><button type=\"button\" class=\"btn btn-warning text-black text-nowrap\" onclick=\"realizaTarea(" + drseldatos["id"].ToString() + ");\">Realizar tarea</button></td>");
                                    }
                                    else
                                    {
                                        sb.Append("<td class=\"text-center align-middle\"><button type=\"button\" class=\"btn btn-info text-white text-nowrap\" onclick=\"realizaTarea(" + drseldatos["id"].ToString() + ");\">Tarea asignada</button></td>");
                                    }
                                }
                                else
                                {
                                    sb.Append("<td class=\"text-center align-middle\"><button type=\"button\" class=\"btn btn-primary text-white text-nowrap\" onclick=\"realizaTarea(" + drseldatos["id"].ToString() + ");\">Ver envío</button></td>");
                                }


                                sb.Append("</tr>");
                            }
                            if (drseldatos.HasRows)
                            {
                                sb.Append("</tbody></table>");
                            }
                            else
                            {
                                sb.Append("<td colspan=\"9\" style=\"text-align: center;\">No hay productos pendientes.</td></tbody></table>");
                            }
                            drseldatos.Close();
                        }
                    }
                } else{
                    using (SqlCommand seldata = new SqlCommand("RevisaEnvios", Conn))
                    {
                        seldata.CommandType = CommandType.StoredProcedure;
                        seldata.Parameters.Add("@idUsuario", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idUsuario"]);
                        Conn.Open();
                        using (SqlDataReader drseldatos = seldata.ExecuteReader())
                        {
                            sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered\"><thead><tr><th scope=\"col\" hidden=\"hidden\">Id</th><th scope=\"col\">Producto académico</th><th scope=\"col\">Asignado a:</th>"/*<th scope=\"col\">Fecha de asignación:</th>*/+"<th scope=\"col\">1era revisión</th><th scope=\"col\">2da revisión</th><th scope=\"col\">Estado</th><th scope=\"col\">Comentarios</th>"/*<th scope=\"col\">Acciones</th>*/+ "<th scope=\"col\">Ver env&iacute;o</th> <th scope=\"col\">Publicado</th></tr></thead><tbody>");
                            while (drseldatos.Read())
                            {
                                sb.Append("<tr>");
                                sb.Append("<td hidden=\"hidden\">" + drseldatos["id"].ToString() + "</td>");
                                sb.Append("<td class = \"align-middle\">" + drseldatos["titulo"].ToString() + "</td>");
                                sb.Append("<td class = \"align-middle\">" + drseldatos["Nombre"].ToString() + "</td>");
                                //sb.Append("<td class = \"align-middle\">" + drseldatos["fecha"].ToString() + "</td>");
                                string estado = "", orden="";
                                switch (drseldatos["estado"].ToString())
                                {
                                    case "1":
                                        estado = "Enviado";
                                        orden = "5";
                                        break;
                                    case "2":
                                        estado = "Aceptado";
                                        orden = "2";
                                        break;
                                    case "3":
                                        estado = "Rechazado";
                                        orden = "3";
                                        break;
                                    case "4":
                                        estado = "Publicado";
                                        orden = "4";
                                        break;
                                    case "5":
                                        estado = "Primera revisión";
                                        orden = "1";
                                        break;
                                }
                                if (drseldatos["R1"].ToString() == "True")
                                {
                                    sb.Append("<td class = \"align-middle text-center\"><div class='col'><span class=\"col\" data-toggle=\"tooltip\" data-html=\"true\" data-placement=\"right\" title=\"<div class='text-left'><u><b>Revisado por:</b></u><br>" + drseldatos["NombreR1"].ToString() + "<br><em>" + drseldatos["fechaR1"].ToString() + "</em></div>\"><i class=\"icon-check text-success\"></i></span></div></td>");
                                }
                                else if (drseldatos["R1"].ToString() == "False")
                                {
                                    sb.Append("<td class = \"align-middle text-center\"><div class='col'><span class=\"col\" data-toggle=\"tooltip\" data-html=\"true\" data-placement=\"right\" title=\"<div class='text-left'><u><b>Revisado por:</b></u><br>" + drseldatos["NombreR1"].ToString() + "<br><em>" + drseldatos["fechaR1"].ToString() + "</em></div>\"><i class=\"icon-times text-danger\"></i></span></div></td>");
                                }
                                else
                                {
                                    sb.Append("<td></td>");
                                }
                                if (drseldatos["R2"].ToString() == "True")
                                {
                                    sb.Append("<td class = \"align-middle text-center\"><div class='col'><span class=\"col\" data-toggle=\"tooltip\" data-html=\"true\" data-placement=\"right\" title=\"<div class='text-left'><u><b>Revisado por:</b></u><br>" + drseldatos["NombreR2"].ToString() + "<br><em>" + drseldatos["fechaR2"].ToString() + "</em></div>\"><i class=\"icon-check text-success\"></i></span></div></td>");
                                }
                                else if (drseldatos["R2"].ToString() == "False")
                                {
                                    sb.Append("<td class = \"align-middle text-center\"><div class='col'><span class=\"col\" data-toggle=\"tooltip\" data-html=\"true\" data-placement=\"right\" title=\"<div class='text-left'><u><b>Revisado por:</b></u><br>" + drseldatos["NombreR2"].ToString() + "<br><em>" + drseldatos["fechaR2"].ToString() + "</em></div>\"><i class=\"icon-times text-danger\"></i></span></div></td>");
                                }
                                else
                                {
                                    sb.Append("<td></td>");
                                }
                                sb.Append("<td data-order=\""+orden+"\" class = \"align-middle\">" + estado + "</td>");
                                //sb.Append("<td id=\"btnPublicado\"><input type=\"checkbox\" id=\"hide\" onclick=\"publicado\" class=\"btn btn-primary text-white text-nowrap\" style=\"text-align: center;\"/></td>");
                                if (drseldatos["observaciones"].ToString() != ""){
                                    sb.Append("<td class=\"text-center align-middle\"><button type=\"button\" class=\"btn btn-link\" data-toggle=\"modal\" data-target=\"#modaleditComentarios\" data-whatever=\"" + drseldatos["observaciones"].ToString().Replace("\"", "&quot;") + "\" data-id=\""+drseldatos["id"].ToString()+"\">Mostrar</button></td>");
                                } else {
                                    sb.Append("<td></td>");
                                }
                                //sb.Append("<td><button type=\"button\" class=\"btn btn-success\" onclick=\"aceptar(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-check\"></i></button>");
                                //sb.Append("<button type=\"button\" class=\"btn btn-danger\" data-toggle=\"modal\" data-target=\"#modalMensaje\" data-whatever=\"" + drseldatos["id"].ToString() + "\"><i class=\"icon-times\"></i></button></td>");
                                sb.Append("<td class = \"align-middle text-center\"><button type=\"button\" class=\"btn btn-primary text-white text-nowrap\" onclick=\"realizaTarea(" + drseldatos["id"].ToString() + ");\">Ir</button></td>");
                                if (estado == "Publicado")
                                {
                                    sb.Append("<td data-order=\"1\" class = \"align-middle text-center\"><input id=\"chkToggle" + drseldatos["id"].ToString() + "\" checked type=\"checkbox\" data-toggle=\"toggle\" data-on=\"Sí\" data-off=\"No\" data-onstyle=\"success\" data-offstyle=\"danger\" data-size=\"sm\" onchange=\"onoff(" + drseldatos["id"].ToString() + ", " + drseldatos["estado"].ToString()+", '' , '');\"/></td>");
                                }
                                else if (estado == "Aceptado")
                                {
                                    sb.Append("<td data-order=\"3\" class = \"align-middle text-center\"><input id=\"chkToggle" + drseldatos["id"].ToString() + "\" type=\"checkbox\" data-toggle=\"toggle\" data-on=\"Sí\" data-off=\"No\" data-onstyle=\"success\" data-offstyle=\"danger\" data-size=\"sm\" onchange=\"modalfecha(" + drseldatos["id"].ToString() + ", '" + drseldatos["estado"].ToString() + "' , '" + drseldatos["correo"].ToString() + "' , '" + drseldatos["titulo"].ToString().Replace("\"", "&quot;").Replace("'", "&apos;") + "');\"/></td>");
                                }
                                else
                                {
                                    sb.Append("<td data-order=\"2\" class = \"align-middle text-center\"><input id=\"chkToggle" + drseldatos["id"].ToString() + "\" disabled type=\"checkbox\" data-toggle=\"toggle\" data-on=\"Sí\" data-off=\"No\" data-onstyle=\"success\" data-offstyle=\"danger\" data-size=\"sm\"/></td>");
                                }
                                sb.Append("<script>$(function(){$('#chkToggle" + drseldatos["id"].ToString() + "').bootstrapToggle();});</script>");
                                //sb.Append("<td><label class=\"switch\"><input type=\"checkbox\"><span class=\"slider\"></span></label></td>");
                                sb.Append("</tr>");
                            }
                            if (drseldatos.HasRows)
                            {
                                sb.Append("</tbody></table>");
                            }
                            else
                            {
                                sb.Append("<td colspan=\"8\" style=\"text-align: center;\">No hay productos pendientes.</td></tbody></table>");
                            }
                            drseldatos.Close();
                        }
                    }
                }
                Conn.Close();
                sb.Append("<script>$(function () { $('[data-toggle=\"tooltip\"]').tooltip() });</script>");
            }
        }
        return sb.ToString();
    }

    [WebMethod]
    public static string EnviaId(int id, int opcion)
    {
        if (HttpContext.Current.Session["idusuario"].ToString().Equals(""))
        {
            HttpContext.Current.Response.Redirect("~/");
            return "";
        } else {
            HttpContext.Current.Session["idproducto"] = id;
            int idusuario = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);

            int Exitoso = 0;

            using (SqlConnection Conn = conn.Conecta())
            {
                using (SqlCommand comand = new SqlCommand("TomaTarea", Conn))
                {
                    comand.CommandType = CommandType.StoredProcedure;
                    comand.Parameters.AddWithValue("@opcion", opcion);
                    comand.Parameters.AddWithValue("@id", id);
                    comand.Parameters.AddWithValue("@idusuario", idusuario);

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
        //HttpContext.Current.Session["correo"] = correo;
        // return "";
    }

    [WebMethod]
    public static string RealizaId(int id)
    {
        HttpContext.Current.Session["idproducto"] = id;
        return "";
    }


    [WebMethod]
    public static string PublicaProducto(int id, string fecha)
    {
        int estado = 4;
        int Exitoso = 0;

        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("Estado", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.AddWithValue("@id", id);
                comand.Parameters.AddWithValue("@fecha", fecha);
                comand.Parameters.AddWithValue("@estado", estado);

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

    [WebMethod]
    public static string EnviarCorreo(string Correo, string Titulo){
        int Exitoso=1;
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
            mm.Subject = "Producto Aceptado"; //Constancia.Trim();
            mm.Body = "Le informamos que su producto: <b>" + Titulo + "</b><br /><br /> Ha pasado correctamente por el filtro de revisión y ha sido publicado exitosamente.<br /><br />Si tiene alguna duda, envíe un correo a la siguiente cuenta: <br />repositorio.fcav@uat.edu.mx<br /><br />Saludos cordiales<br /><br />".Trim();
            mm.IsBodyHtml = true;
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

    [WebMethod]
    public static string ModificaComentarios(string comentarios, int id)
    {
        // int id = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
        // int tipousu = Convert.ToInt32(HttpContext.Current.Session["tipoUsu"]);
        // int idusuario = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);
        // int estado = 3;

        int Exitoso = 0;

        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("EditaObservaciones", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.AddWithValue("@id", id);                
                comand.Parameters.AddWithValue("@observaciones", comentarios);

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
    
    // Metódos para aceptar / rechazar directo en la página de tareas
    //[WebMethod]
    //public static string AceptaProducto(int id)
    //{
    //    int estado = 4;
    //    int Exitoso = 0;

    //    using (SqlConnection Conn = conn.Conecta())
    //    {
    //        using (SqlCommand comand = new SqlCommand("Estado", Conn))
    //        {
    //            comand.CommandType = CommandType.StoredProcedure;
    //            comand.Parameters.AddWithValue("@id", id);
    //            comand.Parameters.AddWithValue("@estado", estado);

    //            SqlParameter pexitoso = new SqlParameter("@Exitoso", SqlDbType.Int);
    //            pexitoso.Direction = ParameterDirection.Output;
    //            comand.Parameters.Add(pexitoso);

    //            Conn.Open();
    //            comand.ExecuteNonQuery();

    //            Exitoso = Convert.ToInt32(pexitoso.Value);
    //        }
    //        Conn.Close();
    //        return "{\"success\": \"" + Exitoso + "\"}";
    //    }
    //}

    //[WebMethod]
    //public static string RechazaProducto(string comentarios, int id)
    //{
    //    int estado = 5;
    //    int Exitoso = 0;

    //    using (SqlConnection Conn = conn.Conecta())
    //    {
    //        using (SqlCommand comand = new SqlCommand("Observaciones", Conn))
    //        {
    //            comand.CommandType = CommandType.StoredProcedure;
    //            comand.Parameters.AddWithValue("@id", id);
    //            comand.Parameters.AddWithValue("@estado", estado);
    //            comand.Parameters.AddWithValue("@observaciones", comentarios);

    //            SqlParameter pexitoso = new SqlParameter("@Exitoso", SqlDbType.Int);
    //            pexitoso.Direction = ParameterDirection.Output;
    //            comand.Parameters.Add(pexitoso);

    //            Conn.Open();
    //            comand.ExecuteNonQuery();

    //            Exitoso = Convert.ToInt32(pexitoso.Value);
    //        }
    //        Conn.Close();
    //        return "{\"success\": \"" + Exitoso + "\"}";
    //    }
    //}
}