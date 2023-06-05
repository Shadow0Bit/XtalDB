package com.ahr.xtaldb;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;

import java.io.IOException;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.Random;
import java.util.ResourceBundle;

public class LandingpageController implements Initializable {

    @FXML
    public TextField searchBar;
    @FXML
    public Button searchButton;
    @FXML
    public ListView<Product> productList;
    @FXML
    public Label balance;
    @FXML
    public Button profileButton;

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        productList.setCellFactory(param -> new ListCell<Product>() {
            @Override
            protected void updateItem(Product item, boolean empty) {
                super.updateItem(item, empty);

                if (empty || item == null) {
                    setText("");
                } else {
                    setText(item.name);
                }
            }
        });

        try {
            productList.getItems().addAll(DatabaseUtils.getProducts());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void search(ActionEvent actionEvent) throws SQLException {
        productList.getItems().clear();
        productList.getItems().addAll(DatabaseUtils.getProducts(searchBar.getText()));
    }

    public void goToProfile(ActionEvent actionEvent) throws IOException {//ty chuju XDDDDDDDD
        SceneSwitchingUtils.switchScene(actionEvent, "userprofile-view.fxml");
    }


}
