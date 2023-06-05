package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

import java.net.URL;
import java.util.ResourceBundle;

public class SignupController implements Initializable {

    @FXML
    public Button logInButton, signUpButton;
    @FXML
    public TextField usernameTextbox, emailTextbox;
    @FXML
    public PasswordField passwordTextbox;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
    }

    public void signUp(ActionEvent actionEvent) {
    }

    public void goToLogin(ActionEvent actionEvent) {
    }
}
