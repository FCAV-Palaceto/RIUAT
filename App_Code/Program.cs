using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Configuration;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
//using System.Text.Json;
//using Newtonsoft.Json;

/// <summary>
/// Descripción breve de Program
/// </summary>
/// 
//quitar el public y dejar solo class Program
public class Program
{
    static void Main(string[] args)
    {
        var serializer = new JavaScriptSerializer();
        RestClient rClient = new RestClient();

        rClient.UserName = ConfigurationManager.AppSettings["user"];
        rClient.UserPassword = ConfigurationManager.AppSettings["password"];

        ConsultorRepositorio repositorio = new ConsultorRepositorio(rClient);


        //Consultar por nombre
        string nombre = "Demian Abrego";

        string resultado = repositorio.BuscarPorNombre(nombre);
        List<Investigador> investigadoresList = serializer.Deserialize<List<Investigador>>(resultado);

        //Consultar por orcid
        string orcid = "0000-0001-5229-0642";

        string resultado2 = repositorio.BuscarPorOrcid(orcid);
        List<Investigador> investigadoresResultList = serializer.Deserialize<List<Investigador>>(resultado2);

        //Consultar por cvu
        string cvu = "828";

        string resultado3 = repositorio.BuscarPorCvu(cvu);
        List<Investigador> investigadoresResult3List = serializer.Deserialize<List<Investigador>>(resultado3);

        //Consultar por curp
        string curp = "AICL490810HDFRNR03";

        string resultado4 = repositorio.BuscarPorCurp(curp);
        List<Investigador> investigadoresResult4List = serializer.Deserialize<List<Investigador>>(resultado4);
	}
}