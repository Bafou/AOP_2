package fr.univlille1.m2iagl.petit;

public class Order {

	private static int idCpt = 0;
	
	protected int id;
	protected double amount;

	public void printOrder() {
		System.out.println("Order number " + id + "\n\tFor an amount of " + amount);
	}

	public Order(double amount) {
		super();
		this.id = ++idCpt;
		this.amount = amount;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}
}
