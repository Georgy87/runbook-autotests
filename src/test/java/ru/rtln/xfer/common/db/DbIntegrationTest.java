package ru.rtln.xfer.common.db;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

abstract class DbIntegrationTest {

    protected Connection connection;

    @BeforeEach
    void setUpConnection() throws SQLException {
        String url = System.getProperty("db.url", "jdbc:postgresql://localhost:5432/gp");
        String user = System.getProperty("db.user", "postgres");
        String password = readRequiredPassword();

        connection = DriverManager.getConnection(url, user, password);
        connection.setAutoCommit(false);
    }

    @AfterEach
    void rollbackAndCloseConnection() throws SQLException {
        if (connection != null) {
            connection.rollback();
            connection.close();
        }
    }

    private String readRequiredPassword() {
        String password = System.getProperty("db.password", System.getenv("DB_PASSWORD"));
        if (password == null || password.isBlank()) {
            throw new IllegalStateException(
                "Передайте пароль БД через -Ddb.password=<local-password> или переменную окружения DB_PASSWORD"
            );
        }
        return password;
    }
}
