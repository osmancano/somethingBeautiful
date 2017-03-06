package com.ironyard.controllers;

import com.ironyard.data.IdiomUser;
import com.ironyard.repositories.IdiomsUserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by osmanidris on 2/10/17.
 */
@Controller
public class UserController {
    @Autowired
    private IdiomsUserRepo idiomsUserRepo;
    @Value("${upload.location}")
    private String uploadLocation;

    @RequestMapping(path = "/idoims/users/signin", method = RequestMethod.POST)
    public String login(HttpSession session, Model data, @RequestParam(name = "username") String usr, @RequestParam String password){
        IdiomUser found = idiomsUserRepo.findByUsernameAndPassword(usr, password);
        String destinationView = "redirect:/";
        if(found != null){
            session.setAttribute ("user", found);
        }
        return destinationView;
    }

    @RequestMapping(path = "/idioms/users/signup", method = RequestMethod.POST,consumes = MediaType.ALL_VALUE)
    public String createUser(Model dataToJsp, @RequestParam String username,
                             @RequestParam String password,
                             @RequestParam String email,
                             @RequestParam(required=false) Integer notifyMe,
                             @RequestParam(required=false) MultipartFile userImage){
        // save to database
        String uploadedFileName = null;
        if(!userImage.isEmpty()){
            try {
                uploadedFileName = System.currentTimeMillis() + "_" + userImage.getOriginalFilename();
                // copy from input stream to computer disk
                Files.copy(userImage.getInputStream(), Paths.get(uploadLocation + uploadedFileName));
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        IdiomUser cUser = new IdiomUser(username,password,email, uploadedFileName);
        if(notifyMe!=null){
            cUser.setNotifyMe(notifyMe);
        }
        idiomsUserRepo.save(cUser);
        return "/idioms/home";
    }

    @RequestMapping(path = "/secure/users")
    public String listUsers(Model xyz){
        String destination = "/secure/users";
        Iterable found = idiomsUserRepo.findAll();
        // put list into model
        xyz.addAttribute("uList", found);
        // go to jsp
        return destination;
    }

    @RequestMapping(path = "/idioms/users/signout")
    public String login(HttpSession session){
        session.removeAttribute("user");
        session.invalidate();
        String destinationView = "redirect:/idioms/home.jsp";
        return destinationView;
    }

}
