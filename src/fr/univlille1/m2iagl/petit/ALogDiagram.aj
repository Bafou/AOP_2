package fr.univlille1.m2iagl.petit;

import java.util.ArrayList;
import java.util.List;

public aspect ALogDiagram {

	List<Object> listOfAllObjects = new ArrayList<Object>();

	void printAllLines() {
		final StringBuilder sb = new StringBuilder();
		sb.append('|');
		for (int i = 0; i < listOfAllObjects.size(); i++) {

			for (int j = 0; j < 20; j++) {
				sb.append(' ');
			}
			sb.append('|');

		}
		for (int j = 0; j < 20; j++) {
			sb.append(' ');
		}
		System.out.println(sb.toString());
	}

	void printCallLine(final Object beginCall, final Object endCall,
			final String methodName) {
		int beginPosition = listOfAllObjects.indexOf(beginCall);
		int endPosition = listOfAllObjects.indexOf(endCall);
		String beginingArrow = beginPosition <= endPosition ? "---" : "<---";
		String endArrow = beginPosition <= endPosition ? ">|" : "-|";

		if (beginPosition > endPosition) {
			int inter = beginPosition;
			beginPosition = endPosition;
			endPosition = inter;
		}

		final StringBuilder sb = new StringBuilder();
		String newMethodName = methodName;

		if (methodName.length() > 10) {
			newMethodName = methodName.substring(0, 10);
		}

		beginPosition++;// Compense the display difference due to 
		//the fact that the main is not in the list

		sb.append('|');
		// Print part before caller
		for (int i = 0; i < beginPosition; i++) {
			for (int j = 0; j < 20; j++) {
				sb.append(' ');
			}
			sb.append('|');
		}

		// Print method arrow
		sb.append(beginingArrow);

		sb.append(newMethodName);
		for (int j = newMethodName.length() + beginingArrow.length(); j < 19; j++) {
			sb.append('-');
		}

		for (int i = beginPosition ; i < endPosition ; i++) {
			for (int j = 0; j < 21; j++) {
				sb.append('-');
			}
		}
		sb.append(endArrow);

		// Print last part
		for (int i = endPosition ; i < listOfAllObjects.size()-1; i++) {
			for (int j = 0; j < 20; j++) {
				sb.append(' ');
			}
			sb.append('|');
		}
		System.out.print(sb.toString());
	}

	pointcut traceMainMethod() : 
		execution (* fr.univlille1.m2iagl.petit..main (..));

	Object around() : traceMainMethod() {
		final String className = thisJoinPoint.getSignature()
				.getDeclaringTypeName();
		System.out.println(className.substring(className.lastIndexOf(".") + 1));
		final Object ret = proceed();
		return ret;
	}

	pointcut traceCallNewMethod() :
		call (fr.univlille1.m2iagl.petit..new (..));

	Object around() : traceCallNewMethod() {
		final Object ret = proceed();

		printAllLines();
		listOfAllObjects.add(ret);

		printCallLine(thisJoinPoint.getSourceLocation(), ret, "new");
		System.out.print(ret.toString().substring(
				ret.toString().lastIndexOf(".") + 1)
				+ "\n");

		printAllLines();

		return ret;
	}

	pointcut traceCallMethod(): 
		call (* fr.univlille1.m2iagl.petit..* (..)) && !(within(ALogDiagram));

	Object around() : traceCallMethod() {

		printAllLines();

		printCallLine(thisJoinPoint.getThis(), thisJoinPoint.getTarget(),
				thisJoinPoint.getSignature().getName());
		System.out.println();
		printAllLines();
		Object ret = proceed();

		printAllLines();
		// print return line
		printCallLine(thisJoinPoint.getTarget(), thisJoinPoint.getThis(), "");
		System.out.println();
		printAllLines();

		return ret;
	}

}
