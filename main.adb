with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with Graph; use Graph;
procedure Main is

   type Package_Type is record
      W : Integer := 0;
      M : Integer := 0;
   end record;

   type Packages_Type is array (1..20) of Package_Type;
   type Packages_Access is access Packages_Type;
   type Used_Type is array(1..20) of Natural;

   subtype Solution_Type is Integer;

   type Partial_Solution_Type is record
      Packages : Packages_Access;
      Used : Used_Type;
      Length : Natural := 0;
      Current_Sum : Package_Type;
   end record;

   procedure Add (Left: in out Package_Type; Right : in Package_Type) is
   begin
      Left.W := Left.W + Right.W;
      Left.M := Left.M + Right.M;
   end Add;

   procedure Subtract (Left : in out Package_Type; Right : in Package_Type) is
   begin
      Left.W := Left.W - Right.W;
      Left.M := Left.M - Right.M;
   end Subtract;

   procedure Put(Data : in Partial_Solution_Type) is
   begin
      Put("Length: "); Put(Data.Length, 0);
      New_Line;
      Put_Line("No    $    kg");

      for I in 1..Data.Length loop
	 Put(Data.Used(I),2);
	 Put(Data.Packages.all(Data.Used(I)).M, 5);
	 Put(Data.Packages.all(Data.Used(I)).W, 6); New_Line;
      end loop;

      Put_Line("-------------");
      Put("S: ");
      Put(Data.Current_Sum.M, 4);
      Put(Data.Current_Sum.W, 6);
      New_Line;
      New_Line;
   end Put;

   function Root return Partial_Solution_Type is
      Tmp_Partial_Solution : Partial_Solution_Type;
   begin
      Tmp_Partial_Solution.Packages := new Packages_Type'(Package_Type'(15, 3),
							  Package_Type'(12, 4),
							  Package_Type'(13 , 2),
							  Package_Type'(1 , 1),
							  Package_Type'(1, 10),
							  Package_Type'(1 , 2),
							  Package_Type'(5 , 2),
							  Package_Type'(15 , 2),
							  Package_Type'(3 , 2),
							  Package_Type'(5 , 2),
							  Package_Type'(10 , 2),
							  Package_Type'(12 , 2),
							  Package_Type'(20 , 2),
							  Package_Type'(10 , 2),
							  Package_Type'(13 , 2),
							  Package_Type'(7 , 2),
							  Package_Type'(8 , 2),
							  Package_Type'(9 , 2),
							  Package_Type'(2 , 2),
							  Package_Type'(7 , 2));
      return Tmp_Partial_Solution;
   end Root;

   type Reject_Type is access function (Solution : in Solution_Type;
					Data : in Partial_Solution_Type) return Boolean;

   function Dumb_Reject (Solution : in Solution_Type;
			 Data : in Partial_Solution_Type) return Boolean is
   begin
      return False;
   end Dumb_Reject;

   function Smart_Reject (Solution : in Solution_Type;
			  Data : in Partial_Solution_Type) return Boolean is
      Sumw : Integer := 0;
   begin
      if Data.Current_Sum.W > Solution then
   	 return True;
      else
   	 return False;
      end if;
   end Smart_Reject;

   function Smarter_Reject (Solution : in Solution_Type;
			    Data : in Partial_Solution_Type) return Boolean is
      Least : Integer := 0;
   begin
      Least := Solution - Data.Current_Sum.W;

      if not Smart_Reject(Solution, Data) then
	 --  Put(Data);
	 --  Put(Least); New_Line;
	 if Data.Length > 0 and Least > 0 then
	    -- Is there any other element that can satisfy the problem?
	    for I in Data.Used(Data.Length)..Data.Packages.all'Length loop
	       if Data.Packages(I).W <= Least then
		  return False;
	       end if;
	    end loop;
	    return True;
	 else
	    return False;
	 end if;
      end if;
      return True;
   end Smarter_Reject;

   function Accepted (Solution : in Solution_Type;
		      Data : in Partial_Solution_Type) return Boolean is
   begin
      if Data.Current_Sum.W = Solution then
   	 return True;
      else
   	 return False;
      end if;
   end;

   function Next (Solution : in Solution_Type;
		  Data : in Partial_Solution_Type) return Partial_Solution_Type is
      Tmp_Data : Partial_Solution_Type := Data;
   begin
      -- Last iteration
      if Tmp_Data.Used(Tmp_Data.Length) = Tmp_Data.Packages.all'Length then
	 -- Go over boundry to notify Empty()
	 Tmp_Data.Used(Tmp_Data.Length) := Tmp_Data.Packages.all'Length + 1;
      else
	 Subtract(Tmp_Data.Current_Sum, Tmp_Data.Packages.all(Tmp_Data.Used(Tmp_Data.Length)));
	 Tmp_Data.Used(Tmp_Data.Length) := Tmp_Data.Used(Tmp_Data.Length) + 1;
	 Add(Tmp_Data.Current_Sum, Tmp_Data.Packages.all(Tmp_Data.Used(Tmp_Data.Length)));
      end if;

      return Tmp_Data;
   end Next;

   function First (Solution : in Solution_Type;
   		   Data : in Partial_Solution_Type) return Partial_Solution_Type is
      Tmp_Data : Partial_Solution_Type := Data;
   begin
      -- First iteration
      if Data.Length < 1 then
	 Tmp_Data.Length := 1;
	 Tmp_Data.Used(1) := 1;
	 Add(Tmp_Data.Current_Sum, Tmp_Data.Packages.all(1));

      -- Last iteration
      elsif Tmp_Data.Used(Tmp_Data.Length) = Tmp_Data.Packages.all'Length then
	 -- Go over the length of the problem to notify Empty()
	 Tmp_Data.Used(Tmp_Data.Length) := Tmp_Data.Packages.all'Length + 1;

      -- First of next recursion
      else
	 -- Add next unused Package
	 Tmp_Data.Used(Tmp_Data.Length + 1) := Tmp_Data.Used(Tmp_Data.Length) + 1;
	 Tmp_Data.Length := Tmp_Data.Length + 1;
	 Add(Tmp_Data.Current_Sum, Tmp_Data.Packages.all(Tmp_Data.Used(Tmp_Data.Length)));
      end if;

      return Tmp_Data;

   end First;

   function Empty(Solution : in Solution_Type;
		  Data : in Partial_Solution_Type) return Boolean is
   begin
      return Data.Length > Data.Packages.all'Length or else Data.Used(Data.Length) > Data.Packages.all'Length;
   end Empty;


   procedure Output (Solution : in Solution_Type;
		     Data: in Partial_Solution_Type) Is
   begin
      Put(Data);
      null;
   end Output;

   procedure Bt (P : in Solution_Type;
		 C : in Partial_Solution_Type;
		 Rejected : in Reject_Type) is
      S : Partial_Solution_Type;
   begin
      if Rejected(P, C) then
	 return;
      end if;
      if Accepted(P, C) then
	 --Output(P, C);
	 return;
      end if;
      S := First(P, C);
      while not Empty(P, S) loop
	 Bt(P, S, Rejected);
	 S := Next(P, S);
      end loop;
   end Bt;

   Nodec : Integer := 0;
   procedure Graph_Bt (P : in Solution_Type;
		       C : in Partial_Solution_Type;
		       Rejected : in Reject_Type;
		       Graph : in Graph_Type_Access;
		       Last_Node : in Node_Id_Type) is
      S : Partial_Solution_Type;
      This_Node : Node_Id_Type;
   begin
      Nodec := Nodec + 1;
      if Rejected(P, C) then
	 This_Node := Create_Node(Graph, "red       ");
	 Add_Connection(Graph, Last_Node, This_Node);
	 return;
      end if;
      if Accepted(P, C) then
	 This_Node := Create_Node(Graph, "green     ");
	 Add_Connection(Graph, Last_Node, This_Node);
	 return;
      else
	 This_Node := Create_Node(Graph);
	 Add_Connection(Graph, Last_Node, This_Node);
      end if;

      S := First(P, C);
      if Empty(P, First(P, C)) then
	 Change_Node(Graph, This_Node, "blue      ");
      end if;
      while not Empty(P, S) loop
	 Graph_Bt(P, S, Rejected, Graph, This_Node);
	 S := Next(P, S);
      end loop;

   end Graph_Bt;

   P : Solution_Type := 25;
   Loops : Integer := 1;
   Graph : Graph_Type_Access;
   Root_Node : Node_Id_Type;


begin
   Graph := new Graph_Type;
   Root_Node := Create_Node(Graph);
   for I in 1..Loops loop
      --  if I mod (Loops/100) = 0 then
      --  	 Put(I/(Loops/100)); New_Line;
      --  end if;
      Graph_Bt(P, Root, Smart_Reject'Access, Graph, Root_Node);
   end loop;
   Put(Graph);
   --Put(Nodec);
end Main;
