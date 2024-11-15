-------------------------------------------------------------------------
-- Design unit: ALU
-- Description: 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.RISCV_package.all;

entity ALU is
    port( 
        operand1    : in std_logic_vector(31 downto 0);
        operand2    : in std_logic_vector(31 downto 0);
        result      : out std_logic_vector(31 downto 0);
        operation   : in Instruction_format;
        funct       : in std_logic_vector(3 downto 0)   
    );
end ALU;

architecture behavioral of ALU is

    signal temp, op1, op2: UNSIGNED(31 downto 0);

begin

    op1 <= UNSIGNED(operand1);
    op2 <= UNSIGNED(operand2);
    
    result <= STD_LOGIC_VECTOR(temp);

    result <= operand2              when operation = U -- auipc?
              
        
    temp <= op1 - op2               when operation = SUBU or operation = BEQ else
            op1 and op2             when operation = AAND else 
            op1 or  op2             when operation = OOR or operation = ORI else 
            (0=>'1', others=>'0')   when operation = SLT and op1 < op2 else
            (others=>'0')           when operation = SLT and not (op1 < op2) else
            op2(15 downto 0) & x"0000"           when operation = LUI else
            op1 + op2;    -- default for ADDU, ADDIU, SW, LW   
    
end behavioral;

