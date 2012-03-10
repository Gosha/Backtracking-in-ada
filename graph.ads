package Graph is
   subtype Node_Id_Type is Natural;

   type Node_Type is record
      Id : Node_Id_Type := 0;
      Colour : String(1..10); -- Undefined?
      -- Other settings
   end record;

   type Connection_Type is record
      From : Node_Id_Type;
      To   : Node_Id_Type;
   end record;

   type Connection_List_Type is array (Natural range <>) of Connection_Type;

   type Node_Array_Type is array (Natural range <>) of Node_Type;

   type Graph_Type is record
      Node_Length : Natural := 0;
      Connection_Length : Natural := 0;
      Node_List : Node_Array_Type(1 .. 100000); -- Generic?
      Connection_List : Connection_List_Type(1 .. 100000);
   end record;

   type Graph_Type_Access is access Graph_Type;

   function Create_Node (Graph  : in Graph_Type_Access;
			 Colour : in String := "lightgray ") return Node_Id_Type;

   procedure Change_Node(Graph  : in Graph_Type_Access;
			 Node   : in Node_Id_Type;
			 Colour : in String);

   procedure Add_Connection (Graph : in Graph_Type_Access;
			     From  : in Node_Id_Type;
			     To    : in Node_Id_Type);

   procedure Put (Node : in Node_Type);
   procedure Put (Connection : in Connection_Type);
   procedure Put (Graph : in Graph_Type_Access);

   Tab : String := "    ";
end Graph;
