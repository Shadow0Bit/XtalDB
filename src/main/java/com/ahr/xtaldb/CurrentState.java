package com.ahr.xtaldb;

public class CurrentState {
    static private User loggedUser;

    static void setLoggedUser(User user) {
        loggedUser = user;
    }

}
