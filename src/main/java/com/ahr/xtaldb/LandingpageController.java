package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;

import java.net.URL;
import java.util.ResourceBundle;

public class LandingpageController implements Initializable {

    @FXML
    public TextField searchBar;
    @FXML
    public Button searchButton;
    @FXML
    public ListView<String> productList;
    @FXML
    public Label balance;
    @FXML
    public Button profileButton;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }

    public void search(ActionEvent actionEvent) {
    }

    public void goToProfile(ActionEvent actionEvent) {
    }


}
