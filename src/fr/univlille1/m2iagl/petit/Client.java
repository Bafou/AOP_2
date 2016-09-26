package fr.univlille1.m2iagl.petit;

/**
 * A Client has name and adress
 * 
 * @author PETIT Antoine
 *
 */
public class Client {

	protected String name;
	protected String adress;
	
	public Client(final String name, final String adresse) {
		super();
		this.name = name;
		this.adress = adresse;
	}

	public String getName() {
		return name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	public String getAdresse() {
		return adress;
	}

	public void setAdresse(final String adresse) {
		this.adress = adresse;
	}

}
