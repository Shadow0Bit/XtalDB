package com.ahr.xtaldb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;

public class DatabaseUtils {
    private static Connection connection;

    public static void connect() {
        try {
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/ahr", "ahr", "ahr");
            PreparedStatement pstm = connection.prepareStatement("select * from idprojekt.genres;");
            getProducts();
        } catch (SQLException e) {
            System.out.println("Eskeeeel");
            System.out.println(e);
            return;
        }
    }

    public static int authUser(String username, String password) throws SQLException{
        PreparedStatement pstm = connection.prepareStatement("select password, user_id from idprojekt.users where username=?;");
        pstm.setString(1, username);
        ResultSet result = pstm.executeQuery();
        while (result.next()) {
            if(result.getString("password").equals(password)) return result.getInt("user_id");
        }
        return -1;
    }

    public static int addUser(String username, String email, String password) throws SQLException{
        PreparedStatement pstm = connection.prepareStatement("select user_id from idprojekt.users where email=?;");
        pstm.setString(1, email);
        ResultSet result = pstm.executeQuery();
        if(result.next()) return -1;
        pstm = connection.prepareStatement("insert into idprojekt.users values (DEFAULT, ?, ?, ?, DEFAULT);");
        pstm.setString(1, username);
        pstm.setString(2, email);
        pstm.setString(3, password);
        pstm.execute();
        pstm = connection.prepareStatement("select user_id from idprojekt.users where email=?;");
        pstm.setString(1, email);
        result = pstm.executeQuery();
        result.next();
        return result.getInt("user_id");
    }

    public static LinkedList<Product> getProducts() throws SQLException {
        LinkedList<Product> output = new LinkedList<>();
        PreparedStatement pstm = connection.prepareStatement("select * from idprojekt.productIDview;");
        ResultSet result = pstm.executeQuery();
        while(result.next()){
            output.add(new Product(result.getString("name"), result.getInt("product_id")));
        }
        return output;
    }
}
