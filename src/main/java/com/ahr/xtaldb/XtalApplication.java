package com.ahr.xtaldb;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import java.io.IOException;

public class XtalApplication extends Application {
    @Override
    public void start(Stage stage) throws IOException {
        DatabaseUtils.connect();

        FXMLLoader fxmlLoader = new FXMLLoader(XtalApplication.class.getResource("login-view.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 1366, 768);
        stage.setResizable(false);
        stage.setTitle("XtalDB");
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}