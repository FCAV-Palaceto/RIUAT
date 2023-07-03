<%@ WebHandler Language="C#" Class="Handler_delete" %>

using System;
using System.IO;
using System.Web;
using System.Web.SessionState;
using System.Text;
using System.Net;

public class Handler_delete : IHttpHandler, IReadOnlySessionState {

    public void ProcessRequest (HttpContext context) {
        string idproducto = Convert.ToString(HttpContext.Current.Session["idproducto"]);

        // Obtener la lista de archivos en la carpeta
        DirectoryInfo dir = new DirectoryInfo(HttpContext.Current.Server.MapPath("~/Uploads/"+idproducto+"/"));

        // Guarda los archivos en un array
        FileInfo[] files = dir.GetFiles();

        // Recupera el key del archivo
        HttpRequest request = context.Request;
        string archivo = request["key"];

        foreach (FileInfo item in files){
            if (item.Name == archivo){
                // Obtener la ruta del archivo
                string ruta = item.FullName;
                //Borra el archivo
                File.Delete(ruta);
            }
        }

        context.Response.ContentType = "application/json";
        context.Response.Write("{}");
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}