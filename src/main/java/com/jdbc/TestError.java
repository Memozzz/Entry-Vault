package com.jdbc;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestError {

	public static void main(String[] args) throws SQLException {
		try {
			Class.forName("org.apache.derby.jdbc.ClientDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Found Driver");

		String sql = "jdbc:derby://localhost:1527/webUser;create=true";

		try {
			Connection conn = DriverManager.getConnection(sql);
			System.out.println("Connected");
			DatabaseMetaData dbMetaData = conn.getMetaData();

			System.out.println("Driver: " + dbMetaData.getDriverName());
			System.out.println("Version: " + dbMetaData.getDriverVersion());
			System.out.println("Query:");

			Statement statement = conn.createStatement();
			ResultSet resultset = statement.executeQuery("SELECT * FROM \"ROOT\".TASKS");

			while (resultset.next()) {
				System.out.println(resultset.getString("notepadId") + " : " + resultset.getString("task")  + " : " + resultset.getString("taskTime"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("SQL exception occured" + e);
			e.printStackTrace();
		}
	}
}
