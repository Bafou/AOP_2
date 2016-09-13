package fr.univlille1.m2iagl.petit.singleton;

import java.util.ArrayList;
import java.util.List;

import fr.univlille1.m2iagl.petit.Order;
import fr.univlille1.m2iagl.petit.singleton.itf.SingletonItf;

public class Orders implements SingletonItf {

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
