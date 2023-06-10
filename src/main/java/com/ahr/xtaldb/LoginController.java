package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

import java.io.IOException;
import java.net.URL;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class LoginController implements Initializable {

    @FXML
    Label warningLabel;
    @FXML
    Button logInButton, signUpButton;
    @FXML
    TextField usernameTextbox, passwordTextbox;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }

    public void logIn(ActionEvent actionEvent) throws IOException, SQLException, NoSuchAlgorithmException {
        int userId = DatabaseUtils.authUser(usernameTextbox.getText(), passwordTextbox.getText());
        if (userId != -1) {
            CurrentState.setLoggedUser(new User(userId, DatabaseUtils.getUser(userId)));
            SceneSwitchingUtils.switchScene(actionEvent, "landingpage-view.fxml");
        } else {
            usernameTextbox.clear();
            passwordTextbox.clear();
            warningLabel.setVisible(true);
        }
    }

    public void goToSignUp(ActionEvent actionEvent) throws IOException {
        warningLabel.setVisible(false);
        SceneSwitchingUtils.switchScene(actionEvent, "signup-view.fxml");
    }
}

