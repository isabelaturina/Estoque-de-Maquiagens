<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Exclusão</title>
    <link rel="stylesheet" href="excluir.css">
</head>
<body>
    <div class="container">
        <%
            // Recebe o ID do produto da URL
            String idParam = request.getParameter("id");
            
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    // Converte o ID para inteiro
                    int id = Integer.parseInt(idParam);
                    
                    // Conexão com o banco de dados
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/estoque_maquiagem";
                    String user = "root";
                    String password = "";
                    
                    // Estabelecendo conexão com o banco
                    try (Connection conecta = DriverManager.getConnection(url, user, password);
                         PreparedStatement st = conecta.prepareStatement("DELETE FROM produtos WHERE id=?")) {
                        
                        st.setInt(1, id);  // Passando o ID para a query
                        int resultado = st.executeUpdate();  // Executa a exclusão
                        
                        // Exibe uma mensagem dependendo do resultado
                        if (resultado == 0) {
                            out.print("<p class='error'>O produto não foi encontrado!</p>");
                        } else {
                            out.print("<p class='success'>O produto foi excluído com sucesso!</p>");
                        }
                    }
                } catch (NumberFormatException e) {
                    out.print("<p class='error'>ID inválido!</p>");
                } catch (Exception erro) {
                    out.print("<p class='error'>Erro ao excluir: " + erro.getMessage() + "</p>");
                }
            } else {
                out.print("<p class='error'>ID não informado!</p>");
            }
        %>
        
         <button onclick="location.href='listar.jsp'">Voltar</button>
    </div>
</body>
</html>
