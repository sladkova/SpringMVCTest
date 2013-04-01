package com.company.test.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.company.test.model.CD;
import com.company.test.model.Catalog;
import com.company.test.model.FileUpload;

@Controller
@RequestMapping(value = "/")
public class MainController {

	@Autowired
	private ServletContext context;

	private String uploadFolderPath;
	ServletConfig config;

	public String getUploadFolderPath() {
		return uploadFolderPath;
	}

	public void setUploadFolderPath(String uploadFolderPath) {
		this.uploadFolderPath = uploadFolderPath;
	}

	@RequestMapping(method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		model.addAttribute(new FileUpload());
		try {
			File file = new File(context.getRealPath("/") + "resources/catalog.xml");
			JAXBContext jaxbContext = JAXBContext.newInstance(Catalog.class);

			Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();
			Catalog catalog = (Catalog) jaxbUnmarshaller.unmarshal(file);

			ArrayList<CD> list = catalog.getCdsList();
			model.addAttribute("cdList", list);
		} catch (JAXBException jaxbe) {
			System.out.println(jaxbe.getLocalizedMessage());
			jaxbe.printStackTrace();
		}
		return "/home";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String create(FileUpload uploadItem, BindingResult result,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		if (result.hasErrors()) {
			for (ObjectError error : result.getAllErrors()) {
				System.err.println("Error: " + error.getCode() + " - "
						+ error.getDefaultMessage());
			}
			return "/home";
		}
		try {
			MultipartFile file = uploadItem.getFileData();
			String savedfileName = null;
			InputStream inputStream = null;
			OutputStream outputStream = null;
			if (file.getSize() > 0) {
				inputStream = file.getInputStream();
				
				savedfileName = context.getRealPath("/") + "resources/"
						+ file.getOriginalFilename();
				outputStream = new FileOutputStream(savedfileName);

				int readBytes = 0;
				byte[] buffer = new byte[10000000];
				while ((readBytes = inputStream.read(buffer, 0, 10000000)) != -1) {
					outputStream.write(buffer, 0, readBytes);
				}
				outputStream.close();
				inputStream.close();

				JAXBContext jaxbContext = JAXBContext
						.newInstance(Catalog.class);
				Unmarshaller jaxbUnmarshaller = jaxbContext
						.createUnmarshaller();

				HashMap<String, CD> resultMap = new HashMap<String, CD>();

				// file 1
				File file1 = new File(context.getRealPath("/")
						+ "resources/catalog.xml");
				Catalog catalog = (Catalog) jaxbUnmarshaller.unmarshal(file1);
				for (CD disk : catalog.getCdsList()) {
					resultMap.put(disk.getTitle(), disk);
				}

				// file 2
				File file2 = new File(savedfileName);
				Catalog catalog2 = (Catalog) jaxbUnmarshaller.unmarshal(file2);
				for (CD disk : catalog2.getCdsList()) {
					resultMap.put(disk.getTitle(), disk);
				}

				// result
				Marshaller m = jaxbContext.createMarshaller();
				m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
				Catalog resultCatalog = new Catalog();
				resultCatalog.setCdList(new ArrayList<CD>(resultMap.values()));
				m.marshal(resultCatalog, new File(context.getRealPath("/")
						+ "resources/catalog.xml"));
				
				file2.delete();
			}
			session.setAttribute("uploadFile", file.getOriginalFilename());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}
}