module com.ahr.xtaldb {
    requires javafx.controls;
    requires javafx.fxml;

    requires org.controlsfx.controls;
    requires org.kordamp.bootstrapfx.core;

    requires java.sql;

    opens com.ahr.xtaldb to javafx.fxml;
    exports com.ahr.xtaldb;
}