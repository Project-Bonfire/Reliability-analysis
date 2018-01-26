vcd files $RESULTFOLDER/fifo.vcd $RESULTFOLDER/fifoc.vcd $RESULTFOLDER/fifod.vcd $RESULTFOLDER/rtable.vcd $RESULTFOLDER/arbiter.vcd $RESULTFOLDER/xbar.vcd
# the grant signals for the arbiter
vcd add -file $RESULTFOLDER/arbiter.vcd sim/:tb_router:R_5:*CONTROL_PART?allocator_unit?grant_?_?_sig* "sim/:tb_router:R_5:valid_out*"
# all tx ports for the xbar
vcd add -file $RESULTFOLDER/xbar.vcd "sim/:tb_router:R_5:TX_*"
# all Req signals for the lbdr
vcd add -file $RESULTFOLDER/rtable.vcd sim/:tb_router:R_5:*CONTROL_PART?Req??* sim/:tb_router:R_5:*CONTROL_PART?ROUTING_TABLE*
# credit counters, pointer and data for the fifos
vcd add  -file $RESULTFOLDER/fifo.vcd sim/:tb_router:R_5:?FIFO_??credit_out_FF_in*   "sim/:tb_router:R_5:?FIFO_??write_pointer*" "sim/:tb_router:R_5:?FIFO_??read_pointer*"  sim/:tb_router:R_5:*FIFO_D_out_*
# controllpath fifo
vcd add  -file $RESULTFOLDER/fifoc.vcd sim/:tb_router:R_5:?FIFO_??credit_out_FF_in*   "sim/:tb_router:R_5:?FIFO_??write_pointer*" "sim/:tb_router:R_5:?FIFO_??read_pointer*"  
# datapath fifo
vcd add  -file $RESULTFOLDER/fifod.vcd  sim/:tb_router:R_5:*FIFO_D_out_*