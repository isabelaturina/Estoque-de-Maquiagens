<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <form method="post" action="listar.jsp">
         </form>
    </head>
    <body>
      <%
int id;
String Nome;
String Marca;
String preco;

id = Integer.parseInt(request.getParameter("id"));
Nome = request.getParameter("Nome");
Marca = request.getParameter("Marca");
preco = request.getParameter("Preco");

// Conecta ao banco de dados
Connection conecta;
PreparedStatement pst;

Class.forName("com.mysql.cj.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/estoque_maquiagem";
String user = "root";
String password = "";

conecta = DriverManager.getConnection(url, user, password);

// Instrução SQL
String sql = "UPDATE produtos SET Nome=?, Marca=?,Preco=? WHERE id=?";
pst = conecta.prepareStatement(sql);

pst.setString(1, Nome);
pst.setString(2, Marca);
pst.setString(3, preco);
pst.setInt(4, id);

try {
    int resultado = pst.executeUpdate();
   
    
    if (resultado > 0) {
        out.print("Alterações salvas com sucesso!");
    } else {
        out.print("Erro ao salvar alterações.");
    }
} catch (SQLException e) {
    out.print("Erro: " + e.getMessage());

} finally {
    conecta.close();
}
%>
<button type="button" onclick="window.location.href='listar.jsp'">Voltar</button>
    </body>
</html>