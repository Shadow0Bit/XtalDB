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
import java.util.LinkedList;
import java.util.Random;
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
        productList.setCellFactory(param -> new ListCell<String>() {
            @Override
            protected void updateItem(String item, boolean empty) {
                super.updateItem(item, empty);

                if (empty || item == null) {
                    setText("");
                } else {
                    setText(item);
                }
            }
        });
    }

    public void search(ActionEvent actionEvent) {
        LinkedList<String> products = new LinkedList<String>();
        byte[] array = new byte[100];
        for (int i = 0; i < 1000; i++) {
            new Random().nextBytes(array);
            products.add(new String(array, StandardCharsets.UTF_8));
        }

        productList.getItems().addAll(products);
    }

    public void goToProfile(ActionEvent actionEvent) throws IOException {//ty chuju XDDDDDDDD
        SceneSwitchingUtils.switchScene(actionEvent, "userprofile-view.fxml");
    }


}
