package fr.univlille1.m2iagl.petit;

import java.util.ArrayList;
import java.util.List;

/**
 * Aspect which manage the creation of a call Diagram
 * 
 * @author PETIT Antoine
 *
 */
public aspect ALogDiagram {

	final List<Object> listOfAllObjects = new ArrayList<Object>();
	final StringBuilder logDiagram = new StringBuilder();
	
	/**
	 * Add a complete line with every Object line to logDiagram
	 */
	private void addCompleteLines() {
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
		sb.append('\n');
		logDiagram.append(sb);
	}

	/**
	 * Add to the logDiagram the call line with the arrow
	 * This method is also able to write the return line of the method if you invert
	 * beginCall and endCall value
	 * 
	 * @param beginCall the object which make the method call
	 * @param endCall the object which receive the method call
	 * @param methodName the name of the method
	 */
	private void addCallLine(final Object beginCall, final Object endCall,
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

		//Manage the name of the method in order to have the same length everywhere 
		if (methodName.length() > 10) {
			newMethodName = methodName.substring(0, 10);
		}

		beginPosition++;// Compense the display difference due to 
		//the fact that the main is not in the list

		sb.append('|');
		// Add part before caller
		for (int i = 0; i < beginPosition; i++) {
			for (int j = 0; j < 20; j++) {
				sb.append(' ');
			}
			sb.append('|');
		}

		// Add method arrow
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
		logDiagram.append(sb);
	}

	pointcut traceMainMethod() : 
		execution (* fr.univlille1.m2iagl.petit..main (..));

	before() : traceMainMethod() {
		final String className = thisJoinPoint.getSignature()
				.getDeclaringTypeName();
		logDiagram.append(className.substring(className.lastIndexOf(".") + 1) + '\n');
	}
	
	after() : traceMainMethod() {
		System.out.println(logDiagram.toString());
	}

	pointcut traceCallNewMethod() :
		call (fr.univlille1.m2iagl.petit..new (..));

	Object around() : traceCallNewMethod() {
		final Object ret = proceed();

		addCompleteLines();
		listOfAllObjects.add(ret);

		addCallLine(thisJoinPoint.getSourceLocation(), ret, "new");
		logDiagram.append(ret.toString().substring(
				ret.toString().lastIndexOf(".") + 1)
				+ "\n");

		addCompleteLines();

		return ret;
	}

	pointcut traceCallMethod(): 
		call (* fr.univlille1.m2iagl.petit..* (..)) && !(within(ALogDiagram));

	Object around() : traceCallMethod() {

		addCompleteLines();

		addCallLine(thisJoinPoint.getThis(), thisJoinPoint.getTarget(),
				thisJoinPoint.getSignature().getName());
		logDiagram.append('\n');
		addCompleteLines();
		Object ret = proceed();

		addCompleteLines();
		// add return line to logDiagram
		addCallLine(thisJoinPoint.getTarget(), thisJoinPoint.getThis(), "");
		logDiagram.append('\n');
		addCompleteLines();

		return ret;
	}

}
