package fr.univlille1.m2iagl.petit;

import java.util.ArrayList;
import java.util.List;

import fr.univlille1.m2iagl.petit.singleton.Clients;

public aspect AClientOrder {

	private Client Order.client;
	private List<Order> Client.listOrders;

	public void Client.addOrder(final Order order) {
		this.listOrders.add(order);
		order.setClient(this);
	}

	public boolean Client.hasOrder() {
		return !this.listOrders.isEmpty();
	}

	public void Client.delOrder(final Order order) {
		this.listOrders.remove(order);
		order.setClient(null);
	}

	public void Client.delAllOrders() {
		for (Order order : listOrders) {
			order.setClient(null);
		}
		this.listOrders = new ArrayList<Order>();
	}
	
	private void Order.setClient(final Client client) {
		this.client = client;
	}
	

	public Client Order.getClient() {
		return this.client;
	}

	after(): initialization(Client.new(..)) {
		Client myClient = (Client) thisJoinPoint.getTarget();
		myClient.listOrders = new ArrayList<Order>();
	}

	pointcut toPrintOrder() :
		call(void Order.printOrder());
	after(): toPrintOrder() {
		Order myOrder = (Order) thisJoinPoint.getTarget();
		Client myClient = myOrder.getClient();
		System.out.println("\tClient's name : " + myClient.name + "\n\tClient's adress : " + myClient.adresse);
	}
	
	pointcut aroundClientsDel(Client client) :
		call(void Clients.delClient(Client)) && args (client);
	void around(Client client): aroundClientsDel(client) {
		if (!client.hasOrder()) {
			proceed(client);
//			System.out.println("Client " + client.getName() + " deleted");
		}
//		else {
//			System.out.println("Client " + client.getName() + " can't be deleted : Client still have orders");
//		}
	}
	
//	pointcut logClientAddOrder(Order order) :
//		call(void Client.addOrder(Order)) && args(order);
//	after(Order order): logClientAddOrder(order){
//		Client client = (Client) thisJoinPoint.getTarget();
//		System.out.println("Add order " + order.getId() + " to client " + client.getName());
//	}
//	
//	pointcut logClientDelOrder(Order order) :
//		call(void Client.delOrder(Order)) && args(order);
//	after(Order order): logClientDelOrder(order){
//		Client client = (Client) thisJoinPoint.getTarget();
//		System.out.println("Del order " + order.getId() + " from client " + client.getName());
//	}
//	
//	pointcut logOrderSetClient(Client client) :
//		call(void Order.setClient(Client)) && args(client);
//	after(Client client): logOrderSetClient(client){
//		Order order = (Order) thisJoinPoint.getTarget();
//		if (client == null ) {
//			System.out.println("Removing client from order " + order.getId());
//		}
//		else {
//			System.out.println("The client of order " + order.getId() + " is client " + client.getName());			
//		}
//	}
}
