package ecommerce.Controller;

import ecommerce.Model.SupportTicket;
import ecommerce.Model.TicketMessage;
import ecommerce.Model.User;
import ecommerce.Services.SupportService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/tickets")
public class AdminTicketsServlet extends HttpServlet {
    private final SupportService supportService = new SupportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User admin = (User) request.getSession().getAttribute("loggedUser");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String ticketIdStr = request.getParameter("id");
        if (ticketIdStr != null) {
            int ticketId = Integer.parseInt(ticketIdStr);
            SupportTicket ticket = supportService.getTicket(ticketId);
            if (ticket != null) {
                request.setAttribute("ticket", ticket);
                request.setAttribute("messages", supportService.getTicketMessages(ticketId));
                request.getRequestDispatcher("/admin-ticket-details.jsp").forward(request, response);
                return;
            }
        }

        request.setAttribute("tickets", supportService.getAllTickets());
        request.getRequestDispatcher("/admin-tickets.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User admin = (User) request.getSession().getAttribute("loggedUser");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
        SupportTicket ticket = supportService.getTicket(ticketId);

        if (ticket != null) {
            if ("reply".equals(action)) {
                TicketMessage message = new TicketMessage();
                message.setTicket(ticket);
                message.setSender(admin);
                message.setMessage(request.getParameter("message"));
                supportService.addMessage(message);
            } else if ("close".equals(action)) {
                supportService.updateTicketStatus(ticketId, "CLOSED");
            } else if ("reopen".equals(action)) {
                supportService.updateTicketStatus(ticketId, "OPEN");
            }
        }
        response.sendRedirect("tickets?id=" + ticketId);
    }
}
