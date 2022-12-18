// This file contains material supporting section 3.7 of the textbook:

// "Object Oriented Software Engineering" and is issued under the open-source
// license found at www.lloseng.com 

package client;

import java.io.IOException;

import common.ChatIF;
import entities.Subscriber;
import ocsf.client.AbstractClient;

/**
 * This class overrides some of the methods defined in the abstract superclass
 * in order to give more functionality to the client.
 *
 * @author Dr Timothy C. Lethbridge
 * @author Dr Robert Lagani&egrave;
 * @author Fran&ccedil;ois B&eacute;langer
 * @version July 2000
 */
public class ChatClient extends AbstractClient {
	// Instance variables **********************************************

	/**
	 * The interface type variable. It allows the implementation of the display
	 * method in the client.
	 */
	ChatIF clientUI;
	public static Subscriber s1 = new Subscriber(null, null, null, null, null, null, null);
	public static boolean awaitResponse = false;

	// Constructors ****************************************************

	/**
	 * Constructs an instance of the chat client.
	 *
	 * @param host     The server to connect to.
	 * @param port     The port number to connect on.
	 * @param clientUI The interface type variable.
	 */

	public ChatClient(String ip, int port, ChatIF clientUI) throws IOException {
		super(ip, port); // Call the superclass constructor
		this.clientUI = clientUI;
		// openConnection();
	}

	// Instance methods ************************************************

	/**
	 * This method handles all data that comes in from the server.
	 *
	 * @param msg The message from the server.
	 */
	public void handleMessageFromServer(Object msg) {
		System.out.println(msg.toString());
		if (msg instanceof String) {
			String messageFromServer = String.valueOf(msg);

			String[] result = messageFromServer.split("\\s");
			System.out.println(msg.toString());
			if(result.length == 1) {
				System.out.println("ID does not exist!");
				s1.setID("ERROR");
			}
			// System.out.println("Message received: " + messageFromClient + " from " +
			// client);
			else {
				switch (result[0]) {
				case "View":
					s1.setID(result[1]);
					s1.setFirstName(result[2]);
					s1.setLastName(result[3]);
					s1.setPhoneNumber(result[4]);
					s1.setEmailAddress(result[5]);
					s1.setCreditCardNumber(result[6]);
					s1.setSubscriberNumber(result[7]);
					System.out.println("View user");
					break;
				case "update":
					System.out.println("Update user");
					break;

				default:
					break;
				}
			}
			awaitResponse = false;
		}
	}

	/**
	 * This method handles all data coming from the UI
	 *
	 * @param message The message from the UI.
	 */

	public void handleMessageFromClientUI(String message) {

		try {
			openConnection();// in order to send more than one message
			awaitResponse = true;
			sendToServer(message);

			// wait for response
			while (awaitResponse) {
				try {
					Thread.sleep(100);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			clientUI.display("Could not send message to server: Terminating client." + e);
			quit();
		}
	}

	/**
	 * This method terminates the client.
	 */
	public void quit() {
		try {
			closeConnection();
		} catch (IOException e) {
		}
		System.exit(0);
	}
}
//End of ChatClient class