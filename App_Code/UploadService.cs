using System;
using System.Web;
using System.Web.Services;
using System.IO;
using System.Net;

/// <summary>
/// Summary description for UploadService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class UploadService : System.Web.Services.WebService {

    public UploadService()
    {
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public void UploadFiles()
    {
        //Create the Directory.
        string folderPath = HttpContext.Current.Server.MapPath("~/Uploads/");
        if (!Directory.Exists(folderPath))
        {
            Directory.CreateDirectory(folderPath);
        }

        //Fetch the File.
        HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

        //Fetch the File Name.
        string fileName = HttpContext.Current.Request.Form["fileName"] + Path.GetExtension(postedFile.FileName);

        //Save the File.
        postedFile.SaveAs(folderPath + fileName);

        //Send OK Response to Client.
        HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
        HttpContext.Current.Response.Write(fileName);
        HttpContext.Current.Response.Flush();
    }
}

