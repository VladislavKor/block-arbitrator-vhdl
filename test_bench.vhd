LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.math_real.all;
 
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 
 
    COMPONENT arbitrator
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         i1 : IN  std_logic_vector(6 downto 0);
         o1 : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;   

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal i1 : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal o1 : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	signal counter : std_logic_vector(6 downto 0):="0000000";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: arbitrator PORT MAP (
          clk => clk,
          rst => rst,
          i1 => i1,
          o1 => o1
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	-- Reset
	rst <= '1', '0' after clk_period;
	
	--Stimulus process
	stimulus_process :process
	begin
		wait for clk_period;
		counter <= counter + '1';
	end process;

i1 <= counter;

END;
