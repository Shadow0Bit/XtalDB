package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class FriendsController implements Initializable {
    @FXML
    public TextField userField;
    @FXML
    public Button backButton, searchForFriendsButton;
    @FXML
    public ListView<String> friendsList, userSearchList;
    @FXML
    public Label balance, usernameLabel;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        usernameLabel.setText(CurrentState.getLoggedUser().username);
        balance.setText(CurrentState.getUserInfo().getUserMoney());

    }

    public void goBack(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "userprofile-view.fxml");
    }

    public void searchUsers(ActionEvent actionEvent) {
    }
}
