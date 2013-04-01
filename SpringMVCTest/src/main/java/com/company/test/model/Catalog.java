package com.company.test.model;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "CATALOG")
public class Catalog {

	@XmlElement(name = "CD")
	public ArrayList<CD> cdList;

	public void setCdList(ArrayList<CD> bookList) {
		this.cdList = bookList;
	}

	public ArrayList<CD> getCdsList() {
		return cdList;
	}
}