package api;

import br.com.becker.restapi.RestAPIConnectionFactory;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author Jonata Becker
 */
public class APIConnectionFactory implements RestAPIConnectionFactory {

    /** Driver do JDBC */
    private static final String driverJdbc;
    /** URL completa para conexão */
    private static final String url;
    /** Database da conexão */
    private static final String database;
    /** Usuário para conexão */
    private static final String usuario;
    /** Senha para conexão */
    private static final String senha;
    
    static {
        driverJdbc = "com.mysql.jdbc.Driver";
        url = "jdbc:mysql://localhost:3306";
        database = "sicla";
        usuario = "root";
        senha = "";
        registraDriver();
    }
    
    @Override
    public Connection getConnection() throws SQLException {
        Properties prop = new Properties();
        prop.setProperty("user", usuario);
        prop.setProperty("password", senha);
        prop.setProperty("autoReconnect", "true");
        Connection conn = DriverManager.getConnection(getURLCompleta(), prop);
        conn.setAutoCommit(false);
        return conn;
    }
 
    /**
     * Retorna a URL completa da base de dados (jdbc:.../database)
     *
     * @return String
     */
    private static String getURLCompleta() {
        if (url.endsWith("/") && database.startsWith("/")) {
            return url + database.substring(1, database.length());
        } else if (!url.endsWith("/") && !database.startsWith("/")) {
            return url + "/" + database;
        } else {
            return url + database;
        }
    }

    /**
     * Registra a classe do Driver JDBC
     */
    private static void registraDriver() {
        try {
            Class.forName(driverJdbc);
        } catch (ClassNotFoundException ex) {
            throw new RuntimeException("Problema ao registrar o driver: " + ex.getMessage(), ex);
        }
    }    
    
}
