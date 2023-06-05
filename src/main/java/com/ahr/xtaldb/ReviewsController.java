package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.TextArea;

import java.net.URL;
import java.util.ResourceBundle;

public class ReviewsController implements Initializable {

    @FXML
    public Button homeButton, submitReviewButton;
    @FXML
    public ListView<String> reviewList;
    @FXML
    public TextArea reviewInput;
    @FXML
    public Label usernameLabel, balance;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {

    }

    public void goHome(ActionEvent actionEvent) {
    }

    public void submitReview(ActionEvent actionEvent) {
    }
}
