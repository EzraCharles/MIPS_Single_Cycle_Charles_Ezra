onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DATA_PATH_TB/clk_tb
add wave -noupdate /DATA_PATH_TB/rst_tb
add wave -noupdate /DATA_PATH_TB/GPIO_o_tb
add wave -noupdate /DATA_PATH_TB/Op_o_tb
add wave -noupdate /DATA_PATH_TB/Funct_o_tb
add wave -noupdate /DATA_PATH_TB/IorD_tb
add wave -noupdate /DATA_PATH_TB/MemWrite_tb
add wave -noupdate /DATA_PATH_TB/IRWrite_tb
add wave -noupdate /DATA_PATH_TB/PCWrite_tb
add wave -noupdate /DATA_PATH_TB/Branch_tb
add wave -noupdate /DATA_PATH_TB/PCSrc_tb
add wave -noupdate /DATA_PATH_TB/ALUSrcA_tb
add wave -noupdate /DATA_PATH_TB/RegWrite_tb
add wave -noupdate /DATA_PATH_TB/MemtoReg_tb
add wave -noupdate /DATA_PATH_TB/RegDst_tb
add wave -noupdate /DATA_PATH_TB/ALUControl_tb
add wave -noupdate /DATA_PATH_TB/ALUSrcB_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_PC_n_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_PC_o_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_Addr_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_Instr_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_Data_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_A_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_B_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_SrcA_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_SrcB_tb
add wave -noupdate -radix hexadecimal /DATA_PATH_TB/M_ALUOut_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {52 ps}
