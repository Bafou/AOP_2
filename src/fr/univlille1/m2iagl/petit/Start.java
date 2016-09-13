package fr.univlille1.m2iagl.petit;

import fr.univlille1.m2iagl.petit.singleton.Clients;
import fr.univlille1.m2iagl.petit.singleton.Orders;

public class Start {

	public static void main(String[] args) {
		System.out.println("Begin Orders and Clients application :\n");
		Orders orders = new Orders();
		Clients clients = new Clients();
		
		Client clientA = new Client("A", "Town A");
		Client clientB = new Client("B", "Town B");
		Client clientC = new Client("C", "Town C");
		Client clientD = new Client("D", "Town D");
		
		clients.addClient(clientA);
		clients.addClient(clientB);
		clients.addClient(clientC);
		clients.addClient(clientD);
		
		Order orderA = new Order(12);
		Order orderB = new Order(45);
		Order orderC = new Order(42);
		Order orderD = new Order(33);
		Order orderE = new Order(78);
		Order orderF = new Order(1);
		
		orders.addOrder(orderA);
		orders.addOrder(orderB);
		orders.addOrder(orderC);
		orders.addOrder(orderD);
		orders.addOrder(orderE);
		orders.addOrder(orderF);
		
		clientA.addOrder(orderA);
		clientA.addOrder(orderB);
		clientB.addOrder(orderC);
		clientC.addOrder(orderD);
		clientD.addOrder(orderE);
		clientD.addOrder(orderF);
		
		System.out.println("\n---------------------------------------------------------------------------------");
		System.out.println("Print all orders\n");
		
		for (Order ord : orders.getAllOrders()) {
			ord.printOrder();
		}
		System.out.println("---------------------------------------------------------------------------------\n");
				
		clients.delClient(clientA);
		clientA.delOrder(orderA);
		orders.delOrder(orderA);
		clientA.delOrder(orderB);
		orders.delOrder(orderB);
		clients.delClient(clientA);
		
		clients.delClient(clientB);
		clientB.delAllOrders();
		clients.delClient(clientB);
		
	}
	
}
