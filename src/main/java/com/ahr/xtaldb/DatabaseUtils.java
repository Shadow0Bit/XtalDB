package com.ahr.xtaldb;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
        } catch (SQLException e) {
            System.out.println("Eskeeeel");
            System.out.println(e);
            return;
        }
    }

    public static int authUser(String username, String password) throws SQLException, NoSuchAlgorithmException{
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        password = new String(digest.digest(password.getBytes(StandardCharsets.UTF_8)), StandardCharsets.UTF_8);
        PreparedStatement pstm = connection.prepareStatement("select password, user_id from idprojekt.users where username=?;");
        pstm.setString(1, username);
        ResultSet result = pstm.executeQuery();
        while (result.next()) {
            if(result.getString("password").equals(password)) return result.getInt("user_id");
        }
        return -1;
    }

    public static int addUser(String username, String email, String password) throws SQLException, NoSuchAlgorithmException{
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        password = new String(digest.digest(password.getBytes(StandardCharsets.UTF_8)), StandardCharsets.UTF_8);
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

    public static String getUser(int id) throws SQLException {
        PreparedStatement pstm = connection.prepareStatement("select username from idprojekt.users where user_id=?;");
        pstm.setInt(1, id);
        ResultSet result = pstm.executeQuery();
        result.next();
        return result.getString("username");
    }

    public static String getProduct(int id) throws SQLException {
        PreparedStatement pstm = connection.prepareStatement("select name from idprojekt.products where product_id=?;");
        pstm.setInt(1, id);
        ResultSet result = pstm.executeQuery();
        result.next();
        return result.getString("name");
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

    public static LinkedList<Product> getProducts(String s) throws SQLException {
        LinkedList<Product> output = new LinkedList<>();
        PreparedStatement pstm = connection.prepareStatement("select * from idprojekt.productIDview where name like ?;");
        pstm.setString(1, s);
        ResultSet result = pstm.executeQuery();
        while(result.next()){
            output.add(new Product(result.getString("name"), result.getInt("product_id")));
        }
        return output;
    }

    public static UserInfo getUserInfo(User user) throws SQLException{
        UserInfo out = new UserInfo();
        out.user = user;

        LinkedList<Product> products = new LinkedList<>();
        PreparedStatement pstm = connection.prepareStatement("select idprojekt.usersProducts(?);");
        pstm.setInt(1, user.id);
        ResultSet result = pstm.executeQuery();
        while(result.next()){
            int pid = result.getInt("usersproducts");
            products.add(new Product(getProduct(pid), pid));
        }
        out.products = products;
        
        pstm = connection.prepareStatement("select wallet from idprojekt.users where user_id = ?;");
        pstm.setInt(1, user.id);
        result = pstm.executeQuery();
        result.next();
        out.money = result.getFloat("wallet");

        LinkedList<Product> wishlist = new LinkedList<>();
        pstm = connection.prepareStatement("select idprojekt.wishList(?);");
        pstm.setInt(1, user.id);
        result = pstm.executeQuery();
        while(result.next()){
            int pid = result.getInt("usersproducts");
            wishlist.add(new Product(getProduct(pid), pid));
        }
        out.wishlist = wishlist;

        return out;
    };
}
