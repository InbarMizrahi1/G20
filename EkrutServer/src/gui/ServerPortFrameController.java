package gui;

import java.io.PrintStream;
import java.net.InetAddress;

import entities.ClientConnected;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import server.EchoServer;
import server.ServerUI;

public class ServerPortFrameController {
			ServerPortFrameController myController;
    @FXML
    private TextField txtIP;

    @FXML
    private TextField txtPort;

    @FXML
    private TextField txtDbName;

    @FXML
    private TextField txtDbUser;

    @FXML
    private TextField txtDbPass;

    @FXML
    private TableView<ClientConnected> tblConClients;

    @FXML
    private TableColumn<ClientConnected, String> IP;

    @FXML
    private TableColumn<ClientConnected, String> Host;

    @FXML
    private TableColumn<ClientConnected, String> Status;

    @FXML
    private TextArea txtConsole;

    @FXML
    private Button btnConnect;

    @FXML
    private Button btnDisconnect;

    @FXML
    private Button btnDefault;
    @FXML
    private Button btnExit;

    private PrintStream showConsole;
	
  
	@FXML
	public void clickBtnConnect(ActionEvent event) throws Exception {
		String  ekrutPort, dbName, dbUserName, dbPwd;
		//IP = txtIP.getText();
		ekrutPort = txtPort.getText();
		dbName = txtDbName.getText();
		dbUserName = txtDbUser.getText();
		dbPwd = txtDbPass.getText();

		if (ekrutPort.trim().isEmpty()) {
			System.out.println("You must enter a port number");

		} else {
			// ((Node)event.getSource()).getScene().getWindow().hide(); //hiding primary
			// window
			// Stage primaryStage = new Stage();
			// FXMLLoader loader = new FXMLLoader();
			ServerUI.runServer(ekrutPort, dbName, dbUserName, dbPwd);
			btnConnect.setDisable(true);
			btnDisconnect.setDisable(false);
			EchoServer sv = ServerUI.getSv();
	        tblConClients.setEditable(true);
			tblConClients.setItems(sv.getClientList());
			setCulomns();	
		}
	}

	@FXML
	public void clickbtnDefault(ActionEvent event) {
		txtPort.setText("5555");
		try {
			txtIP.setText(getLocalHost());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		txtDbName.setText("jdbc:mysql://localhost/ekrutdb?serverTimezone=IST");
		txtDbUser.setText("root");
		txtDbPass.setText("Dolev1995");
		

	}
	public void showConsoleStream() {
		showConsole = new PrintStream(new Console(txtConsole));
		System.setOut(showConsole);
		System.setErr(showConsole);
	}

	@FXML
	public void clickbtnDisconnect(ActionEvent event) {
		ServerUI.stopServer();
		btnDisconnect.setDisable(true);
		btnConnect.setDisable(false);
	}

	public void start(Stage primaryStage) throws Exception {
		FXMLLoader loader = new FXMLLoader(getClass().getResource("/gui/ServerPort.fxml"));
		Parent root = loader.load();
		Scene scene = new Scene(root);
		// scene.getStylesheets().add(getClass().getResource("/gui/ServerPort.css").toExternalForm());
		primaryStage.setTitle("Ekrut");
		myController = loader.getController();	

		primaryStage.setScene(scene);
		//showConsoleStream();


		myController.txtPort.setText("5555");
		myController.txtIP.setText(getLocalHost());
		myController.txtDbName.setText("jdbc:mysql://localhost/ekrutdb?serverTimezone=IST");
		myController.txtDbUser.setText("root");
		myController.txtDbPass.setText("Dolev1995");
		myController.btnDisconnect.setDisable(true);
		primaryStage.show();


	}

	public String getLocalHost() throws Exception {
		String localHost = InetAddress.getLocalHost().getHostAddress().toString();
		return localHost;
	}

	public void getExitBtn(ActionEvent event) throws Exception {
		System.out.println("exit Tool");
		System.exit(0);
	}
	
	
	

	public void setCulomns() {
		IP.setCellValueFactory(new PropertyValueFactory<ClientConnected, String>("IP"));
		Host.setCellValueFactory(new PropertyValueFactory<ClientConnected, String>("host"));
		Status.setCellValueFactory(new PropertyValueFactory<ClientConnected, String>("status"));

	}

}