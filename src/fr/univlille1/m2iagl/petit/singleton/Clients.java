package fr.univlille1.m2iagl.petit.singleton;

import java.util.ArrayList;
import java.util.List;

import fr.univlille1.m2iagl.petit.Client;
import fr.univlille1.m2iagl.petit.singleton.itf.SingletonItf;

public class Clients implements SingletonItf {

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
