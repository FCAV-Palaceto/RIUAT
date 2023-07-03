using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Services;

public partial class Producto : System.Web.UI.Page
{    
    public string idProducto, articulo, nombreUsu, tipoUsu, estado;
    protected void Page_Load(object sender, EventArgs e)
    {   
        nombreUsu = Convert.ToString(HttpContext.Current.Session["nombreUsu"]);
        tipoUsu = Convert.ToString(HttpContext.Current.Session["tipoUsu"]);
        // Si no existe sesión regresa al login
        if (nombreUsu.Equals("")){
            HttpContext.Current.Response.Redirect("~/"); 
        }

        //Permisos de cada usuario para ver las pantallas
        //if (!(tipoUsu.Equals("0")))
        //{
        //    HttpContext.Current.Response.Redirect(Session["returnPath"].ToString());
        //}

        // Crea variables tipo de articulo y su id (Editar)
        idProducto = Convert.ToString(HttpContext.Current.Session["idproducto"]);
        articulo = Convert.ToString(HttpContext.Current.Session["articulo"]);
        estado = Convert.ToString(HttpContext.Current.Session["estadoprod"]);

        // Crea la ruta de la página que está
        Session["returnPath"] = Request.RawUrl;
    }

    [WebMethod]
    public static string GuardarProducto(string coleccion, string audiencia, string asesor, string pais, string fechafinalizacion, string fechapublicacion, string resumen, string patrocinador, string isbn, string idioma, string publicador, string citacion, string licencia, string acceso, string descripcion, string dcarea, string palabras, string titulo, string articulo, string arbitrado, string area, string autor, string edicion, string correo, string grado, string institucion, string patente, string url, string candidato, string tiraje, string proyecto, string rango, string datos, string paginas, string colaboracion, string financiamiento, string tipoArticulo, string monografia, string uatnumber, string uatvol, string uattitle, string uatcampo, string uatdisciplina){
        int Exitoso = 0;
        int Estado = 0;
        String idd = "";

        using (SqlConnection Conn = conn.Conecta()){
            if(HttpContext.Current.Session["idproducto"].ToString() == ""){
                using (SqlCommand command = new SqlCommand("AgregarProducto", Conn))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("@idusuario", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idusuario"]);
                    command.Parameters.Add("@estado", SqlDbType.Int).Value = Estado;
                    command.Parameters.Add("@coleccion", SqlDbType.NVarChar, 50).Value = coleccion;
                    command.Parameters.Add("@audiencia", SqlDbType.NVarChar, 100).Value = audiencia;
                    command.Parameters.Add("@asesor", SqlDbType.NVarChar, 500).Value = asesor;
                    command.Parameters.Add("@pais", SqlDbType.NVarChar, 100).Value = pais;
                    command.Parameters.Add("@fechafin", SqlDbType.NVarChar, 50).Value = fechafinalizacion;
                    command.Parameters.Add("@fechapublicacion", SqlDbType.NVarChar, 50).Value = fechapublicacion;
                    command.Parameters.Add("@resumen", SqlDbType.NVarChar, -1).Value = resumen;
                    command.Parameters.Add("@patrocinador", SqlDbType.NVarChar, -1).Value = patrocinador;
                    command.Parameters.Add("@isbn", SqlDbType.NVarChar, 100).Value = isbn;
                    command.Parameters.Add("@idioma", SqlDbType.NVarChar, 100).Value = idioma;
                    command.Parameters.Add("@publicador", SqlDbType.NVarChar, 500).Value = publicador;
                    command.Parameters.Add("@citacion", SqlDbType.NVarChar, -1).Value = citacion;
                    command.Parameters.Add("@licencia", SqlDbType.NVarChar, 100).Value = licencia;
                    command.Parameters.Add("@acceso", SqlDbType.NVarChar, 100).Value = acceso;
                    command.Parameters.Add("@descripcion", SqlDbType.NVarChar, -1).Value = descripcion;
                    command.Parameters.Add("@dcarea", SqlDbType.NVarChar, 500).Value = dcarea;
                    command.Parameters.Add("@palabras", SqlDbType.NVarChar, -1).Value = palabras;
                    command.Parameters.Add("@titulo", SqlDbType.NVarChar, 500).Value = titulo;
                    command.Parameters.Add("@articulo", SqlDbType.NVarChar, 100).Value = articulo;
                    command.Parameters.Add("@arbitrado", SqlDbType.NVarChar, 50).Value = arbitrado;
                    command.Parameters.Add("@area", SqlDbType.NVarChar, 500).Value = area;
                    command.Parameters.Add("@autor", SqlDbType.NVarChar, -1).Value = autor;
                    command.Parameters.Add("@edicion", SqlDbType.NVarChar, 100).Value = edicion;
                    command.Parameters.Add("@email", SqlDbType.NVarChar, -1).Value = correo;
                    command.Parameters.Add("@grado", SqlDbType.NVarChar, 100).Value = grado;
                    command.Parameters.Add("@institucion", SqlDbType.NVarChar, 500).Value = institucion;
                    command.Parameters.Add("@patente", SqlDbType.NVarChar, 500).Value = patente;
                    command.Parameters.Add("@url", SqlDbType.NVarChar, 500).Value = url;
                    command.Parameters.Add("@candidato", SqlDbType.NVarChar, 500).Value = candidato;
                    command.Parameters.Add("@ejemplares", SqlDbType.NVarChar, 50).Value = tiraje;
                    command.Parameters.Add("@proyecto", SqlDbType.NVarChar, -1).Value = proyecto;
                    command.Parameters.Add("@rango", SqlDbType.NVarChar, 50).Value = rango;
                    command.Parameters.Add("@datos", SqlDbType.NVarChar, 500).Value = datos;
                    command.Parameters.Add("@paginas", SqlDbType.NVarChar, 50).Value = paginas;
                    command.Parameters.Add("@colaborador", SqlDbType.NVarChar, 500).Value = colaboracion;
                    command.Parameters.Add("@financiamiento", SqlDbType.NVarChar, 100).Value = financiamiento;
                    command.Parameters.Add("@tipoarticulo", SqlDbType.NVarChar, 500).Value = tipoArticulo;
                    command.Parameters.Add("@monografia", SqlDbType.NVarChar, 100).Value = monografia;
                    command.Parameters.Add("@uatnumber", SqlDbType.NVarChar, 500).Value = uatnumber;
                    command.Parameters.Add("@uatvol", SqlDbType.NVarChar, 500).Value = uatvol;
                    command.Parameters.Add("@uattitlealternative", SqlDbType.NVarChar, 500).Value = uattitle;
                    command.Parameters.Add("@uatcampo", SqlDbType.NVarChar, 500).Value = uatcampo;
                    command.Parameters.Add("@uatdisciplina", SqlDbType.NVarChar, 500).Value = uatdisciplina;

                    SqlParameter pexitoso = command.Parameters.Add("@Exitoso", SqlDbType.Int);
                    SqlParameter pidproducto = command.Parameters.Add("@idproducto", SqlDbType.Int);
                    pexitoso.Direction = ParameterDirection.Output;
                    pidproducto.Direction = ParameterDirection.Output;
                    Conn.Open();
                    command.ExecuteNonQuery();
                    Exitoso = int.Parse(pexitoso.Value.ToString());
                    HttpContext.Current.Session["idproducto"] = pidproducto.Value.ToString();
                    idd = HttpContext.Current.Session["idproducto"].ToString();
                }
            }
            else
            {
                using (SqlCommand command = new SqlCommand("UpdateProducto", Conn))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("@idd", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
                    command.Parameters.Add("@audiencia", SqlDbType.NVarChar, 100).Value = audiencia;
                    command.Parameters.Add("@asesor", SqlDbType.NVarChar, 500).Value = asesor;
                    command.Parameters.Add("@pais", SqlDbType.NVarChar, 100).Value = pais;
                    command.Parameters.Add("@fechafin", SqlDbType.NVarChar, 50).Value = fechafinalizacion;
                    command.Parameters.Add("@fechapublicacion", SqlDbType.NVarChar, 50).Value = fechapublicacion;
                    command.Parameters.Add("@resumen", SqlDbType.NVarChar, -1).Value = resumen;
                    command.Parameters.Add("@patrocinador", SqlDbType.NVarChar, -1).Value = patrocinador;
                    command.Parameters.Add("@isbn", SqlDbType.NVarChar, 100).Value = isbn;
                    command.Parameters.Add("@idioma", SqlDbType.NVarChar, 100).Value = idioma;
                    command.Parameters.Add("@publicador", SqlDbType.NVarChar, 500).Value = publicador;
                    command.Parameters.Add("@citacion", SqlDbType.NVarChar, -1).Value = citacion;
                    command.Parameters.Add("@licencia", SqlDbType.NVarChar, 100).Value = licencia;
                    command.Parameters.Add("@acceso", SqlDbType.NVarChar, 100).Value = acceso;
                    command.Parameters.Add("@descripcion", SqlDbType.NVarChar, -1).Value = descripcion;
                    command.Parameters.Add("@dcarea", SqlDbType.NVarChar, 500).Value = dcarea;
                    command.Parameters.Add("@palabras", SqlDbType.NVarChar, -1).Value = palabras;
                    command.Parameters.Add("@titulo", SqlDbType.NVarChar, 500).Value = titulo;
                    command.Parameters.Add("@articulo", SqlDbType.NVarChar, 100).Value = articulo;
                    command.Parameters.Add("@arbitrado", SqlDbType.NVarChar, 50).Value = arbitrado;
                    command.Parameters.Add("@area", SqlDbType.NVarChar, 500).Value = area;
                    command.Parameters.Add("@autor", SqlDbType.NVarChar, -1).Value = autor;
                    command.Parameters.Add("@edicion", SqlDbType.NVarChar, 100).Value = edicion;
                    command.Parameters.Add("@email", SqlDbType.NVarChar, -1).Value = correo;
                    command.Parameters.Add("@grado", SqlDbType.NVarChar, 100).Value = grado;
                    command.Parameters.Add("@institucion", SqlDbType.NVarChar, 500).Value = institucion;
                    command.Parameters.Add("@patente", SqlDbType.NVarChar, 500).Value = patente;
                    command.Parameters.Add("@url", SqlDbType.NVarChar, 500).Value = url;
                    command.Parameters.Add("@candidato", SqlDbType.NVarChar, 500).Value = candidato;
                    command.Parameters.Add("@ejemplares", SqlDbType.NVarChar, 50).Value = tiraje;
                    command.Parameters.Add("@proyecto", SqlDbType.NVarChar, -1).Value = proyecto;
                    command.Parameters.Add("@rango", SqlDbType.NVarChar, 50).Value = rango;
                    command.Parameters.Add("@datos", SqlDbType.NVarChar, 500).Value = datos;
                    command.Parameters.Add("@paginas", SqlDbType.NVarChar, 50).Value = paginas;
                    command.Parameters.Add("@colaborador", SqlDbType.NVarChar, 500).Value = colaboracion;
                    command.Parameters.Add("@financiamiento", SqlDbType.NVarChar, 100).Value = financiamiento;
                    command.Parameters.Add("@tipoarticulo", SqlDbType.NVarChar, 500).Value = tipoArticulo;
                    command.Parameters.Add("@monografia", SqlDbType.NVarChar, 100).Value = monografia;
                    command.Parameters.Add("@uatnumber", SqlDbType.NVarChar, 500).Value = uatnumber;
                    command.Parameters.Add("@uatvol", SqlDbType.NVarChar, 500).Value = uatvol;
                    command.Parameters.Add("@uattitlealternative", SqlDbType.NVarChar, 500).Value = uattitle;
                    command.Parameters.Add("@uatcampo", SqlDbType.NVarChar, 500).Value = uatcampo;
                    command.Parameters.Add("@uatdisciplina", SqlDbType.NVarChar, 500).Value = uatdisciplina;

                    SqlParameter pexitoso = command.Parameters.Add("@Exitoso", SqlDbType.Int);
                    SqlParameter pidproducto = command.Parameters.Add("@idproducto", SqlDbType.Int);
                    pexitoso.Direction = ParameterDirection.Output;
                    pidproducto.Direction = ParameterDirection.Output;
                    Conn.Open();
                    command.ExecuteNonQuery();
                    Exitoso = int.Parse(pexitoso.Value.ToString());
                    HttpContext.Current.Session["idproducto"] = pidproducto.Value.ToString();
                    idd = HttpContext.Current.Session["idproducto"].ToString();
                }
            }
            
            Conn.Close();            
            return "{\"success\": \"" + idd + "\"}";            
        }        
    }

