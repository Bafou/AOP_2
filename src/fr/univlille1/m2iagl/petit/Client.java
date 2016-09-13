package fr.univlille1.m2iagl.petit;

import java.util.ArrayList;
import java.util.List;

public class Client {

	protected String name;
	protected String adresse;
	
	public Client(final String name, final String adresse) {
		super();
		this.name = name;
		this.adresse = adresse;
	}

	public String getName() {
		return name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	public String getAdresse() {
		return adresse;
	}

	public void setAdresse(final String adresse) {
		this.adresse = adresse;
	}

}
