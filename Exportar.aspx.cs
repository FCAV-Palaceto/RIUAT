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

public partial class Exportar : System.Web.UI.Page
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
        if (!(tipoUsu.Equals("2")))
        {
            HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        }

        // Crea la ruta de la página que está
        Session["returnPath"] = Request.RawUrl;
    }

    [WebMethod]
    public static string SelProductos(string fechainicio, string fechafin)
    {
        string tipo = "";
        StringBuilder sb = new StringBuilder();
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand seldata = new SqlCommand("SelExportados", Conn))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                seldata.Parameters.Add("@fechainicio", SqlDbType.NVarChar).Value = fechainicio;
                seldata.Parameters.Add("@fechafin", SqlDbType.NVarChar).Value = fechafin;
                Conn.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<div class=\"table-responsive-md\"><table id=\"tabla\" class=\"table table-striped table-bordered\"><thead><tr><th scope=\"col\" hidden=\"hidden\">Id</th><th class=\"th-sm\" scope=\"col\">Título</th><th class=\"th-sm\" scope=\"col\">Tipo</th><th class=\"th-sm\" scope=\"col\">Autor(es)</th><th class=\"th-sm\" scope=\"col\">Estado</th><th class=\"th-sm\" scope=\"col\">Fecha de Exportación</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        if (drseldatos["tipo"].ToString() == "tesism")
                        {
                            tipo = "Tesis Maestria";
                        }
                        else
                            if (drseldatos["tipo"].ToString() == "tesisd")
                            {
                                tipo = "Tesis Doctorado";
                            }
                            else
                                if (drseldatos["tipo"].ToString() == "articulo")
                                {
                                    tipo = "Artículo";
                                }
                                else
                                    if (drseldatos["tipo"].ToString() == "capitulo")
                                    {
                                        tipo = "Capítulo Libro";
                                    }
                                    else
                                        if (drseldatos["tipo"].ToString() == "libro")
                                        {
                                            tipo = "Libro";
                                        }
                                        else
                                        {
                                            tipo = "Otro";
                                        }
                        sb.Append("<tr>");
                        sb.Append("<td data-label:\"Id\" hidden=\"hidden\">" + drseldatos["id"].ToString() + "</td>");
                        sb.Append("<td data-label:\"Título\" class=\"align-middle\">" + drseldatos["titulo"].ToString() + "</td>");
                        sb.Append("<td data-label:\"Tipo\" class=\"align-middle\">" + tipo + "</td>");
                        
                        // Quitar los 1 que están en el nombre para verificar si están dados de alta en conacyt
                        string autor = string.Empty;

                        if (drseldatos["autor"].ToString() != string.Empty)
                        {
                            string s = drseldatos["autor"].ToString().Replace("||", "¿");
                            string[] subs = s.Split('¿');                            

                            foreach (var sub in subs)
                            {
                                string[] ss = sub.Split(';');

                                if (sub.Equals(subs.Last()))
                                {
                                    autor += ss[0].Replace("1", string.Empty);
                                    autor += ";" + ss[1];
                                }
                                else
                                {
                                    autor += ss[0].Replace("1", string.Empty);
                                    autor += ";" + ss[1] + "||";
                                }
                            }
                        }

                        sb.Append("<td data-label:\"Autor(es)\" class=\"align-middle\">" + autor + "</td>");

                        string estado = "";
                        if (Convert.ToInt32(drseldatos["estado"]) == 1)
                        {
                            estado = "Exportado";
                        }
                        else
                        {
                            estado = "No exportado";
                        }
                        sb.Append("<td data-label:\"Estado\" class=\"align-middle\">" + estado + "</td>");
                        sb.Append("<td data-label:\"Fecha de Exportación\" class=\"align-middle\">" + drseldatos["fecha"].ToString() + "</td>");                        
                        sb.Append("</tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table></div>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"6\" style=\"text-align: center;\">No hay envíos exportados.</td></tbody></table></div>");
                    }
                    drseldatos.Close();
                }
            }
            Conn.Close();
            return sb.ToString();
        }
    }

    [WebMethod]
    public static string SelProductosSinExpo()
    {
        string tipo = "";
        StringBuilder sb = new StringBuilder();
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand seldata = new SqlCommand("ExportarMetadatos", Conn))
            {
                seldata.CommandType = CommandType.StoredProcedure;
                Conn.Open();
                using (SqlDataReader drseldatos = seldata.ExecuteReader())
                {
                    sb.Append("<div class=\"table-responsive \"><table id=\"tabla2\" class=\"table table-striped table-bordered\"><thead><tr><th class=\"th-sm\" scope=\"col\">id</th><th class=\"th-sm\" scope=\"col\">collection</th><th class=\"th-sm\" scope=\"col\">dc.audience[es_ES]</th><th class=\"th-sm\" scope=\"col\"><div style=\"width: 350px\">dc.contributor.advisor</div></th><th class=\"th-sm\" scope=\"col\">dc.coverage[es_ES]</th><th class=\"th-sm\" scope=\"col\">dc.date.embargoend</th><th class=\"th-sm\" scope=\"col\">dc.date.issued</th><th class=\"th-sm\" scope=\"col\"><div style=\"width: 1500px\">dc.description.abstract[es_ES]</div></th><th class=\"th-sm\" scope=\"col\">dc.identifier.isbn[es_ES]</th><th class=\"th-sm\" scope=\"col\">dc.language.iso[es_ES]</th><th class=\"th-sm\" scope=\"col\">dc.publisher[es_ES]</th><th class=\"th-sm\" scope=\"col\"><div style=\"width: 350px\">dc.relation[es_ES]</div></th><th class=\"th-sm\" scope=\"col\">dc.rights.uri[es_ES]</th><th class=\"th-sm\" scope=\"col\">dc.rights[es_ES]</th><th class=\"th-sm\" scope=\"col\">dc.source</th><th class=\"th-sm\" scope=\"col\">dc.subject.classification[es_ES]</th><th class=\"th-sm\" scope=\"col\">dc.subject[es_ES]</th><th class=\"th-sm\" scope=\"col\"><div style=\"width: 300px\">dc.title[es_ES]</div></th><th class=\"th-sm\" scope=\"col\">dc.type[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.arbit[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.area[es_ES]</th><th class=\"th-sm\" scope=\"col\"><div style=\"width: 350px\">uat.autor[es_ES]</div></th><th class=\"th-sm\" scope=\"col\">uat.edition[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.email[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.grade[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.institucion</th><th class=\"th-sm\" scope=\"col\">uat.numid</th><th class=\"th-sm\" scope=\"col\">uat.origen</th><th class=\"th-sm\" scope=\"col\">uat.patent</th><th class=\"th-sm\" scope=\"col\">uat.printing[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.project</th><th class=\"th-sm\" scope=\"col\">uat.range[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.relation.url</th><th class=\"th-sm\" scope=\"col\">uat.sheets[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.tipoproyecto[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.typeart</th><th class=\"th-sm\" scope=\"col\">uat.typemon</th><th class=\"th-sm\" scope=\"col\">uat.number[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.vol[es_ES]</th><th class=\"th-sm\" scope=\"col\">dc.title.alternative[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.campo[es_ES]</th><th class=\"th-sm\" scope=\"col\">uat.disciplina[es_ES]</th></tr></thead><tbody>");
                    while (drseldatos.Read())
                    {
                        if (drseldatos["uat.typeart"].ToString() == "tesism")
                        {
                            tipo = "Tesis Maestria";
                        }
                        else
                            if (drseldatos["uat.typeart"].ToString() == "tesisd")
                            {
                                tipo = "Tesis Doctorado";
                            }
                            else
                                if (drseldatos["uat.typeart"].ToString() == "articulo")
                                {
                                    tipo = "Artículo";
                                }
                                else
                                    if (drseldatos["uat.typeart"].ToString() == "capitulo")
                                    {
                                        tipo = "Capítulo Libro";
                                    }
                                    else
                                        if (drseldatos["uat.typeart"].ToString() == "libro")
                                        {
                                            tipo = "Libro";
                                        }
                                        else
                                        {
                                            tipo = "Otro";
                                        }
                        sb.Append("<tr>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["nuevoid"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + "123456789/" + drseldatos["coleccion"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.audience[es_ES]"].ToString() + "</td>");

                        // Quitar los 1 que están en el nombre para verificar si están dados de alta en conacyt
                        string asesor = string.Empty;

                        if (drseldatos["dc.contributor.advisor"].ToString() != string.Empty)
                        {
                            string s = drseldatos["dc.contributor.advisor"].ToString().Replace("||", "¿");
                            string[] subs = s.Split('¿');                            

                            foreach (var sub in subs)
                            {
                                string[] ss = sub.Split(';');

                                if (sub.Equals(subs.Last()))
                                {
                                    asesor += ss[0].Replace("1", string.Empty);
                                    asesor += ";" + ss[1];
                                }
                                else
                                {
                                    asesor += ss[0].Replace("1", string.Empty);
                                    asesor += ";" + ss[1] + "||";
                                }
                            }
                        }
                        
                        sb.Append("<td class=\"align-middle\">" + asesor + "</td>");

                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.coverage[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.date.embargoend"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.date.issued"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.description.abstract[es_ES]"].ToString() + "</td>");
                        //sb.Append("<td class=\"align-middle\">" + drseldatos["dc.description.sponsorship"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.identifier.isbn[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.language.iso[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.publisher[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.relation[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.rights.uri[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.rights[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.source"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.subject.classification[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.subject[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.title[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + tipo + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.arbit[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.area[es_ES]"].ToString() + "</td>");

                        // Quitar los 1 que están en el nombre para verificar si están dados de alta en conacyt
                        string autor = string.Empty;

                        if (drseldatos["uat.autor"].ToString() != string.Empty)
                        {
                            string s = drseldatos["uat.autor"].ToString().Replace("||", "¿");
                            string[] subs = s.Split('¿');

                            foreach (var sub in subs)
                            {
                                string[] ss = sub.Split(';');

                                if (sub.Equals(subs.Last()))
                                {
                                    autor += ss[0].Replace("1", string.Empty);
                                    autor += ";" + ss[1];
                                }
                                else
                                {
                                    autor += ss[0].Replace("1", string.Empty);
                                    autor += ";" + ss[1] + "||";
                                }
                            }
                        }

                        sb.Append("<td class=\"align-middle\">" + autor + "</td>");
                        
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.edition[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.email[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.grade[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.institucion"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.numid"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.origen"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.patent"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.printing[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.project"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.range[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.relation.url"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.sheets[es_ES]"].ToString() + "</td>");
                        //sb.Append("<td class=\"align-middle\">" + drseldatos["uat.tipocollaborator[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.tipoproyecto[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.type[es_ES"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.typemon"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.number[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.vol[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["dc.title.alternative[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.campo[es_ES]"].ToString() + "</td>");
                        sb.Append("<td class=\"align-middle\">" + drseldatos["uat.disciplina[es_ES]"].ToString() + "</td>");
                        sb.Append("</tr>");
                    }
                    if (drseldatos.HasRows)
                    {
                        sb.Append("</tbody></table></div>");
                    }
                    else
                    {
                        sb.Append("<td colspan=\"42\" style=\"text-align: center;\">No hay productos disponibles para exportar.</td></tbody></table></div>");
                    }
                    drseldatos.Close();
                }
            }
            Conn.Close();
            return sb.ToString();
        }
    }

    [WebMethod]
    public static string ActExport()
    {
        int Exitoso = 0;
        using (SqlConnection con = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("ActExport", con))
            {
                comand.CommandType = CommandType.StoredProcedure;
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