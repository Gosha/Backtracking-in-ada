with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
package body Graph is
   function Create_Node (Graph  : in Graph_Type_Access;
			 Colour : in String := "lightgray ") return Node_Id_Type is
   begin
      Graph.all.Node_Length := Graph.all.Node_Length + 1;
      Graph.all.Node_List(Graph.Node_Length) := Node_Type'(Graph.Node_Length, Colour);
      return Graph.all.Node_Length;
   end Create_Node;

   procedure Change_Node(Graph  : in Graph_Type_Access;
			 Node   : in Node_Id_Type;
			 Colour : in String) is
   begin
      Graph.all.Node_List(Node).Colour := Colour;
   end Change_Node;

   procedure Add_Connection (Graph : in Graph_Type_Access;
			     From  : in Node_Id_Type;
			     To    : in Node_Id_Type) is
   begin
      Graph.all.Connection_Length := Graph.all.Connection_Length + 1;
      Graph.all.Connection_List(Graph.Connection_Length) := Connection_Type'(From, To);
   end Add_Connection;

   procedure Put (Node : in Node_Type) is
   begin
      Put(Tab);
      Put(Node.Id, 0);
      Put(" [color=");
      Put(Node.Colour);
      Put("];");
   end Put;

   procedure Put(Connection : in Connection_Type) is
   begin
      Put(Tab);
      Put(Connection.From, 0);
      Put(" -> ");
      Put(Connection.To, 0);
      Put(";");
   end Put;

   procedure Put (Graph : in Graph_Type_Access) is
   begin
      Put_Line("digraph G {");

      for I in Graph.Node_List'First .. Graph.Node_Length loop
	 Put(Graph.Node_List(I));
	 New_Line;
      end loop;
      New_Line;

      for I in Graph.Connection_List'First .. Graph.Connection_Length loop
	 Put(Graph.Connection_List(I));
	 New_Line;
      end loop;

      Put_Line("}");
   end Put;

end Graph;
