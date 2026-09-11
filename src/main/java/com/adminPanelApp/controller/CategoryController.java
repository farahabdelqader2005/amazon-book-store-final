package com.adminPanelApp.controller;

import com.adminPanelApp.model.Category;
import com.adminPanelApp.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/list")
    public String listCategories(HttpServletRequest request,
                                 Model model) {

        int page = 1;
        int pageSize = 5;

        String pageFromRequest = request.getParameter("page");

        if (pageFromRequest != null) {
            page = Integer.parseInt(pageFromRequest);
        }

        int firstResult = (page - 1) * pageSize;

        int totalCategories =
                categoryService.getAllCategories().size();

        int totalPages = totalCategories / pageSize;

        if (totalCategories % pageSize != 0) {
            totalPages++;
        }

        model.addAttribute(
                "categories",
                categoryService.getCategoriesByPage(firstResult)
        );

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("totalCategories", totalCategories);

        return "category-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("category", new Category());
        return "category-form";
    }

    @GetMapping("/edit")
    public String showEditForm(@RequestParam("id") Long id,
                               Model model) {

        Category category = categoryService.getCategoryById(id);

        if (category == null) {
            return "redirect:/categories/list?error=notFound";
        }

        model.addAttribute("category", category);
        return "category-form";
    }

    @PostMapping("/save")
    public String saveCategory(
            @ModelAttribute("category") Category category,
            BindingResult bindingResult) {

        String name = category.getName();

        if (name == null || name.trim().isEmpty()) {
            bindingResult.rejectValue(
                    "name",
                    "category.name.required",
                    "Category name is required."
            );
        } else {
            category.setName(name.trim());

            if (category.getName().length() > 255) {
                bindingResult.rejectValue(
                        "name",
                        "category.name.length",
                        "Category name must not exceed 255 characters."
                );
            }
        }

        if (bindingResult.hasErrors()) {
            return "category-form";
        }

        if (category.getId() == null) {
            categoryService.saveCategory(category);
        } else {
            Category existingCategory =
                    categoryService.getCategoryById(category.getId());

            if (existingCategory == null) {
                return "redirect:/categories/list?error=notFound";
            }

            existingCategory.setName(category.getName());
            categoryService.saveCategory(existingCategory);
        }

        return "redirect:/categories/list?success=saved";
    }

    @PostMapping("/delete")
    public String deleteCategory(@RequestParam("id") Long id) {

        Category category = categoryService.getCategoryById(id);

        if (category == null) {
            return "redirect:/categories/list?error=notFound";
        }

        boolean deleted = categoryService.deleteCategory(id);

        if (!deleted) {
            return "redirect:/categories/list?error=notFound";
        }

        return "redirect:/categories/list?success=deleted";
    }
}
