package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class LoginController implements Initializable {

    @FXML
    Button logInButton, signUpButton;


    @FXML
    TextField usernameTextbox, passwordTextbox;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }

    public void logIn(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "landingpage-view.fxml");
    }

    public void goToSignUp(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "signup-view.fxml");
    }
}

