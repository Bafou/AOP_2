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
		final Class<?> objectClass = thisJoinPoint.getSignature().getDeclaringType();
		Object singl =  this.singletonMap.get(objectClass);
		
		if (singl == null) {
			singl =  proceed();
			this.singletonMap.put(objectClass, singl) ;
		} 
		return singl;

	}
}
