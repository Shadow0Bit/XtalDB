package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.Initializable;
import javafx.scene.control.*;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class UserprofileController implements Initializable {
    public Label usernameLabel;
    public Label balance;
    public Label userIDLabel;
    public ListView<Product> productList, achievementsList, wishlist;
    public Button homeButton;
    public Button friendsPageButton;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        usernameLabel.setText(CurrentState.getLoggedUser().username);
        userIDLabel.setText("#" + String.valueOf(CurrentState.getLoggedUser().id));

        productList.setCellFactory(param -> templateList);
        wishlist.setCellFactory(param -> templateList);

        productList.getItems().addAll(CurrentState.getUserInfo().products);
        wishlist.getItems().addAll(CurrentState.getUserInfo().products);
    }

    ListCell<Product> templateList = new ListCell<Product>() {
        @Override
        protected void updateItem(Product item, boolean empty) {
            super.updateItem(item, empty);

            if (empty || item == null) {
                setText("");
            } else {
                setText(item.name);
            }
        }
    };

    public void goHome(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "landingpage-view.fxml");
    }

    public void goToFriendsPage(ActionEvent actionEvent) throws IOException {
        SceneSwitchingUtils.switchScene(actionEvent, "friends-view.fxml");
    }
}
