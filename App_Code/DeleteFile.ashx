<%@ WebHandler Language="C#" Class="DeleteFile" %>

using System;
using System.IO;
using System.Web;

public class DeleteFile : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        HttpRequest request = context.Request;
        string ruta = request["rutaArc"];
        ruta = context.Server.MapPath(ruta);
        File.Delete(ruta);        
        context.Response.ContentType = "text/plain";
        context.Response.Write("Eliminado");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}