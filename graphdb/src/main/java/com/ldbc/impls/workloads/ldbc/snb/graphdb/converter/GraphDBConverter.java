package com.ldbc.impls.workloads.ldbc.snb.graphdb.converter;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

import com.ldbc.impls.workloads.ldbc.snb.converter.Converter;
import org.eclipse.rdf4j.model.Literal;
import org.eclipse.rdf4j.model.Value;
import org.eclipse.rdf4j.model.impl.SimpleIRI;
import org.eclipse.rdf4j.query.BindingSet;

public class GraphDBConverter extends Converter {

	private final static String COLLECTION_SEPARATOR = ", ";

	//converts date of type "2011-08-12T20:17:46.384Z" to millisecond.
	// This is the datetime type of sparql
	public long timestampToEpoch(BindingSet bindingSet, String name) {
		Instant instant = Instant.parse(bindingSet.getValue(name).stringValue());
		return instant.toEpochMilli();
	}

	//converts date of type "2011-08-12" to millisecond.
	public long localDateToEpoch(BindingSet bindingSet, String name) {
		String s = bindingSet.getValue(name).stringValue();
		return LocalDate.parse(s).atStartOfDay(ZoneId.of("GMT")).toInstant().toEpochMilli();
	}

	public Iterable<String> asStringCollection(BindingSet bindingSet, String name) {
		String stringValue = bindingSet.getValue(name).stringValue();
		if (stringValue.isEmpty()) {
			return Collections.emptyList();
		} else {
			return Arrays.asList(stringValue.split(COLLECTION_SEPARATOR));
		}
	}

	public Iterable<Number> asNumberCollection(BindingSet bindingSet, String name) {
		String stringValue = bindingSet.getValue(name).stringValue();
		if (stringValue.isEmpty()) {
			return Collections.emptyList();
		} else {
			List<String> stringList = Arrays.asList(stringValue.split(COLLECTION_SEPARATOR));
			return stringList.stream().map(Long::parseLong).collect(Collectors.toList());
		}
	}

	public Iterable<List<Object>> asObjectCollection(BindingSet bindingSet, String name) {
		String stringValue = bindingSet.getValue(name).stringValue();
		if (stringValue.isEmpty()) {
			return Collections.emptyList();
		} else {
			List<List<Object>> result = new ArrayList<>();
			String[] organizations = stringValue.split(COLLECTION_SEPARATOR);
			for (String organization : organizations) {
				result.add(Arrays.asList(organization.split(" ")));
			}
			return result;
		}
	}

	public long asLong(BindingSet bindingSet, String name) {
		String localName = ((SimpleIRI) bindingSet.getValue(name)).getLocalName();
		int numberIndex = localName.indexOf('0');
		return Long.parseLong(localName.substring(numberIndex));
	}

	public int asInt(BindingSet bindingSet, String name) {
		return ((Literal) bindingSet.getValue(name)).intValue();
	}

	public double asDouble(BindingSet bindingSet, String name) {
		return ((Literal) bindingSet.getValue(name)).doubleValue();
	}

	public String asString(BindingSet bindingSet, String name) {
		return bindingSet.getValue(name).stringValue();
	}

	public boolean asBoolean(BindingSet bindingSet, String name) {
		return ((Literal) bindingSet.getValue(name)).booleanValue();
	}

	@Override
	public String convertId(long value) {
		return String.format("%020d", value);
	}

	@Override
	public String convertString(String value) {
		return value;
	}

	@Override
	public String convertDate(Date date) {
		return new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
				.format(date);
	}

	@Override
	public String convertDateTime(Date date) {
		final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		return sdf.format(date)	;
	}

	public static String convertDateBirthday(Date date) {
		return new SimpleDateFormat("yyyy-MM-dd")
				.format(date);
	}

	@Override
	public String convertIdForInsertion(long value) {
		return Long.toString(value);
	}
}
