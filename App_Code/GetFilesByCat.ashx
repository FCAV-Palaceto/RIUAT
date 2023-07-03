<%@ WebHandler Language="C#" Class="GetFilesByCat" %>

using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.SessionState;

public class GetFilesByCat : IHttpHandler, IReadOnlySessionState
{

    public void ProcessRequest(HttpContext context)
    {
        HttpRequest request = context.Request;
        string cat = request["categoria"]; // Informes
        int per = Convert.ToInt32(request["per"]); // Periodo
        string mat = request["mat"]; // Matricula
        int id = Convert.ToInt32(request["id"]); // id Informe

        
        StringBuilder sbArchivos = new StringBuilder();
        if (Directory.Exists(HttpContext.Current.Server.MapPath("~/CargaInformes/" + cat + "/" + per + "/" + mat + "/" + id + "/")))
        {
            // Si existen documentos
            DirectoryInfo dir = new DirectoryInfo(HttpContext.Current.Server.MapPath("~/CargaInformes/" + cat + "/" + per + "/" + mat + "/" + id + "/"));
            FileInfo[] files = dir.GetFiles();
            // Se crea la tabla con los archivos          
            if (files.Length > 0)
            {
                sbArchivos.Append("<table class=\"table table-bordered table-striped\"><thead><tr>"+
                "<th class=\"center\">Archivo</th><th class=\"center\">&Uacute;ltima actualizaci&oacute;n</th><th class=\"center\">Ver</th><th class=\"center\">Eliminar</th></tr></thead><tbody>");
            }
            else
                {
                 sbArchivos.Append("<table class=\"table table-bordered table-striped\"><thead><tr>"+
                "<th class=\"center\">Archivo</th><th class=\"center\">&Uacute;ltima actualizaci&oacute;n</th><th class=\"center\">Ver</th><th class=\"center\">Eliminar</th></tr></thead><tbody>");
                }
            foreach (FileInfo item in files)
            {   
                string rutaCompleta = item.FullName;
                rutaCompleta = rutaCompleta.Replace(@"C:\inetpub\wwwroot\practicasprofesionales\", "../");
                rutaCompleta = rutaCompleta.Replace(@"\", "/");
                
                sbArchivos.Append("<tr>");
                sbArchivos.Append("<td><a class=\"nombreArchivo\" href=\"" + rutaCompleta + "\" target=\"_blank\"><span class=\"label label-info\">" + Path.GetFileNameWithoutExtension(item.Name) + "</span></a></td><td>" +
                    "<span class=\"fechaCreacionArchivo\">" + File.GetCreationTime(HttpContext.Current.Server.MapPath("~/CargaInformes/" + cat + "/" + per + "/" + mat + "/" + id + "/" + item.Name)) + "</span>" +
                    "</td><td class=\"center\"><button type=\"button\" class=\"btn btn-default\"><a target\"_blank\" href=\"" + rutaCompleta + "\" onclick=\"window.open(this.href, this.target, 'width=600,height=700'); return false;\"><span class=\"fas fa-search\"></span></a></button></td><td class=\"center\">"+
                    "<a href=\"#\" class='btn btn-danger'  onclick=\"return deletefile('" + rutaCompleta + "','" + cat + "','" + per + "','" + mat + "','" + id + "'); return false;\" type=\"button\"><span class=\"fas fa-trash\"></span></a></td>");
                sbArchivos.Append("</tr>");                
            }
            if (files.Length > 0)
            {
                sbArchivos.Append("</tbody></table>");
            }
            else
            {
                sbArchivos.Append("<td colspan=\"4\" style=\"text-align: center;\">No hay registros disponibles</td></tbody></table>");
            }
        }
        else
            {
                sbArchivos.Append("<table class=\"table table-bordered table-striped\"><thead><tr>"+
                "<th class=\"center\">Archivo</th><th class=\"center\">&Uacute;ltima actualizaci&oacute;n</th><th class=\"center\">Ver</th><th class=\"center\">Eliminar</th></tr></thead><tbody>");
                sbArchivos.Append("<td colspan=\"4\" style=\"text-align: center;\">No hay registros disponibles.</td></tbody></table>");
            }
        context.Response.ContentType = "text/plain";
        context.Response.Write(sbArchivos.ToString());
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}