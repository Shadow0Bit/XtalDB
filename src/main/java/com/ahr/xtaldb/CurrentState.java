package com.ahr.xtaldb;

import java.sql.SQLException;

public class CurrentState {
    static private User loggedUser = null;
    static private UserInfo userInfo = null;
    static private Product focusedOnProduct = null;


    static void setLoggedUser(User user) throws SQLException {
        if (loggedUser == null) {
            loggedUser = user;
            userInfo = DatabaseUtils.getUserInfo(user);
        }
    }

    static void setFocusOnProduct(Product product) {
        focusedOnProduct = product;
    }

    static Product getFocusedProduct() { return focusedOnProduct; }
    static User getLoggedUser() { return loggedUser; }
    static UserInfo getUserInfo() { return userInfo; }
}
