package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
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

    public void signUp(ActionEvent actionEvent) throws IOException, SQLException {
        DatabaseUtils.addUser(usernameTextbox.getText(), emailTextbox.getText(), passwordTextbox.getText());
        SceneSwitchingUtils.switchScene(actionEvent, "login-view.fxml");
    }

    public void goToLogin(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "login-view.fxml");
    }
}
