<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salvar</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <a class="voltar" href="index.html">Voltar</a>
        <%
            String Nome = request.getParameter("Nome");
            String Marca = request.getParameter("Marca");
            String Preco = request.getParameter("Preco");

            if (Nome != null && Marca != null && Preco != null) {
                try {
                    // Estabelecendo a conexão com o banco de dados
                    Connection conecta;
                    PreparedStatement st;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/estoque_maquiagem";
                    String user = "root";
                    String password = "";
                    conecta = DriverManager.getConnection(url, user, password);
                    
                    // Query SQL para inserção
                    String sql = "INSERT INTO produtos (Nome, Marca, Preco) VALUES (?, ?, ?)";
                    st = conecta.prepareStatement(sql);
                    
                    // Setando os parâmetros para a query
                    st.setString(1, Nome);
                    st.setString(2, Marca);
                    st.setString(3, Preco);
                    
                    // Executando a atualização
                    st.executeUpdate();
                    
                    // Fechando os recursos
                    st.close();
                    conecta.close();
                    
                    // Mensagem de sucesso
                    out.println("<h2>Produto cadastrado com sucesso!</h2>");
                } catch (SQLException e) {
                    // Exibindo erro, se houver
                    out.println("<h2>Erro ao cadastrar produto: " + e.getMessage() + "</h2>");
                } catch (ClassNotFoundException e) {
                    out.println("<h2>Erro: Driver não encontrado!</h2>");
                }
            } else {
                out.println("<h2>Dados inválidos. Por favor, preencha todos os campos.</h2>");
            }
        %>
    </body>
</html>
