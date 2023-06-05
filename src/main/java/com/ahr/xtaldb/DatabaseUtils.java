package com.ahr.xtaldb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseUtils {
    private static Connection connection;

    public static void connect() {
        try {
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ahr", "ahr", "ahr");
            PreparedStatement pstm = connection.prepareStatement("select * from idprojekt.genres;");
        } catch (SQLException e) {
            System.out.println("Eskeeeel");
            System.out.println(e);
            return;
        }
    }

    public static boolean authUser(String username, String password) throws SQLException{
        PreparedStatement pstm = connection.prepareStatement("select password from idprojekt.users where username=?;");
        pstm.setString(1, username);
        ResultSet result = pstm.executeQuery();
        while (result.next()) {
            if(result.getString("password").equals(password)) return true;
        }
        return false;
    }
}
