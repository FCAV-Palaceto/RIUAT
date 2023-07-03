<%@ WebHandler Language="C#" Class="Handler_deleteFolder" %>

using System;
using System.Web;
using System.IO;

public class Handler_deleteFolder : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        // Recupera el id del producto
        HttpRequest request = context.Request;
        string path = request["id"];

        // Cuidado aquí o podría borrar cosas de más
        string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/"+ path +"/");

        if (path != null || path != "")
        {
            Directory.Delete(folderPath, true);
        } 
        else 
        {
            return;
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write("");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}