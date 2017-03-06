package com.ironyard.controllers;

/**
 * Created by osmanidris on 3/6/17.
 */
import com.ironyard.data.Idiom;
import com.ironyard.data.IdiomUser;
import com.ironyard.repositories.IdiomRepo;
import com.ironyard.repositories.IdiomsUserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class ScheduleTask {
    @Autowired
    IdiomsUserRepo idiomsUserRepo;
    @Autowired
    IdiomRepo idiomRepo;
    @Autowired
    private JavaMailSender javaMailService;
    @Scheduled(fixedRate = 1000)
    public void notifyAllUsers() {
        Iterable<Idiom> idioms = idiomRepo.findNewIdioms();
        for (Idiom idiom : idioms) {
            System.out.println(idiom.getIdiomText());
            idiom.setIsNew(1);
            idiomRepo.save(idiom);
            this.notifyUsers(idiom);
        }
    }

    private void notifyUsers(Idiom idiom) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        Iterable<IdiomUser> users = idiomsUserRepo.findUsersToBeNotified();
        mailMessage.setSubject("New Idiom");
        for(IdiomUser user : users) {
            mailMessage.setTo(user.getEmail());
            mailMessage.setText("Hello " + user.getUsername() + ",\n New Idiom have been added with the below details\n" +
                    "Idiom text:"+idiom.getIdiomText()+"\n to see users comment  please visit the below link:\n" +
                    "http://localhost:8080");
            javaMailService.send(mailMessage);
        }
    }
}
