-- simpleRisc_datapath_lab4.vhd



---------- entity reg_file (correct for simple Risc) DONE ----------
use work.dlx_types.all; 
use work.bv_arithmetic.all;  

entity reg_file is
     port (data_in: in dlx_word; readnotwrite,clock : in bit; 
	   data_out: out dlx_word; reg_number: in register_index );
end entity reg_file; 

architecture behavior of reg_file is
  type reg_type is array (0 to 31) of dlx_word;
  signal registers : reg_type;
begin
  reg_file: process(data_in, readnotwrite, clock, reg_number) is
  begin
      -- If the clock is high
      if clock = '1' then
           -- If the readnotwrite signal is on READ
          if readnotwrite = '1' then 
              -- Assign register value to the output
              data_out <= registers(bv_to_integer(reg_number)) after 15 ns;
           -- If the readnotwrite signal is on WRITE
          else 
              -- Assign the input value to the register number
              registers(bv_to_integer(reg_number)) <= data_in after 15 ns;
          end if;
      end if;
  end process reg_file;
end architecture behavior;

---------- end entity regfile DONE ----------

---------- entity simple_alu (correct for simple risc, different from Aubie) DONE ----------
use work.dlx_types.all; 
use work.bv_arithmetic.all; 

entity simple_alu is 
     generic(prop_delay : Time := 5 ns);
     port(operand1, operand2: in dlx_word; operation: in alu_operation_code; 
          result: out dlx_word; error: out error_code); 
end entity simple_alu; 

-- alu_operation_code values (simpleRisc)
-- 0000 unsigned add
-- 0001 unsigned sub
-- 0010 2's compl add
-- 0011 2's compl sub
-- 0100 2's compl mul
-- 0101 2's compl divide
-- 0110 logical and
-- 0111 bitwise and
-- 1001 bitwise or 
-- 1011 bitwise not (op1)
-- 1100 copy op1 to output
-- 1101 copy op2 to output
-- 1110 output all zero's
-- 1111 output all one's

-- error code values
-- 0000 = no error
-- 0001 = overflow (too big or too small) 
-- 0011 = divide by zero 

architecture behavior of simple_alu is 
begin

    -- ALU operation process
    simple_alu: process(operand1, operand2, operation)
        -- Local variables (and setting initial values)
        variable op_result: dlx_word := (others => '0'); -- Result of the operation
        variable overflow: boolean := false; -- Overflow flag
        variable div_by_zero: boolean := false; -- Division by zero flag
        variable temp_error: error_code := "0000"; -- Error code
    begin
        -- Perform the operation based on the operation code
        case operation is
            -- Unsigned ADD
            when "0000" =>
                bv_addu(operand1, operand2, op_result, overflow);
                if overflow then 
                    temp_error := "0001"; -- Overflow error
                end if;
            -- Unsigned SUB
            when "0001" => 
                bv_subu(operand1, operand2, op_result, overflow);
                if overflow then 
                    temp_error := "0001"; -- Overflow error
                end if;
            -- 2s COMP ADD
            when "0010" =>
                bv_add(operand1, operand2, op_result, overflow);
                if overflow then 
                    temp_error := "0001"; -- Overflow error
                end if;
            -- 2s COMP SUB 
            when "0011" => 
                bv_sub(operand1, operand2, op_result, overflow);
                if overflow then 
                    temp_error := "0001"; -- Overflow error
                end if;
            -- 2s COMP MULTIPLY
            when "0100" => 
                bv_mult(operand1, operand2, op_result, overflow);
                if overflow then 
                    temp_error := "0001"; -- Overflow error
                end if;
            -- 2s COMP DIVIDE
            when "0101" => 
                bv_div(operand1, operand2, op_result, div_by_zero, overflow);
                if div_by_zero then 
                    temp_error := "0010"; -- Division by zero error
                elsif overflow then 
                    temp_error := "0001"; -- Overflow error
                end if;
            -- bitwise AND
            when "0111" => 
                op_result := operand1 and operand2;
            -- bitwise OR
            when "1001" => 
                op_result := operand1 or operand2;
            -- bitwise NOT of operand1 (ignore op2)
            when "1011" => 
                op_result := not operand1;
            -- pass op1 to output
            when "1100" => 
                op_result := operand1;
            -- pass op2 to output
            when "1101" => 
                op_result := operand2;
            -- output all 0s
            when "1110" => 
                op_result := (others => '0');
            -- output all 1s
            when "1111" => 
                op_result := (others => '1');
            -- Default case
            when others => 
                op_result := (others => '0');
                temp_error := "0000"; -- No error
        end case;

        -- Update the result and error
        result <= op_result after prop_delay;
        error <= temp_error after prop_delay;

    end process;
