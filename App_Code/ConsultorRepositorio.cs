using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Text;
using System.Threading.Tasks;

/// <summary>
/// Descripción breve de ConsultorRepositorio
/// </summary>
public class ConsultorRepositorio
{
    RestClient rClient;

    public ConsultorRepositorio(RestClient rClient)
    {
        this.rClient = rClient;
    }

    // Nombre
    public string BuscarPorNombre(string nombre)
    {
        string str = nombre.Replace(" ", "%20");
        rClient.Url = "https://catalogs.repositorionacionalcti.mx/webresources/persona/byNombreCompleto/params;nombre=" + str;
        return rClient.Request();
    }

    public string BuscarPorNombre2(string nombre)
    {
        string str = nombre.Replace(" ", "%20");
        rClient.Url = "http://catalogs.repositorionacionalcti.mx/webresources/persona/byNombreCompleto/params;nombre=" + str;
        return rClient.Request();
    }

    // Orcid
    public string BuscarPorOrcid(string orcid)
    {
        rClient.Url = "https://catalogs.repositorionacionalcti.mx/webresources/persona/byIdOrcid/params;idOrcid=" + orcid;
        return rClient.Request();

    }

    public string BuscarPorOrcid2(string orcid)
    {
        rClient.Url = "http://catalogs.repositorionacionalcti.mx/webresources/persona/byIdOrcid/params;idOrcid=" + orcid;
        return rClient.Request();

    }

    // CVU
    public string BuscarPorCvu(string cvu)
    {
        rClient.Url = "https://catalogs.repositorionacionalcti.mx/webresources/persona/byCvu/params;cvu=" + cvu;
        return rClient.Request();

    }

    public string BuscarPorCvu2(string cvu)
    {
        rClient.Url = "http://catalogs.repositorionacionalcti.mx/webresources/persona/byCvu/params;cvu=" + cvu;
        return rClient.Request();

    }

    // CUPR
    public string BuscarPorCurp(string curp)
    {
        rClient.Url = "https://catalogs.repositorionacionalcti.mx/webresources/persona/byCurp/params;curp=" + curp;
        return rClient.Request();

    }

    public string BuscarPorCurp2(string curp)
    {
        rClient.Url = "http://catalogs.repositorionacionalcti.mx/webresources/persona/byCurp/params;curp=" + curp;
        return rClient.Request();

    }
}