package SelCFunction;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.springframework.web.multipart.MultipartFile;

public class processImg {

	public static String inputImg(MultipartFile img, String username) {
		
		try {
			String path = "C:/Users/Playdata/DeskTop/ProfilePic";
			String constructor = img.getOriginalFilename().split("[.]")[1];
			String name = username+"_profilepic."+constructor;
			
			InputStream inputstream = img.getInputStream();
			System.out.println(path+"/"+name);
			File newFile=new File(path+"/"+name);
			int num = 0;
			while(true) {
				if(!newFile.exists()) {
					newFile.createNewFile();
					break;
				}
				else {
					name = username + "_profilepic" + num + "." + constructor;
					
					newFile = new File(path + "/" + name);
					
					num += 1;
				}
			}
			
			if(!newFile.exists()) {
				newFile.createNewFile();
			}
			OutputStream outputstream = new FileOutputStream(path+"/"+name);
			byte[] bytes = new byte[(int)img.getSize()];
			int read;
			while((read = inputstream.read(bytes))!=-1) {
				outputstream.write(bytes, 0, read);
			}
			inputstream.close();
			outputstream.close();
			return name;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		}
		return null;
		
	}
	public static Boolean inputBoardImg(MultipartFile img, String username) {
		
		try {
			String path = "C:/Users/Playdata/Desktop/BoardPic";
			
			InputStream inputstream = img.getInputStream();
			System.out.println(path+"/"+username);
			File newFile=new File(path+"/"+username);
			
			if(!newFile.exists()) {
				newFile.createNewFile();
			}
			OutputStream outputstream = new FileOutputStream(path+"/"+username);
			byte[] bytes = new byte[(int)img.getSize()];
			int read;
			while((read = inputstream.read(bytes))!=-1) {
				outputstream.write(bytes, 0, read);
			}
			inputstream.close();
			outputstream.close();
			return true;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		}
		return false;
		
	}
//	08-08 update
	public static String updateImg(MultipartFile img, String bid) {
		
		int num = 1;
		String img_name = bid + num;
		
		try {
			String path = "C:/Users/Playdata/DeskTop/BoardPic";
//			String constructor = img.getOriginalFilename().split("[.]")[1];
			String name = img_name + ".png";
			
			InputStream inputstream = img.getInputStream();
			System.out.println(path+"/"+name);
			File newFile=new File(path+"/"+name);
			
			while(true) {
				if(!newFile.exists()) {
					newFile.createNewFile();
					break;
				}
				else {
					name = bid + num + ".png";
					
					newFile = new File(path + "/" + name);
					
					num += 1;
				}
			}
			
			if(!newFile.exists()) {
				newFile.createNewFile();
			}
			OutputStream outputstream = new FileOutputStream(path+"/"+name);
			byte[] bytes = new byte[(int)img.getSize()];
			int read;
			while((read = inputstream.read(bytes))!=-1) {
				outputstream.write(bytes, 0, read);
			}
			inputstream.close();
			outputstream.close();
			return name;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		}
		return null;
		
	}

	
	
	
}
