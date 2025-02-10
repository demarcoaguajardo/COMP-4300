-- Using packages from canvas files.
use work.dlx_types.all;
use work.bv_arithmetic.all;

entity alu is
    generic(prop_delay: Time := 15ns);
    port(
        operand1, 
        operand2: in dlx_word;
        operation: in alu_operation_code;
        result: out dlx_word;
        error: out error_code
    );
end entity alu;

architecture behavior of alu is 
begin

    -- ALU operation process
    process(operand1, operand2, operation)
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