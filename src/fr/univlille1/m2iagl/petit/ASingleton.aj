package fr.univlille1.m2iagl.petit;

import java.util.HashMap;
import java.util.Map;

/**
 * Aspect which allow to create Singleton for any class on a singleton package
 * 
 * @author PETIT Antoine
 *
 */
public aspect ASingleton {

	private Map<Class<?>,Object> singletonMap = new HashMap<Class<?>, Object>();

	pointcut singletonInitialization() :
		call (singleton..new(..));

	Object around(): singletonInitialization() {
		System.out.println("\tThisJoinPoint class : " + thisJoinPoint.getSignature().getDeclaringType());
		final Class<?> objectClass = thisJoinPoint.getSignature().getDeclaringType();
		Object singl =  this.singletonMap.get(objectClass);
		
		if (singl == null) {
			System.out.println("\t\tInitialization of instance");
			singl =  proceed();
			System.out.println("\t\tResult of proceed : " + singl );
			this.singletonMap.put(objectClass, singl) ;
		} else {
			System.out.println("\t\tInstance already exists");
		}
		return singl;

	}
}
