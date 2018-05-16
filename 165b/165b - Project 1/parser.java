//This class was created by Kevin Thai, Emmeline Tsen, and Amanda Ho. Please do not use this class without the written consent from these individuals.

package zest;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.regex.Pattern;

public class parser {
	public static void main(String[] args) throws IOException {

		File filename = new File("mondial.sql");
		Scanner s = new Scanner(filename);

		// tableNames will contain a list of all the tables from the schema
		ArrayList<String> tableNames = new ArrayList<String>();
		// attNames will contain a list of Nodes, each of which has an attibute for a given table and whether or not that attribute is a primary key
		ArrayList<Node> attNames = new ArrayList<Node>();
		// edgesFK will contain a list of FKEdges, each of which represents an edge from a startNode to an endNode
		ArrayList<FKEdge> edgesFK = new ArrayList<FKEdge>();
		
		String curTable = null;
		while (s.hasNextLine()) {

			if (s.hasNext("CREATE")) {
				s.next();
				if (s.hasNext("TABLE")) {
					s.next();
					curTable = s.next();
					tableNames.add(curTable);
				}
			}

			else if (s.findInLine("CHECK") != null) {
			}

			else {
				boolean regularAtt = true;
				String firstWord = s.next().toString()
						.replaceAll("[-+.^:,()]", "");

				if (s.findInLine("PRIMARY KEY") != null) { // for lines with primary keys
					regularAtt = false; 
					
					if (firstWord.equals("CONSTRAINT")) {
						String temp = s.next().toString()
								.replaceAll("[-+.^:,()]", "");
						while (temp.contains(";") == false
								&& temp.equals("CONSTRAINT") == false) {
							Node oldNode = makeNode(curTable, temp, false);
							attNames.remove(oldNode);
							Node newNode = makeNode(curTable, temp, true);
							attNames.add(newNode);
							//System.out.println(temp);
							temp = s.next().toString()
									.replaceAll("[-+.^:,()]", "");
						}
						if (temp.equals("CONSTRAINT") == false && temp.equals(";") == false)
						{
							temp = temp.toString().replaceAll(";","");
							Node oldNode = makeNode(curTable, temp, false);
							attNames.remove(oldNode);
							Node newNode = makeNode(curTable, temp, true);
							attNames.add(newNode);
							//System.out.println(temp.toString().replaceAll(";",""));
						}
					}
					// e.g. --> Code VARCHAR(4) CONSTRAINT CountryKey PRIMARY KEY
					else {
						Node myNode = makeNode(curTable, firstWord, true);
						attNames.add(myNode);
						// handles a very special case! do not worry about it.
						s.nextLine();
						if(s.findInLine("REFERENCES") != null)
						{
							String fkTable = s.next();
							FKEdge edge = new FKEdge();
							edge.setStart(curTable + "_" + firstWord);
							edge.setEnd(fkTable);
							edgesFK.add(edge);
						}
						else 
							continue;
					}
				}

				if (s.findInLine("FOREIGN KEY") != null) { // for lines with foreign keys
					regularAtt = false;
					
					ArrayList<String> startNodes = new ArrayList<String>();
					
					String temp = s.next().toString().replaceAll("[-+.^:,()]", "");
					while (!temp.equals("REFERENCES"))
					{
						startNodes.add(temp);
						temp = s.next().toString().replaceAll("[-+.^:,()]", "");
					}
					s.useDelimiter(" |\\("); // allows us to grab the table name
					String fkTable = s.next();
					s.reset(); // resets the delimiter pattern
					
					int size = startNodes.size();
					for(int i = 0;  i < size; i++)
					{
						FKEdge edge = new FKEdge();
						edge.setStart(curTable + "_" + startNodes.get(i));
						edge.setEnd(fkTable);
						edgesFK.add(edge);
					}
					
				}
				

				if(regularAtt) { // regular attribute
					if(firstWord.equals("CONSTRAINT")) // e.g. CONSTRAINT OrgNameUnique UNIQUE (Name),
					{
						s.nextLine();
						continue;
					}
					else
					{
						Node myNode = makeNode(curTable, firstWord, false);
						attNames.add(myNode);
					}
					
					// below the code checks for keyword "REFERENCE", and if found signifies a FK and takes appropriate action
					// if REFERENCES is found in the line, add an edge then bottom of while loop will go to next line as planned
					// else, line might have potential important information, need to "continue" to top of while loop
					s.nextLine();
					if(s.findInLine("REFERENCES") != null)
					{
						String fkTable = s.next();
						FKEdge edge = new FKEdge();
						edge.setStart(curTable + "_" + firstWord);
						edge.setEnd(fkTable);
						edgesFK.add(edge);
					}
					else 
						continue;
				}

			}

			if (s.hasNext())
				s.nextLine();
		}

		// Print the attribute nodes
		//System.out.println(attNames);
		// Print the FK edges
		//System.out.println(edgesFK);
		// Print all table names
		//System.out.println(tableNames.toString());
		
		s.close();
		
		// WRITE THE DOT FILE!
		
		File file = new File("myGraph.dot");
		PrintWriter writer = new PrintWriter(file);
		
		// Given tableNames<String>, attNames<Node>, and edgesFK<FKEdge> arrayLists with the information
		
		writer.println("digraph {");
		writer.println("rankdir=BT");
		writer.println();
		writer.println("node [shape=\"box3d\" style=\"filled\" color=\"#0000FF\" fillcolor=\"#EEEEEE\" fontname=\"Courier\" ]");
		writer.println();
		
		for(String str: tableNames)
		{
			writer.println(str);
		}
		
		writer.println();
		writer.println("node [shape=\"box\" style=\"rounded\" width=0 height=0 color=\"#00AA00\" ]");
		writer.println();
		
		for(Node n: attNames)
		{
			writer.print(n.getAttrName() + "[label=\"" + n.getLabel() + "\"");
			if(n.isPrimary())
				writer.println("fontname=\"Courier-Bold\"]");
			else
				writer.println("]");
		}
		
		writer.println();
		writer.println("edge [color=\"#00AA00\" dir=none]");
		writer.println();
		
		for(Node n: attNames)
		{
			writer.println(n.getTableName() + " -> " + n.getAttrName());
		}
		
		writer.println();
		writer.println("edge [color=red dir=foward style=dashed label=\" FK\" fontname=\"Verdana\" fontcolor=red fontsize=10]");
		writer.println();
		
		for(FKEdge f: edgesFK)
		{
			writer.println(f.getStart() + " -> " + f.getEnd());
		}
		
		writer.println();
		writer.println("}");
		writer.close();

	}
	
	// makes a node to be inserted into the attNames ArrayList
	public static Node makeNode(String tableName, String attrName, boolean primary)
	{
		Node myNode = new Node();
		myNode.setTableName(tableName);
		myNode.setAttrName(tableName + "_" + attrName);
		myNode.setLabel(attrName);
		myNode.setPrimary(primary);
		return myNode;
	}
}
