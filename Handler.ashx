<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.IO;
using System.Net;
using System.Text;

public class Handler : IHttpHandler, System.Web.SessionState.IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "application/json";

        if (context.Request.Files.Count > 0)
            {
                string idproducto = Convert.ToString(HttpContext.Current.Session["idproducto"]);
                string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/"+ idproducto +"/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                HttpFileCollection files = context.Request.Files;
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];
                    string fname = context.Server.MapPath("~/Uploads/" + idproducto + "/" + file.FileName);

                    file.SaveAs(fname);

                    string nombreArchivo = file.FileName;
                    string extension = Path.GetExtension(nombreArchivo);
                    string tamano = file.ContentLength.ToString();

                    fname = fname.Replace(@"C:\inetpub\wwwroot\FormsRIUAT\", "");
                    fname = fname.Replace(@"\", "/");

                    if (extension == ".pdf"){
                        extension = "pdf";
                    } else if (extension == ".jpg" || extension == ".png" || extension == ".jfif" || extension == ".jpeg"){
                        extension = "image";
                    } else if (extension == ".doc" || extension == ".docx" || extension == ".ppt" || extension == ".pptx" || extension == ".xls" || extension == ".xlsx"){
                        extension = "office";
                    } else if (extension == ".mp4"){
                        extension = "video";
                    } else {
                        extension = "otros";
                    }

                    context.Response.Write("{\"initialPreview\": [\""+fname+"\"], \"initialPreviewConfig\": [{ \"type\": \""+extension+"\", \"size\": \""+tamano+"\", \"caption\": \""+nombreArchivo+"\", \"url\": \"Handler_delete.ashx\", \"key\": \""+nombreArchivo+"\"}], \"initialPreviewDownloadUrl\": \"Uploads/"+idproducto+"/{filename}\",  \"append\": true }");
                }

                //context.Response.Write("{}");

            }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}