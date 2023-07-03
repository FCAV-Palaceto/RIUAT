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

public partial class Inicio : System.Web.UI.Page
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
        if (!(tipoUsu.Equals("0")))
        {
            HttpContext.Current.Response.Redirect("Tareas.aspx");
        }

        // Crea la ruta de la página que está
        Session["returnPath"] = Request.RawUrl;
    }

    [WebMethod]
    public static string SelProductos()
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand seldata = new SqlCommand("SelProductos", Conn))
            {
                
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.Add("@idUsuario", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idUsuario"]);
                Conn.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<table id=\"tabla\" class=\"table table-striped table-bordered\"><thead><tr><th scope=\"col\" hidden=\"hidden\">Id</th><th class=\"th-sm\" scope=\"col\">Titulo</th><th class=\"th-sm\" scope=\"col\">Producto</th><th class=\"th-sm\" scope=\"col\">Fecha y Hora</th><th class=\"th-sm\" scope=\"col\">Estado</th><th class=\"th-sm\" scope=\"col\">Acciones</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        var doc="";
                        if(drseldatos["tipo"].ToString()=="articulo"){
                            doc="Artículo";
                        }else if(drseldatos["tipo"].ToString()=="libro"){
                            doc="Libro";
                        }else if(drseldatos["tipo"].ToString()=="capitulo"){
                            doc="Capítulo Libro";
                        } else if(drseldatos["tipo"].ToString()=="tesism"){
                            doc="Tesis Maestría";
                        } else if(drseldatos["tipo"].ToString()=="tesisd"){
                            doc="Tesis Doctorado";
                        } else if(drseldatos["tipo"].ToString()=="conjuntod"){
                            doc="Conjunto de Datos";
                        } else if(drseldatos["tipo"].ToString()=="imagen"){
                            doc="Imagen";
                        } else if(drseldatos["tipo"].ToString()=="audio"){
                            doc="Audio";
                        } else if(drseldatos["tipo"].ToString()=="video"){
                            doc="Video";
                        } else if(drseldatos["tipo"].ToString()=="otros"){
                            doc="Otros";
                        } 
                        
                        sb.Append("<tr>");
                        sb.Append("<td data-label=\"Id\" hidden=\"hidden\">" + drseldatos["id"].ToString() + "</td>");
                        sb.Append("<td data-label=\"Titulo\" class=\"align-middle\">" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td id=\"tipo\" data-label=\"Producto\" class=\"align-middle\" >" + doc + "</td>");
                        sb.Append("<td data-label=\"Fecha y Hora\" class=\"align-middle\">" + drseldatos["fecha"].ToString() + "</td>");
                        if (drseldatos["estado"].ToString() == "0" || drseldatos["estado"].ToString() == "3")
                        {
                            if(drseldatos["estado"].ToString() == "3"){
                                sb.Append("<td data-label=\"Estado\" data-order=\"1\" class=\"align-middle\">Rechazado</td>");
                            } else {
                                sb.Append("<td data-label=\"Estado\" data-order=\"2\" class=\"align-middle\">Pendiente de envío</td>");   
                            }
                            sb.Append("<td data-label=\"Accion\" class=\"align-middle text-center\"><button type=\"button\" class=\"btn btn-info col-md-4 mr-1 mb-1\" onclick=\"modificaProducto(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-edit\"></i></button>");
                            sb.Append("<button type=\"button\" class=\"btn btn-secondary col-md-4 mb-1\" onclick=\"Detalle(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-search\"></i></button>");
                            sb.Append("<button type=\"button\" class=\"btn btn-danger col-md-4 mr-1\" onclick=\"DelProducto(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-trash-o\"></i></button>");
                            if (drseldatos["estado"].ToString() == "3")
                            {
                                if (drseldatos["observaciones"].ToString() == "")
                                {
                                    sb.Append("<button type=\"button\" class=\"btn btn-light border col-md-4\" disabled data-toggle=\"modal\" data-target=\"#modalComentarios\" data-whatever=\"" + drseldatos["observaciones"].ToString().Replace("\"", "&quot;") + "\"><span class=\"icon-message\"></span></button></td>");
                                }
                                else
                                {
                                    sb.Append("<button type=\"button\" class=\"btn btn-light border col-md-4\" data-toggle=\"modal\" data-target=\"#modalComentarios\" data-whatever=\"" + drseldatos["observaciones"].ToString().Replace("\"", "&quot;") + "\"><span class=\"icon-message\"></span></button></td>");
                                }                                
                            }
                            else
                            {
                                sb.Append("<button type=\"button\" class=\"btn btn-light border col-md-4\" disabled><span class=\"icon-message\"></span></button></td>");
                            }
                            
                        }
                        else if (drseldatos["estado"].ToString() == "1" || drseldatos["estado"].ToString() == "2" || drseldatos["estado"].ToString() == "4")
                        {
                            if(drseldatos["estado"].ToString() == "2"){
                                sb.Append("<td data-label=\"Estado\" data-order=\"5\" class=\"align-middle\">Aceptado</td>");
                            } else if(drseldatos["estado"].ToString() == "1") {
                                sb.Append("<td data-label=\"Estado\" data-order=\"3\" class=\"align-middle\">Enviado</td>");
                            } else {
                                sb.Append("<td data-label=\"Estado\" data-order=\"6\" class=\"align-middle\">Publicado</td>");   
                            }
                            if (drseldatos["estado"].ToString() == "1")
                            {
                                sb.Append("<td data-label=\"Accion\" class=\"align-middle text-center\"><button type=\"button\" class=\"btn btn-info col-md-4 mr-1 mb-1\" onclick=\"modificaProducto(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-edit\"></i></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-secondary col-md-4 mb-1\" onclick=\"Detalle(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-search\"></i></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-danger col-md-4 mr-1\" onclick=\"DelProducto(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-trash-o\"></i></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-light border col-md-4\" disabled><span class=\"icon-message\"></span></button></td>");
                            }
                            else
                            {
                                sb.Append("<td data-label=\"Accion\" class=\"align-middle text-center\"><button type=\"button\" class=\"btn btn-info col-md-4 mr-1 mb-1\" disabled><i class=\"icon-edit\"></i></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-secondary col-md-4 mb-1\" onclick=\"Detalle(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-search\"></i></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-danger col-md-4 mr-1\" disabled><i class=\"icon-trash-o\"></i></button>");
                                sb.Append("<button type=\"button\" class=\"btn btn-light border col-md-4\" disabled><span class=\"icon-message\"></span></button></td>");
                            }
                            
                        }
                        else if (drseldatos["estado"].ToString() == "5")
                        {
                            sb.Append("<td data-label=\"Estado\" data-order=\"4\" class=\"align-middle\">En revisión</td>");
                            sb.Append("<td data-label=\"Accion\" class=\"align-middle text-center\"><button type=\"button\" class=\"btn btn-info col-md-4 mr-1 mb-1\" disabled><i class=\"icon-edit\"></i></button>");
                            sb.Append("<button type=\"button\" class=\"btn btn-secondary col-md-4 mb-1\" onclick=\"Detalle(" + drseldatos["id"].ToString() + ");\"><i class=\"icon-search\"></i></button>");
                            sb.Append("<button type=\"button\" class=\"btn btn-danger col-md-4 mr-1\" disabled><i class=\"icon-trash-o\"></i></button>");
                            sb.Append("<button type=\"button\" class=\"btn btn-light border col-md-4\" disabled><span class=\"icon-message\"></span></button></td>");
                        }                                        
                        sb.Append("</tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"5\" style=\"text-align: center;\">No hay envíos disponibles.</td></tbody></table>");
                    }
                    drseldatos.Close();
                }
            }
            Conn.Close();
            return sb.ToString();
        }
    }

    [WebMethod]
    public static string EliminarProducto(int id)
    {
        int Eliminado = 0;
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("DelProducto", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idProducto", SqlDbType.Int).Value = id;

                SqlParameter peliminado = comand.Parameters.Add("@Eliminado", SqlDbType.Int);
                peliminado.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Eliminado = int.Parse(peliminado.Value.ToString());
            }
            Conn.Close();
            return "{\"success\": \"" + Eliminado + "\"}";
        }
    }

    [WebMethod]
    public static string NuevoProducto()
    {
        HttpContext.Current.Session["idproducto"] = "";
        HttpContext.Current.Session["articulo"] = "";
        HttpContext.Current.Session["estadoprod"] = "";
        return "";
    }

    [WebMethod]
    public static string ModificarProducto(int id)
    {
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("TipoArticulo", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idProducto", SqlDbType.Int).Value = id;

                SqlParameter particulo = comand.Parameters.Add("@articulo", SqlDbType.NVarChar, 50);
                particulo.Direction = ParameterDirection.Output;

                SqlParameter pestado = comand.Parameters.Add("@estado", SqlDbType.Int);
                pestado.Direction = ParameterDirection.Output;

                Conn.Open();
                comand.ExecuteNonQuery();

                HttpContext.Current.Session["idproducto"] = id;
                HttpContext.Current.Session["articulo"] = particulo.Value.ToString();
                HttpContext.Current.Session["estadoprod"] = pestado.Value.ToString();
            }
            Conn.Close();
            return "";
        }
    }

    [WebMethod]
    public static string Tabla(int id){
        HttpContext.Current.Session["idproducto"] = id;
        return "";
    }
}