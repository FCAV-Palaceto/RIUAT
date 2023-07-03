using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{

    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public List<Investigador> GetAuthor(string term)
    {        
        var serializer = new JavaScriptSerializer();
        RestClient rClient = new RestClient
        {
            UserName = ConfigurationManager.AppSettings["user"],
            UserPassword = ConfigurationManager.AppSettings["password"]
        };

        ConsultorRepositorio repositorio = new ConsultorRepositorio(rClient);

        //Consultar por nombre y luego sin el certificado
        string resultado = repositorio.BuscarPorNombre(term);
        List<Investigador> investigadoresList = serializer.Deserialize<List<Investigador>>(resultado);

        if (investigadoresList.Count != 0)
        {
            return investigadoresList;
        }
        else
        {
            resultado = repositorio.BuscarPorNombre2(term);
            investigadoresList = serializer.Deserialize<List<Investigador>>(resultado);

            return investigadoresList;
        }

        
    }

    [WebMethod]
    public List<Investigador> ObtenAutor(string term)
    {
        var serializer = new JavaScriptSerializer();
        RestClient rClient = new RestClient
        {
            UserName = ConfigurationManager.AppSettings["user"],
            UserPassword = ConfigurationManager.AppSettings["password"]
        };

        ConsultorRepositorio repositorio = new ConsultorRepositorio(rClient);

        List<Investigador> investigadoresResultList = new List<Investigador>();

        //Consultar por orcid
        //string orcid = "0000-0001-5229-0642";
        string resultado2 = repositorio.BuscarPorOrcid(term);
        investigadoresResultList = serializer.Deserialize<List<Investigador>>(resultado2);

        if (investigadoresResultList.Count != 0) {
            return investigadoresResultList;           
        } else {
            resultado2 = repositorio.BuscarPorOrcid2(term);
            investigadoresResultList = serializer.Deserialize<List<Investigador>>(resultado2);

            if (investigadoresResultList.Count != 0) {
                return investigadoresResultList;
            } else {
                //Consultar por cvu
                //string cvu = "828";
                string resultado3 = repositorio.BuscarPorCvu(term);
                investigadoresResultList = serializer.Deserialize<List<Investigador>>(resultado3);
                
                if (investigadoresResultList.Count != 0) {
                    return investigadoresResultList;
                } else {
                    resultado3 = repositorio.BuscarPorCvu2(term);
                    investigadoresResultList = serializer.Deserialize<List<Investigador>>(resultado3);
    
                    if (investigadoresResultList.Count != 0) {
                        return investigadoresResultList;
                    } else {
                        //Consultar por curp
                        //string curp = "AICL490810HDFRNR03";
                        string resultado4 = repositorio.BuscarPorCurp(term);
                        investigadoresResultList = serializer.Deserialize<List<Investigador>>(resultado4);
                        
                        if (investigadoresResultList.Count != 0) {
                            return investigadoresResultList;
                        } else {
                            resultado4 = repositorio.BuscarPorCurp2(term);
                            investigadoresResultList = serializer.Deserialize<List<Investigador>>(resultado4);

                            return investigadoresResultList;
                        }
                    }
                }          
            } 
        }   
    }
}
