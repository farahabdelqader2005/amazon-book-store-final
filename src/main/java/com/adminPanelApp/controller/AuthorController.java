package com.adminPanelApp.controller;

import com.adminPanelApp.model.Author;
import com.adminPanelApp.service.AuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/authors")
public class AuthorController {

    @Autowired
    private AuthorService authorService;

    @GetMapping("/list")
    public String listAuthors(Model model) {
        model.addAttribute("authors", authorService.getAllAuthors());
        return "author-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("author", new Author());
        return "author-form";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") Long id,
                               Model model) {

        Author author = authorService.getAuthorById(id);

        if (author == null) {
            return "redirect:/authors/list?error=notFound";
        }

        model.addAttribute("author", author);
        return "author-form";
    }

    @PostMapping("/save")
    public String saveAuthor(
            @ModelAttribute("author") Author author,
            BindingResult bindingResult) {

        String name = author.getName();

        if (name == null || name.trim().isEmpty()) {
            bindingResult.rejectValue(
                    "name",
                    "author.name.required",
                    "Author name is required."
            );
        } else {
            author.setName(name.trim());

            if (author.getName().length() > 255) {
                bindingResult.rejectValue(
                        "name",
                        "author.name.length",
                        "Author name must not exceed 255 characters."
                );
            }
        }

        if (bindingResult.hasErrors()) {
            return "author-form";
        }

        if (author.getId() == null) {
            authorService.saveAuthor(author);
        } else {
            Author existingAuthor = authorService.getAuthorById(author.getId());

            if (existingAuthor == null) {
                return "redirect:/authors/list?error=notFound";
            }

            existingAuthor.setName(author.getName());
            authorService.saveAuthor(existingAuthor);
        }

        return "redirect:/authors/list?success=saved";
    }

    @PostMapping("/delete")
    public String deleteAuthor(@RequestParam("id") Long id) {

        boolean deleted = authorService.deleteAuthor(id);

        if (!deleted) {
            return "redirect:/authors/list?error=notFound";
        }

        return "redirect:/authors/list?success=deleted";
    }
}
