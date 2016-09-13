package fr.univlille1.m2iagl.petit;

import fr.univlille1.m2iagl.petit.singleton.itf.SingletonItf;

public aspect ASingleton {

	private Object SingletonItf.singleton = null;


	pointcut singletonInitialization() :
		call (SingletonItf+.new(..));

	Object around(): singletonInitialization() {
		SingletonItf singl = (SingletonItf) thisJoinPoint.getTarget();
		if (singl.singleton == null) {
			System.out.println("Initialization of instance");
			Object res = proceed();
			singl.singleton = res;
		}
		else {
			System.out.println("Instance already exists");
		}
		return singl.singleton;
	}

}
