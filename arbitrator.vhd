library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity arbitrator is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           i1 : in  STD_LOGIC_VECTOR (6 downto 0);
           o1 : out  STD_LOGIC_VECTOR (6 downto 0));
end arbitrator;

architecture Behavioral of arbitrator is

	signal device_num: std_logic_vector(6 downto 0):="0000000";
	
	type prio is array (0 to 6) of integer range 0 to 6;
	
	shared variable priority : prio := (0,1,2,3,4,5,6);
	shared variable prio_buffer: prio := (0,0,0,0,0,0,0);
	
	shared variable choice_device, j, k : integer;

begin
	
	process(clk, rst)
   begin
		if rst = '1' then
			device_num <= "0000000";
			priority := (0,1,2,3,4,5,6);
			prio_buffer := (0,0,0,0,0,0,0);
			choice_device := 0;
		elsif rising_edge (clk) then	
			prio_buffer := priority;
			
			for i in 0 to 6
			loop
				if i1(priority(i)) = '1' then
					device_num <= "0000000";
					device_num(priority(i)) <= '1';
					choice_device := priority(i);
					k := i;
					exit;
				end if;
			end loop;
			
			if	k /= 6 then
				priority(0) := priority(k + 1);
				priority(6) := choice_device;
				
				
				j := 1;
				for i in 0 to 6
				loop
					if	((prio_buffer(i) /= priority(0)) and (prio_buffer(i) /= priority(6))) then
						priority(j) := prio_buffer(i);
						j := j + 1;
					end if;
				end loop;
			end if;
			
		end if;
	end process;
	
	o1 <= device_num;
	
end Behavioral;