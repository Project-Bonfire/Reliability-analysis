vcd files $RESULTS_FOLDER/fifoc.vcd $RESULTS_FOLDER/fifod.vcd $RESULTS_FOLDER/lbdr.vcd $RESULTS_FOLDER/arbiter.vcd $RESULTS_FOLDER/xbar.vcd $RESULTS_FOLDER/lbdr.vcd
# the grant signals for the arbiter
vcd add -file $RESULTS_FOLDER/arbiter.vcd "sim/:tb_router:R_5:Grant_??_out" "sim/:tb_router:R_5:valid_out_?" "sim/:tb_router:R_5:Xbar_sel_?_out"
# all tx ports for the xbar
vcd add -file $RESULTS_FOLDER/xbar.vcd "sim/:tb_router:R_5:TX_*"
# all Req signals for the lbdr
vcd add -file $RESULTS_FOLDER/lbdr.vcd "sim/:tb_router:R_5:Req_??_out"
# controlpath fifo
vcd add  -file $RESULTS_FOLDER/fifoc.vcd "sim/:tb_router:R_5:read_pointer_out_?_out"   "sim/:tb_router:R_5:write_pointer_out_?_out" "sim/:tb_router:R_5:write_en_out_?_out"  "sim/:tb_router:R_5:credit_out_?"  "sim/:tb_router:R_5:empty_?_out"
# datapath fifo
vcd add  -file $RESULTS_FOLDER/fifod.vcd  "sim/:tb_router:R_5:FIFO_Data_out_?"
# Router top-level
vcd add -file $RESULTS_FOLDER/top_level.vcd "sim/:tb_router:R_5:credit_out_?"   "sim/:tb_router:R_5:valid_out_?"    "sim/:tb_router:R_5:TX_?"