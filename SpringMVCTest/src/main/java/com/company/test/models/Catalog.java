package com.company.test.models;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;




@XmlRootElement(name = "Catalog")


public class Catalog {
  

    @XmlElement(name = "Cd")
    private ArrayList<cd> cdList;

	public ArrayList<cd> getCd2List() {
		return cdList;
	}

	public void setCd2List(ArrayList<cd> cdList) {
		this.cdList = cdList;
	}

	


 
    


    
}



