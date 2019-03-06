input_map = {
    'arbiter' : [
        r'^allocator_unit/credit_in_[LNEWS]',
        r'^allocator_unit/req_[LNEWS]_[LNEWS]',
        r'^allocator_unit/empty_[LNEWS]'
    ],

    'fifoc' : [
        r'^FIFO_[NESLW]/FIFO_CONTROL_PART/valid_in',
        r'^FIFO_[NESLW]/FIFO_CONTROL_PART/read_en_[LNEWS]'
    ],

    'fifod' : [
        r'^FIFO_[NESLW]/FIFO_DATA_PATH/write_en',
        r'^FIFO_[NESLW]/FIFO_DATA_PATH/RX',
        r'^FIFO_[NESLW]/FIFO_DATA_PATH/read_pointer',
        r'^FIFO_[NESLW]/FIFO_DATA_PATH/write_pointer'
    ],

    'lbdr' : [
        r'^LBDR/empty',
        r'^LBDR/flit_type',
        r'^LBDR/curr_addr_y',
        r'^LBDR/curr_addr_x',
        r'^LBDR/dest_addr_y',
        r'^LBDR/dest_addr_x',
        r'^LBDR/grant[LNEWS]'
    ],

    'xbar' : [
        r'^XBAR/North_in',
        r'^XBAR/East_in' ,
        r'^XBAR/West_in' ,
        r'^XBAR/South_in',
        r'^XBAR/Local_in',
        r'^XBAR/sel'
    ]    
}