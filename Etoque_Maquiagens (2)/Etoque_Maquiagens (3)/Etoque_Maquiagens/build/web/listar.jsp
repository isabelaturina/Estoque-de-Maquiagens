<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lista de Produtos</title>
    <link rel="stylesheet" href="listar.css">
    
</head>
<body>
<%
    try {
        // Conexão com o banco de dados
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/estoque_maquiagem";
        String user = "root";
        String password = "";
        conecta = DriverManager.getConnection(url, user, password);

        // Executar consulta SQL para obter dados da tabela produtos
        String sql = "SELECT * FROM produtos";
        st = conecta.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
%>
    <div class="interior_tabela">
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Nome</th>
                <th>Marca</th>
                <th>Preço</th>
                <th colspan="2">Ações</th> <!-- Unify 'Alterar' and 'Excluir' in a single column -->
            </tr>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("nome") %></td>
                <td><%= rs.getString("marca") %></td>
                <td><%= rs.getDouble("preco") %></td>
                <td>
                    <a href="alterar.jsp?id=<%= rs.getInt("id") %>">Alterar</a> |
                    <a href="excluir.jsp?id=<%= rs.getInt("id") %>">Excluir</a>
                    
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
<%
    } catch (Exception x) {
        out.print("Mensagem de erro: " + x.getMessage());
    }
%>
</body>
</html>
