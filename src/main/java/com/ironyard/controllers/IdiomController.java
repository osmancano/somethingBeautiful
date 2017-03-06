package com.ironyard.controllers;

import com.ironyard.data.Idiom;
import com.ironyard.data.IdiomComment;
import com.ironyard.data.IdiomUser;
import com.ironyard.repositories.IdiomCommentRepo;
import com.ironyard.repositories.IdiomRepo;
import com.ironyard.repositories.IdiomsUserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by osmanidris on 3/5/17.
 */
@Controller
public class IdiomController {
    @Autowired
    IdiomRepo idiomRepo;
    @Autowired
    IdiomCommentRepo idiomCommentRepo;
    @Autowired
    IdiomsUserRepo idiomsUserRepo;


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {

        return "redirect:/idioms/home.jsp";
    }

    @RequestMapping(value = "/idioms/addIdiom", method = RequestMethod.POST)
    public String addIdiom(@RequestParam String idiomText) {
        Idiom idiom = new Idiom(idiomText);
        idiomRepo.save(idiom);
        return "redirect:/";
    }

    @RequestMapping(value = "/idioms/addComment", method = RequestMethod.POST)
    public String addIdiomComment(HttpSession session,@RequestParam String comment, @RequestParam Long idiomId) {
        IdiomUser user = (IdiomUser) session.getAttribute("user");
        if(user!=null){
            Idiom idiom = idiomRepo.findOne(idiomId);
            IdiomComment idiomComment = new IdiomComment(comment,user);
            idiomCommentRepo.save(idiomComment);
            idiom.getComments().add(idiomComment);
            idiomRepo.save(idiom);
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/idioms", method= RequestMethod.GET)
    public String getIdioms(Model data, @RequestParam(value = "page", required = false) Integer page){
        if(page == null){
            page = 0;
        }

        Sort s = new Sort(Sort.Direction.DESC, "idiomText");
        PageRequest pr = new PageRequest(page, 1, s);
        Page<Idiom> idioms = idiomRepo.findAll(pr);
        // put list into model
        data.addAttribute("idioms", idioms);
        return "/idioms/currentIdiom";
    }
}
