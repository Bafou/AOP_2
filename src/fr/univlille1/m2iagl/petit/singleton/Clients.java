package fr.univlille1.m2iagl.petit.singleton;

import java.util.ArrayList;
import java.util.List;

import fr.univlille1.m2iagl.petit.Client;

/**
 * Clients manages all clients of the application.
 * 
 * @author PETIT Antoine
 *
 */
public class Clients {

	protected List<Client> allClient;

	public void addClient(final Client client) {
		allClient.add(client);
	}

	public void delClient(final Client client) {
		allClient.remove(client);
	}

	public Clients() {
		super();
		allClient = new ArrayList<Client>();
	}

}
