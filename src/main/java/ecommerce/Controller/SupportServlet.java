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
import java.util.List;

@WebServlet("/support")
public class SupportServlet extends HttpServlet {
    private final SupportService supportService = new SupportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("loggedUser");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String ticketIdStr = request.getParameter("id");
        if (ticketIdStr != null) {
            int ticketId = Integer.parseInt(ticketIdStr);
            SupportTicket ticket = supportService.getTicket(ticketId);
            if (ticket != null && ticket.getUser().getId() == user.getId()) {
                request.setAttribute("ticket", ticket);
                request.setAttribute("messages", supportService.getTicketMessages(ticketId));
                request.getRequestDispatcher("ticket-details.jsp").forward(request, response);
                return;
            }
        }

        List<SupportTicket> tickets = supportService.getUserTickets(user.getId());
        request.setAttribute("tickets", tickets);
        request.getRequestDispatcher("support.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("loggedUser");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if ("create".equals(action)) {
            SupportTicket ticket = new SupportTicket();
            ticket.setUser(user);
            ticket.setSubject(request.getParameter("subject"));
            ticket.setDescription(request.getParameter("description"));
            ticket.setStatus("OPEN");
            supportService.createTicket(ticket);
        } else if ("reply".equals(action)) {
            int ticketId = Integer.parseInt(request.getParameter("ticketId"));
            SupportTicket ticket = supportService.getTicket(ticketId);
            if (ticket != null && ticket.getUser().getId() == user.getId() && "OPEN".equals(ticket.getStatus())) {
                TicketMessage message = new TicketMessage();
                message.setTicket(ticket);
                message.setSender(user);
                message.setMessage(request.getParameter("message"));
                supportService.addMessage(message);
            }
        }
        response.sendRedirect("support");
    }
}
