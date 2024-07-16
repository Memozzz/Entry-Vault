<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="jakarta.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Entry Vault - Task History</title>
<link rel="stylesheet" type="text/css" href="css/history.css">
</head>
<body>
    <div class="navbar">
        <div class="left">
            <img src="images/Layer 2.png" alt="Icon">
        </div>
        <div class="middle">
            <a href="homePage.jsp">Home Page</a> 
            <a href="notepads.jsp">Task</a>
            <a href="NotepadServlet?action=history">History</a>
        </div>
        <div class="right">
            <a href="login.jsp">Log Out</a>
        </div>
    </div>
    <div class="container">
        <h2>Task History</h2>
        <div class="tasks-container">
            <% 
               List<Map<String, Object>> tasks = (List<Map<String, Object>>) request.getAttribute("tasks");
               if (tasks != null && !tasks.isEmpty()) { 
            %>
            <table class="history-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Notepad ID</th>
                        <th>Title</th>
                        <th>Task</th>
                        <th>Completed</th>
                        <th>Task Time</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> task : tasks) { 
                           System.out.println("Displaying Task: " + task);
                    %>
                    <tr>
                        <td><%= task.get("id") %></td>
                        <td><%= task.get("notepadID") %></td>
                        <td><%= task.get("title") %></td>
                        <td><%= task.get("task") %></td>
                        <td><%= (boolean) task.get("completed") ? "Yes" : "No" %></td>
                        <td>
                            <% if (task.get("taskTime") != null) { %>
                                <% 
                                    Timestamp timestamp = (Timestamp) task.get("taskTime");
                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                    String formattedDate = sdf.format(timestamp);
                                %>
                                <%= formattedDate %>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% 
               } else { 
            %>
            <p>No tasks found.</p>
            <% 
               } 
            %>
        </div>
    </div>
</body>
</html>
