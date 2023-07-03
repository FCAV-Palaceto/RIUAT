using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;

/// <summary>
/// Descripción breve de RestClient
/// </summary>
public class RestClient
{
    public string Url { get; set; }
       
    public string UserName { get; set; }
    public string UserPassword { get; set; }

    public RestClient()
    {           
    }

    public string Request()
    {
        string strResponseValue = string.Empty;

        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(Url);

        request.Method = "GET";

        String authHeaer = System.Convert.ToBase64String(System.Text.ASCIIEncoding.ASCII.GetBytes(UserName + ":" + UserPassword));
        request.Headers.Add("Authorization", "Basic" + " " + authHeaer);

        HttpWebResponse response = null;

        try
        {
            response = (HttpWebResponse)request.GetResponse();


            //Proecess the resppnse stream... (could be JSON, XML or HTML etc..._

            using (Stream responseStream = response.GetResponseStream())
            {
                if (responseStream != null)
                {
                    using (StreamReader reader = new StreamReader(responseStream))
                    {
                        strResponseValue = reader.ReadToEnd();
                    }                
                }
            }
        }
        catch (Exception ex)
        {
            strResponseValue = "{\"errorMessages\":[\"" + ex.Message.ToString() + "\"],\"errors\":{}}";
        }
        finally
        {
            if (response != null)
            {
                ((IDisposable)response).Dispose();
            }
        }

        return strResponseValue;
        }

    }

    public class Investigador
    {

        public string curp { get; set; }

        public string fechaNacCons { get; set; }
        public string idCvuConacyt { get; set; }
        public string idIdentificadorCa { get; set; }
        public string nombres { get; set; }
        public string primerApellido { get; set; }
        public string segundoApellido { get; set; }
        public string rn { get; set; }
        public string idOrcid { get; set; }        

    }