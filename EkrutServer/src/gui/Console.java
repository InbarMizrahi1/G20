package gui;

import java.io.IOException;
import java.io.OutputStream;

import javafx.application.Platform;
import javafx.scene.control.TextArea;

public class Console extends OutputStream {
	private TextArea txtConsole;
	
	public Console(TextArea txtConsole) {
		this.txtConsole = txtConsole;
	}
	@Override
	public void write(int b) throws IOException {
		appendText(String.valueOf((char)b));
		
	}
	private void appendText(String valueOf) {
		Platform.runLater(() -> txtConsole.appendText(valueOf));
	}
	

}