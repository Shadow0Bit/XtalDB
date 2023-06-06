package com.ahr.xtaldb;

public class CurrentState {
    static private User loggedUser = null;
    static private Product focusedOnProduct = null;

    static void setLoggedUser(User user) { if (loggedUser == null) loggedUser = user; }

    static void setFocusOnProduct(Product product) {
        focusedOnProduct = product;
    }

    static Product getFocusedProduct() { return focusedOnProduct; }
    static User getLoggedUser() { return loggedUser; }
}