    [WebMethod]
    public static string ModificaProducto()
    {
        StringBuilder sb = new StringBuilder();
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("SelProductoEditar", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(HttpContext.Current.Session["idproducto"]);
                Conn.Open();
                using (SqlDataReader dr = comand.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        sb.Append("{\"audiencia\": \"" + dr["audiencia"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"asesor\": \"" + dr["asesor"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"pais\": \"" + dr["pais"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"fechafin\": \"" + dr["fechafin"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"fechapublicacion\": \"" + dr["fechapublicacion"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"resumen\": \"" + dr["resumen"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"patrocinador\": \"" + dr["patrocinador"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"isbn\": \"" + dr["isbn"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"idioma\": \"" + dr["idioma"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"publicador\": \"" + dr["publicador"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"citacion\": \"" + dr["citacion"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"licencia\": \"" + dr["licencia"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"acceso\": \"" + dr["acceso"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"descripcion\": \"" + dr["descripcion"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"dcarea\": \"" + dr["dcarea"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"palabras\": \"" + dr["palabras"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"titulo\": \"" + dr["titulo"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"articulo\": \"" + dr["articulo"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"arbitrado\": \"" + dr["arbitrado"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"area\": \"" + dr["area"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"autor\": \"" + dr["autor"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"edicion\": \"" + dr["edicion"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"email\": \"" + dr["email"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"grado\": \"" + dr["grado"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"institucion\": \"" + dr["institucion"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"patente\": \"" + dr["patente"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"url\": \"" + dr["url"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"candidato\": \"" + dr["candidato"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"ejemplares\": \"" + dr["ejemplares"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"proyecto\": \"" + dr["proyecto"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"rango\": \"" + dr["rango"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"datos\": \"" + dr["datos"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"paginas\": \"" + dr["paginas"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"colaborador\": \"" + dr["colaborador"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"financiamiento\": \"" + dr["financiamiento"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"tipoarticulo\": \"" + dr["tipoarticulo"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"monografia\": \"" + dr["monografia"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"uatnumber\": \"" + dr["uatnumber"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"uatvol\": \"" + dr["uatvol"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"uattitlealternative\": \"" + dr["uattitlealternative"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"uatcampo\": \"" + dr["uatcampo"].ToString().Trim().Replace("\\", "\\\\").Replace("\"", "\\\"") + "\", \"uatdisciplina\": \"" + dr["uatdisciplina"].ToString().Trim().Replace("\"", "\\\"") + "\"}").Replace("\n", "");
                    }
                    dr.Close();
                }
            }
            Conn.Close();
        }
        return sb.ToString();
    }

    [WebMethod]
    public static string EliminarProducto(int id)
    {
        int Eliminado = 0;
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("DelProducto", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;
                comand.Parameters.Add("@idProducto", SqlDbType.Int).Value = id;

                SqlParameter peliminado = comand.Parameters.Add("@Eliminado", SqlDbType.Int);
                peliminado.Direction = ParameterDirection.Output;
                Conn.Open();
                comand.ExecuteNonQuery();
                Eliminado = int.Parse(peliminado.Value.ToString());
            }
            Conn.Close();
            return "{\"success\": \"" + Eliminado + "\"}";
        }
    }
}