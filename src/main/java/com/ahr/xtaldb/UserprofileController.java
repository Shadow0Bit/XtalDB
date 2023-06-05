package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class UserprofileController implements Initializable {
    public Label usernameLabel;
    public Label balance;
    public Label userIDLabel;
    public ListView<String> productList, achivementsList, wishlist;
    public Button homeButton;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }

    public void goHome(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "landingpage-view.fxml");
    }
}
