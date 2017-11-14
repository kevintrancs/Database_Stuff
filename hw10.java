/**
 * hw 10
 * 
 * @author Kevin Tran & Brandon Kelly
 * 
 */


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Sql {

	public static void main(String[] args) throws SQLException {

        Scanner input = new Scanner( System.in );
   	    int swValue;

		// create connection
		String url = "jdbc:mysql://147.222.163.1:3306/ktran_DB";
		String user = "ktran";
		String pass = "ktran11860677";
		Connection cn = DriverManager.getConnection(url, user, pass);
	


	    // Switch construct
	    while(true){
	    	 // Display menu graphics
		    System.out.println("============================");
		    System.out.println("|   Main Mentu              ");
		    System.out.println("============================");
		    System.out.println("| Options:                 ");
		    System.out.println("| 1. List of Countries     ");
		    System.out.println("| 2. Add Country           ");
		    System.out.println("| 3. Find Countries on GDP/Inflation     ");
		    System.out.println("| 4. Update Country GDP/Inflation     ");
		    System.out.println("| 5. Exit     ");
		    System.out.println("============================");
			System.out.println("Enter your choice:     ");
		    swValue = input.nextInt();

			    switch (swValue) {
			    case 1:
			      System.out.println("List of Countries");
				  	Statement st = cn.createStatement();
					ResultSet rs = listCountries(cn, st);
					while(rs.next()) {
						String name = rs.getString("country_name");
						String code = rs.getString("code");
						System.out.println(name + " (" + code + ")");
					}
					
					rs.close();
					st.close();
			      break;
			      
			      
			    case 2:
			      System.out.println("Adda Country:");
			      Statement stt = cn.createStatement();
			      String code, name;
			      double gdp, inflation;
			      
			      System.out.println("Country code................:");
			      code = input.next();
			      input.nextLine();
			      System.out.println("Country name................:");
			      name = input.nextLine();
			      System.out.println("Country per capita gdp (USD)");
			      gdp = input.nextDouble();
			      System.out.println("Country inflation (pct).....:");
			      inflation = input.nextDouble();
			      
			      String query_2 = "INSERT INTO Country(code, country_name, gdp, inflation) VALUES"
			      		+ "(" + "'" + code +"',"
			      		+ "'" + name +"',"
			      		+ gdp + ","
			      		+ inflation + ");";
			    	     
					ResultSet rss = listCountries(cn, stt);
					boolean exec = true;
					while(rss.next()){
						if(rss.getString("code").equals(code))
							exec = false;
					}
					
					if(exec)
						stt.executeUpdate(query_2);
					else
					      System.out.println("Country already exists");
			      break;
			    case 3:
			      System.out.println("Find via GDP and Inflation");
			      Statement sttt = cn.createStatement();
			      int display;
			      double g, i;
			      
			      System.out.println("Number of countries to display:");
			      display = input.nextInt();
			      System.out.println("Minimum per capita gdp (USD)..:");
			      g = input.nextDouble();
			      System.out.println("Maximum inflation (pct).......:"); 
			      i = input.nextDouble();
			      
			      String query_3 = "SELECT * FROM Country " +
			      "where gdp >= " + g + " AND inflation <= " + i +" ORDER BY gdp DESC, inflation ASC LIMIT " +  display + " ;";
			      
			      ResultSet rsss = sttt.executeQuery(query_3);
			      
			      while(rsss.next()){
				      System.out.println(rsss.getString("country_name") + " (" + rsss.getString("code") + "), " +  rsss.getDouble("gdp") +", " + 
				    		  rsss.getDouble("inflation") + ".");
			      }
			      break;
			    case 4:
				      System.out.println("Udpate GDP/INFLATION");
				      Statement stttt = cn.createStatement();
				      
				      String c;
				      double gg, ii;
				      System.out.println("Country code................:");
				      c = input.next();
				      System.out.println("Country per capita gdp (USD):");
				      gg = input.nextDouble();
				      System.out.println("Country inflation (pct).....:"); 
				      ii = input.nextDouble();
				      
				      String query_4 = "UPDATE Country " +
				      "SET gdp = " + gg +
				      ", inflation = " + ii +
				      " where code = " + "'" + c + "'" + ";";
				      
				      ResultSet rssss = listCountries(cn, stttt);
						boolean execc = true;
						while(rssss.next()){
							if(rssss.getString("code").equals(c))
								exec = false;
						}
						
						if(execc)
							stttt.executeUpdate(query_4);
						else
						      System.out.println("Country does not exist, can't do it.");
				      break;
			    case 5:
				      System.out.println("Exit");
			    	 System.exit(0);
				      break;
			    default:
			      System.out.println("Invalid selection");
			    }
	  }
}
	
	/**
	 * Gets Results Set in so we can list all of the countries
	 * @param cn
	 * @param st
	 * @return
	 * @throws SQLException
	 */
	private static ResultSet listCountries(Connection cn, Statement st) throws SQLException{
		String query = "SELECT * FROM Country";
		
		return st.executeQuery(query);
		
		
	}

}
