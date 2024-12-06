<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar Produtos</title>
            <link rel="stylesheet" href="alterar.css">
    </head>
    <body>
        <h1>Alterar produtos</h1>
        <%
            // Recebe o ID do produto a alterar e armazena na variável "id"
            int id;
            String idParam = request.getParameter("id");
            String mensagemErro = null;

            // Verifica se o parâmetro ID é válido
            if (idParam != null && !idParam.isEmpty()) {
                id = Integer.parseInt(idParam);
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/estoque_maquiagem";
                String user = "root";
                String password = "";
                conecta = DriverManager.getConnection(url, user, password);
                
                // Busca o produto pelo código recebido
                String sql = "SELECT * FROM produtos WHERE id=?";
                st = conecta.prepareStatement(sql);
                st.setInt(1, id);
                ResultSet resultado = st.executeQuery();
                
                // Verifica se o produto foi encontrado
                if (!resultado.next()) { 
                    mensagemErro = "<p style='color:red;font-size:25px'>Produto não encontrado</p>";
                } else {
                    // Armazena os dados do produto se encontrado
                    String nome = resultado.getString("Nome");
                    String marca = resultado.getString("Marca");
                    String preco = resultado.getString("Preco");
        %>
           
        <form method="post" action="alterar_produtos.jsp">
            <p>
                <label for="id">ID:</label>
                <input type="number" name="id" id="id" value="<%= resultado.getString("id") %>" readonly>
            </p>
            <p>
                <label for="Name">Nome:</label>
                <input type="text" name="Nome" id="Nome" value="<%= resultado.getString("Nome") %>">
            </p>
            <p>
                <label for="Marca">Marca:</label>
                <input type="text" name="Marca" id="Marca" value="<%= resultado.getString("Marca") %>">
            </p>
            <p>
                <label for="Preco">Preco:</label>
                <input type="double" name="Preco" id="Preco" value="<%= resultado.getString("Preco") %>">
            </p>
            <p>
               <div class="botoes">
 
           <button id="salvar">Salvar</button>
             <button type="button" onclick="window.location.href='listar.jsp'">Cancelar</button>
</div>

            </p>
        </form>
            


        <%
                }
                // Fecha a conexão com o banco de dados
                conecta.close();
            } else {
                mensagemErro = "ID inválido.";
            }

            // Exibe mensagem de erro se houver
            if (mensagemErro != null) {
                out.print("<p style='color:red;'>" + mensagemErro + "</p>");
            }
        %>
    </body>
</html>