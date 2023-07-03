<%@ WebHandler Language="C#" Class="Handler2" %>

using System;
using System.Web;
using System.Text;
using System.IO;
using System.Net;
using System.Web.SessionState;

public class Handler2 : IHttpHandler, IReadOnlySessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";

        StringBuilder sbArchivos = new StringBuilder();
        string idproducto = Convert.ToString(HttpContext.Current.Session["idproducto"]);

        // Comprobar si existe la carpeta
        if (Directory.Exists(HttpContext.Current.Server.MapPath("~/Uploads/"+idproducto+"/")))
        {
            // Si existen documentos
            DirectoryInfo dir = new DirectoryInfo(HttpContext.Current.Server.MapPath("~/Uploads/"+idproducto+"/"));

            FileInfo[] files = dir.GetFiles();

            if (files.Length > 0)
            {
                sbArchivos.Append("<script>$('#file-5').fileinput('destroy'); $('#file-5').fileinput({ theme: 'fa5', language: 'es', uploadUrl: 'Handler.ashx', maxFileSize: 15360, maxFileCount: 5, overwriteInitial: false, initialPreviewAsData: true, browseOnZoneClick: true, initialPreview: [");
                foreach (FileInfo item in files)
                {
                    string rutaCompleta = item.FullName;
                    //Cuidado con esta ruta
                    rutaCompleta = rutaCompleta.Replace(@"C:\inetpub\wwwroot\FormsRIUAT\", "");
                    rutaCompleta = rutaCompleta.Replace(@"\", "/");

                    sbArchivos.Append("\""+rutaCompleta+"\", ");
                }
                sbArchivos.Append("], initialPreviewConfig: [");
                foreach (FileInfo item in files)
                {
                    string nombreArchivo = item.Name;
                    string extension = Path.GetExtension(nombreArchivo);
                    string tamano = (item.Length).ToString();
                    extension = extension.Replace(".", "");
                    if (extension == "pdf"){
                        sbArchivos.Append("{ type: \""+extension+"\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"Handler_delete.ashx\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "jpg" || extension == "png" || extension == "jfif" || extension == "jpeg"){
                        sbArchivos.Append("{ type: \"image\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"Handler_delete.ashx\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "doc" || extension == "docx" || extension == "ppt" || extension == "pptx" || extension == "xls" || extension == "xlsx"){
                        sbArchivos.Append("{ type: \"office\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"Handler_delete.ashx\", key: \""+nombreArchivo+"\" }, ");
                    } else if (extension == "mp4"){
                        sbArchivos.Append("{ type: \"video\", size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"Handler_delete.ashx\", key: \""+nombreArchivo+"\" }, ");
                    } else {
                        sbArchivos.Append("{ size: \""+tamano+"\", caption: \""+nombreArchivo+"\", url: \"Handler_delete.ashx\", key: \""+nombreArchivo+"\" }, ");
                    }
                }
                sbArchivos.Append("], initialPreviewDownloadUrl: \"Uploads/"+idproducto+"/{filename}\" }).on(\"filepredelete\", function(jqXHR) { var abort = true; if (confirm(\"¿Desea eliminar este archivo?\")) { abort = false; } return abort; });</script>");
            }
            else
            {
                sbArchivos.Append("");
            }
        }
        else
        {
            sbArchivos.Append("");
        }

        context.Response.Write(sbArchivos.ToString());
        context.Response.End();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}