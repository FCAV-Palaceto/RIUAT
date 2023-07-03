using System;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Services;


public partial class Revisar : System.Web.UI.Page
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
        if (tipoUsu.Equals("0"))
        {
            HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        }

        // Crea la ruta de la página que está
        Session["returnPath"] = Request.RawUrl;
    }

    [WebMethod]
    public static string Tabla()
    {
        string tipousu = HttpContext.Current.Session["tipoUsu"].ToString();

        StringBuilder sb = new StringBuilder();
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ProductoRevision", Conn))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
                Conn.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tabla\" class=\"table table-hover border-left border-right border-bottom\"><tbody>");
                    drseldatos.Read();
                    sb.Append("<input type=\"text\" id=\"idprod\" value=\"" + drseldatos["id"].ToString() + "\" hidden = \"hidden\">");
                    sb.Append("<input type=\"text\" id=\"estadoprod\" value=\"" + drseldatos["estado"].ToString() + "\" hidden = \"hidden\">");
                    sb.Append("<input type=\"text\" id=\"txtCorreo\" value=\"" + drseldatos["Correo"].ToString() + "\" hidden = \"hidden\">");
                    sb.Append("<input type=\"text\" id=\"txtTipo\" value=\"" + tipousu + "\" hidden = \"hidden\">");
                    sb.Append("<input type=\"text\" id=\"asignado\" value=\"" + drseldatos["asignado"].ToString() + "\" hidden = \"hidden\">");

                    if (!drseldatos["titulo"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Título:</td>");
                        sb.Append("<td id=\"titulo\">" + drseldatos["titulo"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["tipoarticulo"].ToString().Equals(""))
                    {
                        string tipoart="";
                        switch (drseldatos["tipoarticulo"].ToString()){
                            case "articulo":
                                tipoart = "Artículo";
                                break;
                            case "libro":
                                tipoart = "Libro";
                                break;
                            case "capitulo":
                                tipoart = "Capítulo de Libro";
                                break;
                            case "tesism":
                                tipoart = "Tesis de Maestría";
                                break;
                            case "tesisd":
                                tipoart = "Tesis de Doctorado";
                                break;
                            case "conjuntod":
                                tipoart = "Conjunto de Datos";
                                break;
                        }
                        sb.Append("<tr><td>Tipo de artículo:</td>");
                        sb.Append("<td>" + tipoart + "</td></tr>");
                    }
                    sb.Append("<tr><td>Enviado por:</td>");
                    sb.Append("<td id=\"nombre\">" + drseldatos["Nombre"].ToString() + "</td></tr>");
                    if (!drseldatos["autor"].ToString().Equals(""))
                    {
                        string s = drseldatos["autor"].ToString().Replace("||", "¿");
                        string[] subs = s.Split('¿');

                        sb.Append("<tr><td>Autor(es):<br><small class=\"text-muted\"><i>Incluye su identificador del Conacyt.</i></small></td><td id=\"idautor\">");

                        foreach (var sub in subs)
                        {
                            string[] ss = sub.Split(';');
                            if(ss[0].Contains("1")){
                                sb.Append("<div class='row'><div class='col-auto'>" + ss[0].Replace("1", "") + ";" + ss[1] + "</div><div class='col'><span class=\"col\" data-toggle=\"tooltip\" data-html=\"true\" data-placement=\"right\" title=\"<div class='text-left'><u><b>Detalles:</b></u><br><em>Autor validado en el catálogo de Conacyt</em></div>\"><i class=\"icon-check text-success\"></i></span></div></div>");
                            } else {
                                sb.Append("<div class='row'><div class='col-auto'>" + sub + "</div><div class='col'><span class=\"col\" data-toggle=\"tooltip\" data-html=\"true\" data-placement=\"right\" title=\"<div class='text-left'><u><b>Detalles:</b><br></u><em>Autor <b>NO</b> validado en el catálogo de Conacyt</em></div>\"><i class=\"icon-times text-danger\"></i></span></div></div>");
                            }

                        }

                        sb.Append("</td></tr>");

                    }
                    if (!drseldatos["articulo"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Artículo:</td>");
                        sb.Append("<td>" + drseldatos["articulo"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["colaborador"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Tipo de colaboración:</td>");
                        sb.Append("<td>" + drseldatos["colaborador"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["email"].ToString().Equals(""))
                    {
                        string s = drseldatos["email"].ToString().Replace("||", ", ");

                        sb.Append("<tr><td>Correo electrónico de autor(es):</td>");
                        sb.Append("<td>" + s + "</td></tr>");
                    }
                    if (!drseldatos["grado"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Grado obtenido:</td>");
                        sb.Append("<td>" + drseldatos["grado"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["asesor"].ToString().Equals(""))
                    {
                        string s = drseldatos["asesor"].ToString().Replace("||", "¿");
                        string[] subs = s.Split('¿');

                        sb.Append("<tr><td>Asesor(es) de tesis:<br><small class=\"text-muted\"><i>Incluye su identificador del Conacyt.</i></small></td><td id=\"idasesor\">");

                        foreach (var sub in subs)
                        {
                            string[] ss = sub.Split(';');
                            if(ss[0].Contains("1")){
                                sb.Append("<div class='row'><div class='col-auto'>" + ss[0].Replace("1", "") + ";" + ss[1] + "</div><div class='col'><span class=\"col\" data-toggle=\"tooltip\" data-html=\"true\" data-placement=\"right\" title=\"<div class='text-left'><u><b>Detalles:</b></u><br><em>Autor validado en el catálogo de Conacyt</em></div>\"><i class=\"icon-check text-success\"></i></span></div></div>");
                            } else {
                                sb.Append("<div class='row'><div class='col-auto'>" + sub + "</div><div class='col'><span class=\"col\" data-toggle=\"tooltip\" data-html=\"true\" data-placement=\"right\" title=\"<div class='text-left'><u><b>Detalles:</b><br></u><em>Autor <b>NO</b> validado</em> en el catálogo de Conacyt</div>\"><i class=\"icon-times text-danger\"></i></span></div></div>");
                            }
                        }

                        sb.Append("</td></tr>");
                    }
                    if (!drseldatos["patrocinador"].ToString().Equals(""))
                    {
                        string s = drseldatos["patrocinador"].ToString().Replace("||", "¿");
                        string[] subs = s.Split('¿');

                        sb.Append("<tr><td>Patrocinador(es):</td><td>");

                        foreach (var sub in subs)
                        {
                            sb.Append(sub + "<br>");
                        }

                        sb.Append("</td></tr>");
                    }
                    if (!drseldatos["monografia"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Tipo de monografía:</td>");
                        sb.Append("<td>" + drseldatos["monografia"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["resumen"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Resumen:</td>");
                        sb.Append("<td>" + drseldatos["resumen"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["citacion"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Citación:</td>");
                        sb.Append("<td>" + drseldatos["citacion"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["palabras"].ToString().Equals(""))
                    {
                        string s = drseldatos["palabras"].ToString().Replace("||", ", ");

                        sb.Append("<tr><td>Palabras Clave:</td>");
                        sb.Append("<td>" + s + "</td></tr>");
                    }
                    if (!drseldatos["fechapublicacion"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Fecha de publicación o terminación:</td>");
                        sb.Append("<td>" + drseldatos["fechapublicacion"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["descripcion"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Descripción de la revista o libro:</td>");
                        sb.Append("<td>" + drseldatos["descripcion"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["rango"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Rango de páginas:</td>");
                        sb.Append("<td>" + drseldatos["rango"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["arbitrado"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Arbitrado:</td>");
                        sb.Append("<td>" + drseldatos["arbitrado"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["isbn"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>ISBN del libro:</td>");
                        sb.Append("<td>" + drseldatos["isbn"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["publicador"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Publicador:</td>");
                        sb.Append("<td>" + drseldatos["publicador"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["institucion"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Institución de procedencia:</td>");
                        sb.Append("<td>" + drseldatos["institucion"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["edicion"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Edición:</td>");
                        sb.Append("<td>" + drseldatos["edicion"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["candidato"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Candidato de la patente:</td>");
                        sb.Append("<td>" + drseldatos["candidato"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["patente"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Número de identificación:</td>");
                        sb.Append("<td>" + drseldatos["patente"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["paginas"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Número de páginas:</td>");
                        sb.Append("<td>" + drseldatos["paginas"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["ejemplares"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Tiraje:</td>");
                        sb.Append("<td>" + drseldatos["ejemplares"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["idioma"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Idioma:</td>");
                        sb.Append("<td>" + drseldatos["idioma"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["pais"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>País:</td>");
                        sb.Append("<td>" + drseldatos["pais"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["acceso"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Tipo de publicación:</td>");
                        sb.Append("<td>" + drseldatos["acceso"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["fechafin"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Fecha de finalización de embargo:</td>");
                        sb.Append("<td>" + drseldatos["fechafin"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["proyecto"].ToString().Equals(""))
                    {
                        string s = drseldatos["proyecto"].ToString().Replace("||", ", ");

                        sb.Append("<tr><td>Proyectos:</td>");
                        sb.Append("<td>" + s + "</td></tr>");
                    }
                    if (!drseldatos["area"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Área de conocimiento:</td>");
                        sb.Append("<td>" + drseldatos["area"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["audiencia"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Audiencia:</td>");
                        sb.Append("<td>" + drseldatos["audiencia"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["financiamiento"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Tipo de financiamiento / patrocinador:</td>");
                        sb.Append("<td>" + drseldatos["financiamiento"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["licencia"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>Licencia:</td>");
                        sb.Append("<td>" + drseldatos["licencia"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["url"].ToString().Equals(""))
                    {
                        sb.Append("<tr><td>URL del origen del producto académico:</td>");
                        sb.Append("<td>" + drseldatos["url"].ToString() + "</td></tr>");
                    }
                    if (!drseldatos["datos"].ToString().Equals(""))
                    {
                        string s = drseldatos["datos"].ToString().Replace("||", ", ");

                        sb.Append("<tr><td>Conjunto de datos relacionados con el producto académico:</td>");
                        sb.Append("<td>" + s + "</td></tr>");
                    }
                    if (!drseldatos["coleccion"].ToString().Equals(""))
                    {
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
                        sb.Append("<tr><td>Enviado a la colección:</td>");
                        sb.Append("<td>" + coleccion + "</td></tr>");
                    }
                    drseldatos.Close();
                    sb.Append("</tbody></table>");
                }
            }
            Conn.Close();
            sb.Append("<script>$(function () { $('[data-toggle=\"tooltip\"]').tooltip() });</script>");
            return sb.ToString();
        }
    }

    [WebMethod]
    public static string Cancela()
    {
        int id = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
        int Exitoso = 0;

        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("Cancelar", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.AddWithValue("@id", id);

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
    public static string RevisaProducto(string comentarios)
    {
        int id = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
        int tipousu = Convert.ToInt32(HttpContext.Current.Session["tipoUsu"]);
        int idusuario = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);
        int estado = 2;

        int Exitoso = 0;

        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("Acepta", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.AddWithValue("@id", id);
                comand.Parameters.AddWithValue("@tipousu", tipousu);
                comand.Parameters.AddWithValue("@idusuario", idusuario);
                comand.Parameters.AddWithValue("@estado", estado);
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

    [WebMethod]
    public static string EnviaComentarios(string comentarios)
    {
        int id = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
        int tipousu = Convert.ToInt32(HttpContext.Current.Session["tipoUsu"]);
        int idusuario = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);
        int estado = 3;

        int Exitoso = 0;

        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("Observaciones", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.AddWithValue("@id", id);
                comand.Parameters.AddWithValue("@tipousu", tipousu);
                comand.Parameters.AddWithValue("@idusuario", idusuario);
                comand.Parameters.AddWithValue("@estado", estado);
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

    [WebMethod]
    public static string EnviarCorreo(string titulo,string correo)
    {
        //string Correo = correo;
        int Exitoso = 0;
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
        using (MailMessage mm = new MailMessage(user.Trim(), correo.Trim()))
        {
            mm.Subject = "Observaciones del Producto"; //Constancia.Trim();
            mm.Body = "Le informamos que su producto: <b>" + titulo + "</b><br /><br /> Ha sido devuelto, por favor revise los comentarios para corregir cualquier dato incorrecto o incompleto.<br /><br />Por favor comuníquese inmediatamente, envíe un correo a la siguiente cuenta: <br />repositorio.fcav@uat.edu.mx<br /><br />Saludos cordiales<br /><br />".Trim();
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
    public static string RealizarTarea()
    {
        int Exitoso = 0;
        using (SqlConnection con = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("UpdTareaPendiente", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
                comand.Parameters.Add("@idusuario", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);
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
}