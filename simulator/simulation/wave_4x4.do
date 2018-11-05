onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {NoC RX} -color green -radix decimal :tb_router:RX_L_5
add wave -noupdate -group {NoC TX} -color green -radix decimal :tb_router:TX_L_5
add wave -noupdate -group {Link NoC RX} -color green -radix decimal :tb_router:R_5:RX_N
add wave -noupdate -group {Link NoC RX} -color green -radix decimal :tb_router:R_5:RX_E
add wave -noupdate -group {Link NoC RX} -color green -radix decimal :tb_router:R_5:RX_W
add wave -noupdate -group {Link NoC RX} -color green -radix decimal :tb_router:R_5:RX_S
add wave -noupdate -group {Link NoC TX} -color green -radix decimal :tb_router:R_5:TX_N
add wave -noupdate -group {Link NoC TX} -color green -radix decimal :tb_router:R_5:TX_E
add wave -noupdate -group {Link NoC TX} -color green -radix decimal :tb_router:R_5:TX_W
add wave -noupdate -group {Link NoC TX} -color green -radix decimal :tb_router:R_5:TX_S
add wave -noupdate -group {NoC Detailed} -color Gold -radix decimal :tb_router:RX_L_5
add wave -noupdate -group {NoC Detailed} -color Gold :tb_router:valid_in_L_5
add wave -noupdate -group {NoC Detailed} -color Gold :tb_router:credit_out_L_5
add wave -noupdate -group {NoC Detailed} -color Violet -radix decimal :tb_router:TX_L_5
add wave -noupdate -group {NoC Detailed} -color Violet :tb_router:valid_out_L_5
add wave -noupdate -group {NoC Detailed} -color Violet :tb_router:credit_in_L_5
add wave -noupdate -group {NoC Empty_Sigs} :tb_router:R_5:FIFO_N:empty
add wave -noupdate -group {NoC Empty_Sigs} :tb_router:R_5:FIFO_E:empty
add wave -noupdate -group {NoC Empty_Sigs} :tb_router:R_5:FIFO_W:empty
add wave -noupdate -group {NoC Empty_Sigs} :tb_router:R_5:FIFO_S:empty
add wave -noupdate -group {NoC Empty_Sigs} :tb_router:R_5:FIFO_L:empty
add wave -noupdate -group {NoC Full_Sigs} :tb_router:R_5:FIFO_N:full
add wave -noupdate -group {NoC Full_Sigs} :tb_router:R_5:FIFO_E:full
add wave -noupdate -group {NoC Full_Sigs} :tb_router:R_5:FIFO_W:full
add wave -noupdate -group {NoC Full_Sigs} :tb_router:R_5:FIFO_S:full
add wave -noupdate -group {NoC Full_Sigs} :tb_router:R_5:FIFO_L:full
add wave -noupdate -group {LBDR CX} -color green :tb_router:R_5:LBDR_N:Cx
add wave -noupdate -group {LBDR CX} -color green :tb_router:R_5:LBDR_E:Cx
add wave -noupdate -group {LBDR CX} -color green :tb_router:R_5:LBDR_W:Cx
add wave -noupdate -group {LBDR CX} -color green :tb_router:R_5:LBDR_S:Cx
add wave -noupdate -group {LBDR CX} -color Gold :tb_router:R_5:LBDR_L:Cx
add wave -noupdate -group {Faulty Counters} -color green :tb_router:R_5:CT_N:faulty_counter_out
add wave -noupdate -group {Faulty Counters} -color green :tb_router:R_5:CT_E:faulty_counter_out
add wave -noupdate -group {Faulty Counters} -color green :tb_router:R_5:CT_W:faulty_counter_out
add wave -noupdate -group {Faulty Counters} -color green :tb_router:R_5:CT_S:faulty_counter_out
add wave -noupdate -group {Faulty Counters} -color green :tb_router:R_5:CT_L:faulty_counter_out
add wave -noupdate -group {Healthy Counters} -color green :tb_router:R_5:CT_N:healthy_counter_out
add wave -noupdate -group {Healthy Counters} -color green :tb_router:R_5:CT_E:healthy_counter_out
add wave -noupdate -group {Healthy Counters} -color green :tb_router:R_5:CT_W:healthy_counter_out
add wave -noupdate -group {Healthy Counters} -color green :tb_router:R_5:CT_S:healthy_counter_out
add wave -noupdate -group {Healthy Counters} -color green :tb_router:R_5:CT_L:healthy_counter_out
add wave -noupdate -group {CT:state} -color green :tb_router:R_5:CT_N:state
add wave -noupdate -group {CT:state} -color green :tb_router:R_5:CT_E:state
add wave -noupdate -group {CT:state} -color green :tb_router:R_5:CT_W:state
add wave -noupdate -group {CT:state} -color green :tb_router:R_5:CT_S:state
add wave -noupdate -group {CT:state} -color green :tb_router:R_5:CT_L:state
add wave -noupdate -group {R_5: FIFO Checkers ORed} -color green :tb_router:R_5:N_FIFO_checkers_ORed
add wave -noupdate -group {R_5: FIFO Checkers ORed} -color green :tb_router:R_5:E_FIFO_checkers_ORed
add wave -noupdate -group {R_5: FIFO Checkers ORed} -color green :tb_router:R_5:W_FIFO_checkers_ORed
add wave -noupdate -group {R_5: FIFO Checkers ORed} -color green :tb_router:R_5:S_FIFO_checkers_ORed
add wave -noupdate -group {R_5: FIFO Checkers ORed} -color green :tb_router:R_5:L_FIFO_checkers_ORed
add wave -noupdate -group {R_5: LBDR Checkers ORed} -color green :tb_router:R_5:N_LBDR_checkers_ORed
add wave -noupdate -group {R_5: LBDR Checkers ORed} -color green :tb_router:R_5:E_LBDR_checkers_ORed
add wave -noupdate -group {R_5: LBDR Checkers ORed} -color green :tb_router:R_5:W_LBDR_checkers_ORed
add wave -noupdate -group {R_5: LBDR Checkers ORed} -color green :tb_router:R_5:S_LBDR_checkers_ORed
add wave -noupdate -group {R_5: LBDR Checkers ORed} -color green :tb_router:R_5:L_LBDR_checkers_ORed
add wave -noupdate -group {Allocator Checkers ORed} -color green :tb_router:R_5:Allocator_checkers_ORed
add wave -noupdate -color green :tb_router:R_5:link_faults
add wave -noupdate -color green :tb_router:R_5:turn_faults
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:N2E_turn_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:N2W_turn_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:E2N_turn_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:E2S_turn_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:W2N_turn_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:W2S_turn_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:S2E_turn_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:S2W_turn_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:N2S_path_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:S2N_path_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:E2W_path_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:W2E_path_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:L2N_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:L2E_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:L2W_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:L2S_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:N2L_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:E2L_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:W2L_fault
add wave -noupdate -group {Turn Faults for R_5} -color green :tb_router:R_5:S2L_fault
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_N2E_turn_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_N2W_turn_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_E2N_turn_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_E2S_turn_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_W2N_turn_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_W2S_turn_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_S2E_turn_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_S2W_turn_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_N2S_path_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_S2N_path_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_E2W_path_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_W2E_path_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_L2N_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_L2E_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_L2W_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_L2S_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_N2L_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_E2L_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_W2L_fault:state
add wave -noupdate -group {CHK_CT:state} -color green :tb_router:R_5:CHK_CT_S2L_fault:state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 396
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {147 ns}
