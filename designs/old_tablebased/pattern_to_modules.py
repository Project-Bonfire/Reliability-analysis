{
        r'^valid_': 'arbiter',
        r'^CONTROL_PART/allocator_unit': 'arbiter',
        r'^allocator_unit': 'arbiter',
        r'^CONTROL_PART/LBDR': 'lbdr',
        r'^CONTROL_PART/Req':'lbdr',
        r'^CONTROL_PART/ROUTING_TABLE': 'lbdr',
        r'^FIFO_[NESLW]/FIFO_comb': 'fifoc',
        r'^FIFO_[NESLW]/FIFO_seq': 'fifod',
        r'^FIFO_[NESLWD]':'fifod',#fallback fifo
        r'^XBAR': 'xbar',
        r'^Xbar': 'xbar'
    }