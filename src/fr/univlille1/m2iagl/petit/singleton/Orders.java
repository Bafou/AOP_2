package fr.univlille1.m2iagl.petit.singleton;

import java.util.ArrayList;
import java.util.List;

import fr.univlille1.m2iagl.petit.Order;

public class Orders {

	protected List<Order> allOrders;

	public void addOrder(final Order order) {
		allOrders.add(order);
	}

	public void delOrder(final Order order) {
		allOrders.remove(order);
	}

	public Orders() {
		super();
		allOrders = new ArrayList<Order>();
	}
	
	public List<Order> getAllOrders() {
		return allOrders;
	}

}
