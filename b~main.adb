pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~main.adb");
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E076 : Short_Integer; pragma Import (Ada, E076, "ada__io_exceptions_E");
   E047 : Short_Integer; pragma Import (Ada, E047, "ada__tags_E");
   E060 : Short_Integer; pragma Import (Ada, E060, "ada__streams_E");
   E078 : Short_Integer; pragma Import (Ada, E078, "interfaces__c_E");
   E080 : Short_Integer; pragma Import (Ada, E080, "interfaces__c__strings_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E062 : Short_Integer; pragma Import (Ada, E062, "system__finalization_root_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__finalization_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "system__storage_pools_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "ada__finalization__heap_management_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "system__os_lib_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "system__pool_global_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "system__file_control_block_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__file_io_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__text_io_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "ada__text_io__generic_aux_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
      LE_Set : Boolean;
      pragma Import (Ada, LE_Set, "__gnat_library_exception_set");
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "ada__text_io__generic_aux__finalize_body");
      begin
         E094 := E094 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__text_io__finalize_body");
      begin
         E055 := E055 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "ada__text_io__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__file_io__finalize_body");
      begin
         E075 := E075 - 1;
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__file_control_block__finalize_spec");
      begin
         E086 := E086 - 1;
         F5;
      end;
      E088 := E088 - 1;
      declare
         procedure F6;
         pragma Import (Ada, F6, "system__pool_global__finalize_spec");
      begin
         F6;
      end;
      E057 := E057 - 1;
      declare
         procedure F7;
         pragma Import (Ada, F7, "ada__finalization__heap_management__finalize_spec");
      begin
         F7;
      end;
      E062 := E062 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "system__finalization_root__finalize_spec");
      begin
         F8;
      end;
      if LE_Set then
         declare
            LE : Ada.Exceptions.Exception_Occurrence;
            pragma Import (Ada, LE, "__gnat_library_exception");
            procedure Raise_From_Controlled_Operation (X : Ada.Exceptions.Exception_Occurrence;  From_Abort : Boolean);
            pragma Import (Ada, Raise_From_Controlled_Operation, "__gnat_raise_from_controlled_operation");
         begin
            Raise_From_Controlled_Operation (LE, False);
         end;
      end if;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");
   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Zero_Cost_Exceptions : Integer;
      pragma Import (C, Zero_Cost_Exceptions, "__gl_zero_cost_exceptions");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Install_Handler;
      pragma Import (C, Install_Handler, "__gnat_install_handler");

      Handler_Installed : Integer;
      pragma Import (C, Handler_Installed, "__gnat_handler_installed");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Zero_Cost_Exceptions := 1;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      if Handler_Installed = 0 then
         Install_Handler;
      end if;

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E076 := E076 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E060 := E060 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      E080 := E080 + 1;
      E078 := E078 + 1;
      Ada.Tags'Elab_Body;
      E047 := E047 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      System.Finalization_Root'Elab_Spec;
      E062 := E062 + 1;
      Ada.Finalization'Elab_Spec;
      E059 := E059 + 1;
      System.Storage_Pools'Elab_Spec;
      E070 := E070 + 1;
      Ada.Finalization.Heap_Management'Elab_Spec;
      E057 := E057 + 1;
      System.Os_Lib'Elab_Body;
      E083 := E083 + 1;
      System.Pool_Global'Elab_Spec;
      E088 := E088 + 1;
      System.File_Control_Block'Elab_Spec;
      E086 := E086 + 1;
      System.File_Io'Elab_Body;
      E075 := E075 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E055 := E055 + 1;
      Ada.Text_Io.Generic_Aux'Elab_Body;
      E094 := E094 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   .\main.o
   --   -L.\
   --   -Lc:/Users/Gosha/Dropbox/ada/testbt\
   --   -LC:\JEWL\source\
   --   -LC:/GNAT/2011/lib/gcc/i686-pc-mingw32/4.5.3/adalib/
   --   -static
   --   -lgnat
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
