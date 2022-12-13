	package GUI;

import java.io.IOException;

import client.ClientUI;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.scene.text.Text;
import javafx.stage.Stage;


public class ConnectFormController {

    @FXML
    private Button btnExit;

    @FXML
    private TextField IPText;

    @FXML
    private Button btnConnect;

    @FXML
    private Text lblEnterIP;
    //@FXML
    //Image image = new Image("FullLogo_Transparent_NoBuffer.png");

    

	private String getIP() {
		return IPText.getText();
	}
	
	@FXML
    void getConnectBtn(ActionEvent event) throws IOException {
    	String ip = IPText.getText();
    	
         
		FXMLLoader loader = new FXMLLoader();
		//commennFunction-בדיקה שלא ריק
    	// Validate
    	if(checkNull(ip)){
    		System.out.println("Please insert text");
    		return; 
    	}
    	/*try {
    		Integer.parseInt(ip);
    	}
    	catch(Exception ex) {
    		System.out.println("Please insert digits only"); 
    		return;
    	}*/
    	ClientUI.setChat(ip,5555);
    	// Establish connection

    	//chat = new ClientController("localhost", Integer.parseInt(ip));


		ClientUI.chat.accept("Connect");  // change later to Message OBJECT 
		
    	// Go to next screen (controller creates the screen)
		((Node)event.getSource()).getScene().getWindow().hide(); //hiding primary window
		Stage primaryStage1 = new Stage();
		AnchorPane root = loader.load(getClass().getResource("/GUI/MenuFormClient.fxml").openStream());
		Scene scene = new Scene(root);			
		//primaryStage1.setTitle("Menu Tool");
		primaryStage1.setScene(scene);		
		primaryStage1.show();
//    	try {
//    		((Node)event.getSource()).getScene().getWindow().hide(); //hiding primary window
//    		Stage primaryStage = new Stage();
//    		Pane root = loader.load(getClass().getResource("/boundary/EditUsersBoundary.fxml"));
//    		//EditUsersController editUsersController = loader.getController();		
//    		
//    		Scene scene = new Scene(root);			
//    		//scene.getStylesheets().add(getClass().getResource("/gui/StudentForm.css").toExternalForm());
//    		primaryStage.setTitle("Edit EKrut Users");
//
//    		primaryStage.setScene(scene);		
//    		primaryStage.show();
//
//        	
//    	}
//    	catch(Exception ex) {
//    		ex.printStackTrace();
//    	}
    	
    }
	public boolean checkNull(String str) {
		if(str!=null)
		  return false;
		return true;
		
	}

	public void start(Stage primaryStage) throws Exception {	
		FXMLLoader loader = new FXMLLoader(getClass().getResource("/GUI/ConnectForm.fxml"));
		Parent root = loader.load();

		Scene scene = new Scene(root);

		primaryStage.setTitle("Connect Form");
		primaryStage.setScene(scene);
		primaryStage.show();	 	   
	}
	 @FXML
	public void getExitBtn(ActionEvent event) throws Exception {
		System.out.println("exit ConnectForm");
		System.exit(0);	
	}
	
}



	