end architecture behavior; 

---------- end entity simple_alu DONE ----------


---------- entity dlx_register DONE ----------
use work.dlx_types.all; 

entity dlx_register is
     generic(prop_delay : Time := 5 ns);
     port(in_val: in dlx_word; clock: in bit; out_val: out dlx_word);
end entity dlx_register;

architecture behavior of dlx_register is
  begin
      dlx_register: process(in_val, clock) is
      begin
          -- If the clock is high
          if clock = '1' then
              -- Assign the input value to the output value
              out_val <= in_val after prop_delay;
          end if;
      end process dlx_register;
  end architecture behavior;

---------- end entity dlx_register DONE ----------

---------- entity pcplusone (correct for simpleRisc) DONE ----------
use work.dlx_types.all;
use work.bv_arithmetic.all; 

entity pcplusone is
	generic(prop_delay: Time := 5 ns); 
	port (input: in dlx_word; clock: in bit;  output: out dlx_word); 
end entity pcplusone; 

architecture behavior of pcplusone is
  begin
      pcplusone: process(input, clock) is
        variable newpc: dlx_word;
        variable error: boolean; 
      begin
          if clock'event and clock = '1' then
                bv_addu(input, "00000000000000000000000000000001", newpc, error);
                output <= newpc after prop_delay;
          end if; 
      end process pcplusone;
end architecture behavior;

---------- end entity pcplusone DONE ----------

---------- entity mux DONE ----------
use work.dlx_types.all; 

entity mux is
     generic(prop_delay : Time := 5 ns);
     port (input_1,input_0 : in dlx_word; which: in bit; output: out dlx_word);
end entity mux;

architecture behavior of mux is
  begin  
      mux: process(input_1, input_0, which) is
      begin
           -- If the which signal is 0
          if which = '0' then
              -- Copy input 0 to the output
              output <= input_0 after prop_delay;
           -- If the which signal is 1
          else
              -- Copy input 1 to the output
              output <= input_1 after prop_delay;
          end if;
      end process mux;
  end architecture behavior;

---------- end entity mux DONE ----------
  
---------- entity memory ----------
use work.dlx_types.all;
use work.bv_arithmetic.all;

entity memory is
  
  port (
    address : in dlx_word;
    readnotwrite: in bit; 
    data_out : out dlx_word;
    data_in: in dlx_word; 
    clock: in bit); 
end memory;

architecture behavior of memory is

begin  -- behavior

  mem_behav: process(address,clock) is
    -- note that there is storage only for the first 1k of the memory, to speed
    -- up the simulation
    type memtype is array (0 to 1024) of dlx_word;
    variable data_memory : memtype;
  begin
    -- fill this in by hand to put some values in there
    -- some instructions
   data_memory(0) :=  "00000000000000000000100000000000";   -- LD R1,R0(100)
   data_memory(1) :=  "00000000000000000000000100000000";
   data_memory(2) :=  "00000000000000000001000000000000";   -- LD R2,R0(101)
   data_memory(3) :=  "00000000000000000000000100000001";
   data_memory(4) :=  "00001000001000100001100100000000";   -- ADD R3,R1,R2
   data_memory(5) :=  "00000100011000000000000000000000";   -- STO R3,R0(102)
   data_memory(6) :=  "00000000000000000000000100000010";
   -- if the 3 instructions above run correctly for you, you get full credit for the assignment


   -- data for the first two loads to use 
    data_memory(256) := X"55550000"; 
    data_memory(257) := X"00005555";
    data_memory(258) := X"ffffffff";

    -- testing for extra credit 
    -- code to test JZ , should be taken unless value of R1 changed
    data_memory(7) := "00001100100000000000000000000000";         -- JMP R4(00000010)
    data_memory(8) := X"00000010";

    data_memory(16):=  "00010000100001010000000000000000";        -- JZ R5,R4(00000000)
    data_memory(17) := X"00000000";

   
    if clock = '1' then
      if readnotwrite = '1' then
        -- do a read
        data_out <= data_memory(bv_to_natural(address)) after 5 ns;
      else
        -- do a write
        data_memory(bv_to_natural(address)) := data_in; 
      end if;
    end if;


  end process mem_behav; 

end behavior;
---------- end entity memory ----------