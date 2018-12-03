vcd files $RESULTS_FOLDER/fifo.vcd $RESULTS_FOLDER/fifoc.vcd $RESULTS_FOLDER/fifod.vcd $RESULTS_FOLDER/lbdr.vcd $RESULTS_FOLDER/arbiter.vcd $RESULTS_FOLDER/xbar.vcd $RESULTS_FOLDER/lbdr.vcd
# the grant signals for the arbiter
vcd add -file $RESULTS_FOLDER/arbiter.vcd sim/:tb_router:R_5:*CONTROL_PART?allocator_unit?grant_?_?_sig* "sim/:tb_router:R_5:valid_out*"
# all tx ports for the xbar
vcd add -file $RESULTS_FOLDER/xbar.vcd "sim/:tb_router:R_5:TX_*"
# all Req signals for the lbdr
vcd add -file $RESULTS_FOLDER/lbdr.vcd sim/:tb_router:R_5:*CONTROL_PART?Req??* sim/:tb_router:R_5:*CONTROL_PART?ROUTING_TABLE*
# credit counters, pointer and data for the fifos
vcd add  -file $RESULTS_FOLDER/fifo.vcd sim/:tb_router:R_5:?FIFO_??credit_out_FF_in*   "sim/:tb_router:R_5:?FIFO_??write_pointer*" "sim/:tb_router:R_5:?FIFO_??read_pointer*"  sim/:tb_router:R_5:*FIFO_D_out_*
# controllpath fifo
vcd add  -file $RESULTS_FOLDER/fifoc.vcd sim/:tb_router:R_5:?FIFO_??credit_out_FF_in*   "sim/:tb_router:R_5:?FIFO_??write_pointer*" "sim/:tb_router:R_5:?FIFO_??read_pointer*"  
# datapath fifo
vcd add  -file $RESULTS_FOLDER/fifod.vcd  sim/:tb_router:R_5:*FIFO_D_out_*
