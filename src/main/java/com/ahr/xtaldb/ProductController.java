package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class ProductController implements Initializable {

    @FXML
    public Label productName, balance, productPriceLabel;
    @FXML
    public Label gameDevsLabel, gamePublisherLabel, quotaLabel, releaseDate, genre, systems, description;
    @FXML
    public Button reviewsButton, homeButton, wishlistButton;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        productName.setText(CurrentState.getFocusedProduct().name);
        balance.setText(CurrentState.getUserInfo().getUserMoney());

    }

    public void goHome(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "landingpage-view.fxml");
    }

    public void goToReviews(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "reviews-view.fxml");
    }

    public void buyProduct(ActionEvent actionEvent) {
    }

    public void addToWishlist(ActionEvent actionEvent) {
    }
}
