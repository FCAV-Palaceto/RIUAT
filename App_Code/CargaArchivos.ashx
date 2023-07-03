<%@ WebHandler Language="C#" Class="CargaArchivos" %>

using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.SessionState;
//Guarda el/los archivos en el servidor
public class CargaArchivos : IHttpHandler, IReadOnlySessionState {    
    public void ProcessRequest (HttpContext context) {
        HttpRequest request = context.Request;
        //string ruta = request["ruta"]; // ruta donde se guardará el archivo
        string categoria = request["categoria"]; // Informes
        int per = Convert.ToInt32(request["per"]); // Periodo
        string mat = request["mat"]; // Matricula
        int id = Convert.ToInt32(request["id"]); // id Informe
        
        var formUpload = request.Files.Count > 0;
                
        var xFileName = request.Headers["X-File-Name"];
        var qqFile = request["qqfile"];
        var formFilename = formUpload ? request.Files[0].FileName : null;

        var filename = xFileName ?? qqFile ?? formFilename;
        var inputStream = formUpload ? request.Files[0].InputStream : request.InputStream;
        
        // ruta de carpeta donde se guardarán los archivos
        var filePath = Path.Combine(context.Server.MapPath("~/CargaInformes") + "/" + categoria + "/" + per + "/"+ mat + "/" + id + "/");
        // Se crea la carpeta en caso de que no exista
        Utilidades.CrearDirectorioINE(filePath);
        filePath = Path.Combine(filePath, filename);
        using (var fileStream = File.OpenWrite(filePath))
        {
            inputStream.CopyTo(fileStream);
        }
        context.Response.ContentType = "application/json";
        context.Response.Write("{\"success\":true}");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}