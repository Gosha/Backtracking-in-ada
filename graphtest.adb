with Graph; use Graph;

procedure Graphtest is
   Graph : Graph_Type_Access;
   Root, Node : Node_Id_Type;
begin
   Graph := new Graph_Type;

   Root := Create_Node(Graph, "green     ");
   Node := Create_Node(Graph, "green     ");

   Add_Connection(Graph, Root, Node);
   Add_Connection(Graph, Root, Create_Node(Graph, "red       "));

   Put(Graph);
end Graphtest;
