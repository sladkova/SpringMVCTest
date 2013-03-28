package com.company.test.controlers;

import java.awt.List;
import java.io.File;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.swing.text.Document;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.soap.Node;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;

import com.company.test.models.Catalog;
import com.company.test.models.cd;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		 
		 try
	        {
	            File file = new File("/home/olya/spacebank/f.xml");
	              JAXBContext jaxbContext = JAXBContext.newInstance(Catalog.class);
	 
	          Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
	          Catalog film = (Catalog)jaxbUnmarshaller.unmarshal(file);
	 
	    
	         ArrayList<cd> list = film.getCd2List();
	         
	             for (cd film2 : list) {
	            	System.out.println("Customer: " + film2.getName() +
	      	              
		                    "',age='" + film2.getAge() +
		                    "')");
	         
	           // model.addAttribute("age", film2.getAge() );
	         //   model.addAttribute("name", film2.getName() );
	          }
	         
	          
	        }
	      catch (JAXBException jaxbe)
	        {
	            System.out.println(jaxbe.getLocalizedMessage());
	            jaxbe.printStackTrace();
	        }

		return "home";
	}

	
}



