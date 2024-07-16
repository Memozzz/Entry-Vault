<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.text.SimpleDateFormat"%>
<%@ page import="jakarta.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Entry Vault - Notepads</title>
<link rel="stylesheet" type="text/css" href="css/notepad.css">
<link rel="icon" type="image/x-icon" href="images/Layer 2.png">
</head>
<body>
    <div class="navbar">
        <div class="left">
            <img src="images/Layer 2.png" alt="Icon">
        </div>
        <div class="middle">
            <a href="homePage.jsp">Home Page</a> <a href="notepads.jsp">Task</a>
            <a href="NotepadServlet?action=history">History</a>
        </div>
        <div class="right">
            <a href="login.jsp">Log Out</a>
        </div>
    </div>
    <div class="container">
        <div class="form-container">
            <form action="NotepadServlet" method="post">
                <input type="hidden" name="action" value="createNotepad">
                <div class="input-group">
                    <label for="title">Title:</label> 
                    <input type="text" id="title" name="title" required>
                </div>
                <button type="submit">Create Notepad</button>
            </form>
        </div>
        <div class="notepads-container">
            <% 
                String userName = (String) session.getAttribute("userName");
                if (userName == null) {
                    response.sendRedirect("login.jsp");
                } else {
                    String dbUrl = "jdbc:derby://localhost:1527/webUser;create=true";
                    String dbUser = "root";
                    String dbPassword = "root";
                    List<Map<String, Object>> notepads = new ArrayList<>();
                    try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                        String query = "SELECT * FROM Notepads WHERE UserName = ?";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setString(1, userName);
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                            Map<String, Object> notepad = new HashMap<>();
                            notepad.put("id", rs.getInt("ID"));
                            notepad.put("title", rs.getString("Title"));
                            List<Map<String, Object>> tasks = new ArrayList<>();
                            String taskQuery = "SELECT * FROM Tasks WHERE NotepadID = ? AND TaskTime > CURRENT_TIMESTAMP";
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
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
                <% for (Map<String, Object> notepad : notepads) { %>
                    <div class="notepad">
                        <h3><%= notepad.get("title") %></h3>
                        <ul>
                            <% for (Map<String, Object> task : (List<Map<String, Object>>) notepad.get("tasks")) { %>
                                <li class="<%= (boolean) task.get("completed") ? "completed" : "" %>">
                                    <input type="checkbox" id="task_<%= task.get("id") %>"
                                           name="completedTasks"
                                           value="<%= task.get("id") %>"
                                           <% if ((boolean) task.get("completed")) { %>checked<% } %>
                                           onchange="toggleTaskCompletion('<%= task.get("id") %>')">
                                    <label for="task_<%= task.get("id") %>"><%= task.get("task") %></label>
                                    <% if (task.get("taskTime") != null) { %>
                                        <% 
                                            Timestamp timestamp = (Timestamp) task.get("taskTime");
                                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                            String formattedDate = sdf.format(timestamp);
                                        %>
                                        <span style="margin-right: 5px; margin-left: 5px;">(Due: <%= formattedDate %>)</span>
                                    <% } %>
                                    <a class="edit-btn" href="javascript:void(0);" onclick="showEditTaskForm('<%= task.get("id") %>', '<%= task.get("task") %>');">Edit</a>
                                    <button class="delete-btn" type="button" onclick="showDeleteTaskModal('<%= task.get("id") %>');">Delete</button>
                                </li>
                            <% } %>
                        </ul>
                        <form action="NotepadServlet" method="post" class="task-form">
                            <input type="hidden" name="action" value="addTask">
                            <input type="hidden" name="notepadId" value="<%= notepad.get("id") %>">
                            <div class="input-group">
                                <label for="task">New Task:</label> 
                                <input type="text" name="task" required>
                            </div>
                            <div class="input-group">
                                <label for="taskDate">Date:</label> 
                                <input type="date" name="taskDate" required>
                            </div>
                            <div class="input-group">
                                <label for="taskTime">Time:</label> 
                                <input type="time" name="taskTime" required>
                            </div>
                            <button type="submit">Add Task</button>
                        </form>
                    </div>
                <% } %>	
            <% } %>
        </div>
    </div>
    
    <!-- Edit Task Modal -->
    <div id="editTaskModal">
        <form id="editTaskForm" action="NotepadServlet" method="post">
            <input type="hidden" name="action" value="editTask">
            <input type="hidden" name="id" id="editTaskId">
            <div class="input-group">
                <label for="editTask">Task:</label> 
                <input type="text" id="editTask" name="task" required>
            </div>
            <button type="submit">Save</button>
        </form>
    </div>
    
    <!-- Delete Task Modal -->
    <div id="deleteTaskModal">
        <div class="modal-content">
            <p>Are you sure you want to delete this task?</p>
            <form id="deleteTaskForm" action="NotepadServlet" method="post">
                <input type="hidden" name="action" value="deleteTask">
                <input type="hidden" name="id" id="deleteTaskId">
                <button type="submit">Delete</button>
                <button type="button" onclick="closeDeleteTaskModal()">Cancel</button>
            </form>
        </div>
    </div>
    
    <script>
        function toggleTaskCompletion(taskId) {
            var checkbox = document.getElementById('task_' + taskId);
            var isChecked = checkbox.checked;
            var action = isChecked ? 'completeTask' : 'uncompleteTask';
    
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'NotepadServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        // Update task appearance based on completion status
                        var taskLabel = document.querySelector('label[for="task_' + taskId + '"]');
                        var taskLi = taskLabel.parentElement;
                        if (isChecked) {
                            taskLabel.style.textDecoration = 'line-through';
                            taskLabel.style.color = '#808080'; // Gray color for completed tasks
                            taskLi.classList.add('completed');
                        } else {
                            taskLabel.style.textDecoration = 'none';
                            taskLabel.style.color = '#000000'; // Reset to black for incomplete tasks
                            taskLi.classList.remove('completed');
                        }
                    } else {
                        console.error('Error updating task completion status');
                    }
                }
            };
            xhr.send('action=' + action + '&id=' + taskId);
        }
    
        function showEditTaskForm(id, task) {
            document.getElementById('editTaskId').value = id;
            document.getElementById('editTask').value = task;
            document.getElementById('editTaskModal').style.display = 'block';
        }
    
        function showDeleteTaskModal(id) {
            document.getElementById('deleteTaskId').value = id;
            document.getElementById('deleteTaskModal').style.display = 'block';
        }
    
        function closeDeleteTaskModal() {
            document.getElementById('deleteTaskModal').style.display = 'none';
        }
    </script>
</body>
</html>
