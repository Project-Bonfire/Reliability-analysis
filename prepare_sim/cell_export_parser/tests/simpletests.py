import unittest

import sys
from io import StringIO

from convert_to_pins import main


class MyTestCase(unittest.TestCase):
    def test_expected(self):
        """
        simply comparing the outputs
        :return:
        """
        self.maxDiff = None
        mystdout = StringIO()
        main("test.txt", {
            r'^valid_': 'arbiter',
            r'^CONTROL_PART/allocator_unit': 'arbiter',
            r'^allocator_unit': 'arbiter',
            r'^CONTROL_PART/LBDR': 'lbdr',
            r'^CONTROL_PART/Req': 'lbdr',
            r'^CONTROL_PART/ROUTING_TABLE': 'lbdr',
            r'^FIFO_[NESLW]/FIFO_comb': 'fifoc',
            r'^FIFO_[NESLW]/FIFO_seq': 'fifod',
            r'^FIFO_[NESLWD]': 'fifod',  # fallback fifo
            r'^XBAR': 'xbar',
            r'^Xbar': 'xbar'
        }, mystdout)
        cmpdata = ""
        with open('expected_results.txt', 'r') as myfile:
            cmpdata = myfile.read()
        result = mystdout.getvalue()
        self.assertEqual(cmpdata, result)


if __name__ == '__main__':
    unittest.main()
