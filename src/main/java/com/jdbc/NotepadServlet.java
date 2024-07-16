	package com.jdbc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class NotepadServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(NotepadServlet.class.getName());


    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:derby://localhost:1527/webUser;create=true";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("createNotepad".equals(action)) {
            createNotepad(request, response);
        } else if ("addTask".equals(action)) {
            addTask(request, response);
        } else if ("editTask".equals(action)) {
            editTask(request, response);
        } else if ("deleteTask".equals(action)) {
            deleteTask(request, response);
        } else if ("completeTask".equals(action)) {
            completeTask(request, response);
        } else if ("uncompleteTask".equals(action)) {
            uncompleteTask(request, response);
        } else if ("fetchTaskHistory".equals(action)) {
            fetchTaskHistory(request, response);
        } else {
            fetchNotepadsAndTasks(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("history".equals(action)) {
            fetchTaskHistory(request, response);
        } else {
            // Other actions...
        }
    }

    private void createNotepad(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String userName = (String) request.getSession().getAttribute("userName");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "INSERT INTO Notepads (Title, UserName) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, title);
            stmt.setString(2, userName);
            stmt.executeUpdate();
            response.sendRedirect("notepads.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create notepad.");
        }
    }

    private void addTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int notepadId = Integer.parseInt(request.getParameter("notepadId"));
        String task = request.getParameter("task");
        String taskDate = request.getParameter("taskDate");
        String taskTime = request.getParameter("taskTime");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Combine taskDate and taskTime into a single formatted string
            String dateTimeString = taskDate + " " + taskTime + ":00"; // Adding ":00" for seconds part
            Timestamp timestamp = Timestamp.valueOf(dateTimeString);

            String query = "INSERT INTO Tasks (NotepadID, Task, Completed, TaskTime) VALUES (?, ?, FALSE, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, notepadId);
            stmt.setString(2, task);
            stmt.setTimestamp(3, timestamp);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("notepads.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add task: No rows inserted.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add task: Database error - " + e.getMessage());
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to add task: Invalid timestamp format - " + e.getMessage());
        }
    }
    private void editTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("id"));
        String task = request.getParameter("task");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "UPDATE Tasks SET Task = ? WHERE ID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, task);
            stmt.setInt(2, taskId);
            stmt.executeUpdate();
            response.sendRedirect("notepads.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to edit task.");
        }
    }

    private void deleteTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {	
        int taskId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "DELETE FROM Tasks WHERE ID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, taskId);
            stmt.executeUpdate();
            response.sendRedirect("notepads.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete task.");
        }
    }

    private void completeTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("id"));
        updateTaskCompletionStatus(taskId, true, response);
    }	

    private void uncompleteTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("id"));
        updateTaskCompletionStatus(taskId, false, response);
    }

    private void updateTaskCompletionStatus(int taskId, boolean completed, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "UPDATE Tasks SET Completed = ? WHERE ID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setBoolean(1, completed);
            stmt.setInt(2, taskId);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    private void fetchNotepadsAndTasks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Map<String, Object>> notepads = new ArrayList<>();
        String userName = (String) request.getSession().getAttribute("userName");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT * FROM Notepads WHERE UserName = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, userName);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> notepad = new HashMap<>();
                notepad.put("id", rs.getInt("ID"));
                notepad.put("title", rs.getString("Title"));
                List<Map<String, Object>> tasks = new ArrayList<>();

                // Fetch tasks including TaskTime
                String taskQuery = "SELECT * FROM Tasks WHERE NotepadID = ?";
                PreparedStatement taskStmt = conn.prepareStatement(taskQuery);
                taskStmt.setInt(1, rs.getInt("ID"));
                ResultSet taskRs = taskStmt.executeQuery();
                while (taskRs.next()) {
                    Map<String, Object> task = new HashMap<>();
                    task.put("id", taskRs.getInt("ID"));
                    task.put("task", taskRs.getString("Task"));
                    task.put("completed", taskRs.getBoolean("Completed"));
                    task.put("taskTime", taskRs.getTimestamp("TaskTime")); // Retrieve taskTime
                    tasks.add(task);
                }

                notepad.put("tasks", tasks);
                notepads.add(notepad);
            }

            // Set attributes for JSP
            request.setAttribute("notepads", notepads);
            request.getRequestDispatcher("notepads.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to fetch notepads and tasks.");
        }
    }
    private void fetchTaskHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Map<String, Object>> tasks = new ArrayList<>();
        String userName = (String) request.getSession().getAttribute("userName");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String query = "SELECT t.ID, t.Task, t.Completed, t.TaskTime, n.Title, n.ID AS NotepadID " +
                           "FROM Tasks t " +
                           "JOIN Notepads n ON t.NotepadID = n.ID " +
                           "WHERE n.UserName = ? AND t.TaskTime < CURRENT_TIMESTAMP";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, userName);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> task = new HashMap<>();
                task.put("id", rs.getInt("ID"));
                task.put("title", rs.getString("Title"));
                task.put("task", rs.getString("Task"));
                task.put("completed", rs.getBoolean("Completed"));
                task.put("taskTime", rs.getTimestamp("TaskTime"));
                task.put("notepadID", rs.getInt("NotepadID"));

                LOGGER.info("Fetched Task: " + task);
                tasks.add(task);
            }

            // Set attributes for JSP
            request.setAttribute("tasks", tasks);
            request.getRequestDispatcher("history.jsp").forward(request, response);
            
        } catch (SQLException e) {
            LOGGER.severe("SQL Exception: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to fetch task history.");
        }
    }

}