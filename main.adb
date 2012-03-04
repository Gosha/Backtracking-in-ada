with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure Main is
      
   type Package_Type is record
      W : Integer;
      M : Integer;
   end record;
   
   subtype Bag_Type is Package_Type;
   
   type Packages_Type is array (1..20) of Package_Type;
   type Packages_Access is access Packages_Type;
   type Used_Type is array(1..20) of Natural;
   
   subtype Solution_Type is Integer;
   
   type Partial_Solution_Type is record
      Packages : Packages_Access;
      Used : Used_Type;
      Length : Natural;
   end record;
   
   procedure Put(Data : in Partial_Solution_Type) is
      Sum,sumw : Integer := 0;
   begin
      Put("Length: "); Put(Data.Length, 0);
      New_Line;
      Put_Line("No    $    kg");
      for I in 1..Data.Length loop
	 Put(Data.Used(I),2); 
	 Put(Data.Packages.all(Data.Used(I)).M, 5);
	 Put(Data.Packages.all(Data.Used(I)).W, 6); New_Line;
	 Sum := Sum + Data.Packages.all(Data.Used(I)).M;
	 Sumw := Sumw + Data.Packages.all(Data.Used(I)).W;
      end loop;
      
      Put_Line("-------------");
      Put("S: "); Put(Sum, 4); Put(Sumw, 6);
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
      Tmp_Partial_Solution.Length := 0;
      return Tmp_Partial_Solution;
   end Root;
   
   function Rejected (Solution : in Solution_Type;
		      Data : in Partial_Solution_Type) return Boolean is
      Sumw : Integer := 0;
   begin
      --return False;
      for D in 1 .. Data.Length loop
	 Sumw := Sumw + Data.Packages.all(Data.Used(D)).W;
      end loop;
      if Sumw > Solution then
	 --Put_Line("Rejected!");
   	 return True;
      else
   	 return False;
      end if;
   end Rejected;
   
   function Accepted (Solution : in Solution_Type;
		      Data : in Partial_Solution_Type) return Boolean is
      Sum : Package_Type := Package_Type'(0, 0);
   begin
      for D in 1 .. Data.Length loop
      	Sum.W := Sum.W + Data.Packages(Data.Used(D)).W;
   	Sum.M := Sum.M + Data.Packages(Data.Used(D)).M;
      end loop;
      if Sum.W = Solution then
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
	 Tmp_Data.Used(Tmp_Data.Length) := Tmp_Data.Used(Tmp_Data.Length) + 1;
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
	 
      -- Last iteration
      elsif Tmp_Data.Used(Tmp_Data.Length) = Tmp_Data.Packages.all'Length then
	 -- Go over the length of the problem to notify Empty()
	 Tmp_Data.Used(Tmp_Data.Length) := Tmp_Data.Packages.all'Length + 1;
	 
      -- First of next rekursion
      else
	 -- Add next unused Package
	 --Put("Tmp_Data.Used(Tmp_Data.Length) + 1;");
	 --Put(Tmp_Data.Used(Tmp_Data.Length) + 1);
	 --New_Line;
	 Tmp_Data.Used(Tmp_Data.Length + 1) := Tmp_Data.Used(Tmp_Data.Length) + 1;
	 Tmp_Data.Length := Tmp_Data.Length + 1;
      end if;
      
      --Put(Tmp_Data);
      return Tmp_Data;
      
   end First;
   
   function Empty(Solution : in Solution_Type;
		  Data : in Partial_Solution_Type) return Boolean is
   begin
      return Data.Length > Data.Packages.all'Length or Data.Used(Data.Length) > Data.Packages.all'Length;
   end Empty;
   

   
   procedure Output (Solution : in Solution_Type;
		     Data: in Partial_Solution_Type) Is
   begin
      Put(Data);
      null;
   end Output;
   
   procedure Bt (P : in Solution_Type; C : in Partial_Solution_Type) is
      S : Partial_Solution_Type;
   begin
      --Put_Line("Rekursion");
      if Rejected(P, C) then 
	 --Put_Line("Rejected");
	 return;
      end if;
      --Put_Line("Inte rejeceted");
      if Accepted(P, C) then 
	 --Output(P, C);
	 null;
      end if;
      S := First(P, C);
      while not Empty(P, S) loop
	 --Put_Line("En loop");
   	 Bt(P, S);
	 --Put(S);
   	 S := Next(P, S);
      end loop;
   end Bt;
   
   P : Solution_Type := 15;
   Loops : Integer := 1000;
begin
   for I in 1..Loops loop
      if I mod (Loops/100)  = 0 then
	 Put(I/(Loops/100)); New_Line;
      end if;
      Bt(P, Root);
   end loop;
   
   
end Main;
