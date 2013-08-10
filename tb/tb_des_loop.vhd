--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:47:33 02/21/2013
-- Design Name:   
-- Module Name:   C:/Users/vmr/Desktop/crypto_ng/des/dram/desl/tb_des_loop.vhd
-- Project Name:  desl
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: des_loop
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_des_loop IS
END tb_des_loop;
 
ARCHITECTURE behavior OF tb_des_loop IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT des_loop
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         mode : IN  std_logic;
         key_in : IN  std_logic_vector(55 downto 0);
         blk_in : IN  std_logic_vector(63 downto 0);
         blk_out : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal mode : std_logic := '0';
   signal key_in : std_logic_vector(55 downto 0) := (others => '0');
   signal blk_in : std_logic_vector(63 downto 0) := (others => '0');

 	--Outputs
   signal blk_out : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: des_loop PORT MAP (
          clk => clk,
          rst => rst,
          mode => mode,
          key_in => key_in,
          blk_in => blk_in,
          blk_out => blk_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for clk_period/2 + clk_period;
		mode <= '0';
		blk_in <= X"4E45565251554954";
		key_in <= "00000000111111110000000000101010010100000000000110010100";
		rst <= '1';
		wait for clk_period;
		rst <= '0';
      wait for clk_period*16;
		
		assert blk_out = X"72c6e3c6d2168e78"
			report "ENCRYPT ERROR" severity FAILURE;
			
		wait for clk_period;

		mode <= '1';
		blk_in <=  X"72c6e3c6d2168e78";
		key_in <=  "00000000111111110000000000101010010100000000000110010100";
		rst <= '1';
		wait for clk_period;
		rst <= '0';
    wait for clk_period*16;		

		assert blk_out = X"4E45565251554954"
			report "DECRYPT ERROR" severity FAILURE;

      wait;
   end process;

END;
